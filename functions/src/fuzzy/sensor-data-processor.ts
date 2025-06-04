import * as admin from "firebase-admin";
import { logger } from "firebase-functions";
import { database } from "firebase-functions/v2";
import { Messaging } from "firebase-admin/messaging";

import {
    OPTIMAL_THRESHOLD,
    NOTIFICATION_THRESHOLD,
    WEIGHTS,
    phRanges,
    tdsRanges,
    tempRanges,
    FUZZY_RULES,
} from "./config";
import {
    phMembership,
    tdsMembership,
    tempMembership,
} from "./fuzzy-utils";
import {
    SensorData,
    FuzzyResult,
    FiredRule,
    DeviceStatusInfo,
    CurrentStatusData,
    LastNotificationData,
    Weights,
} from "../types";
import DEVICE_ID from "../lib/constants";

/**
 * Aturan fuzzy berdasarkan tabel aturan dari config.
 * @param tdsFuzzy - Nilai keanggotaan TDS.
 * @param phFuzzy - Nilai keanggotaan pH.
 * @param tempFuzzy - Nilai keanggotaan suhu.
 * @param weights - Bobot sensor dari config.
 * @returns Daftar aturan yang terpicu dengan firing strength.
 */
function fuzzyInference(
    tdsFuzzy: FuzzyResult,
    phFuzzy: FuzzyResult,
    tempFuzzy: FuzzyResult,
    weights: Weights
): FiredRule[] {
    const results: FiredRule[] = [];

    for (const rule of FUZZY_RULES) {
        const [tdsLabel, phLabel, tempLabel, output] = rule;

        if (
            tdsFuzzy.hasOwnProperty(tdsLabel) &&
            phFuzzy.hasOwnProperty(phLabel) &&
            tempFuzzy.hasOwnProperty(tempLabel)
        ) {
            const tdsMembershipValue = tdsFuzzy[tdsLabel];
            const phMembershipValue = phFuzzy[phLabel];
            const tempMembershipValue = tempFuzzy[tempLabel];

            const strength =
                weights.tds * tdsMembershipValue +
                weights.ph * phMembershipValue +
                weights.temp * tempMembershipValue;

            results.push({ firing_strength: strength, output: output });
        }
    }

    if (results.length === 0) {
        logger.warn("Tidak ada aturan fuzzy yang cocok, fallback ke 'Tidak Normal'.");
        results.push({ firing_strength: 0.0, output: "Tidak Normal" });
    }

    return results;
}

/**
 * Fungsi defuzzifikasi menggunakan Weighted Average (Sugeno).
 * @param rules - Daftar aturan yang terpicu dengan firing strength.
 * @returns Nilai defuzzifikasi (antara 0.0 dan 1.0).
 */
function defuzzification(rules: FiredRule[]): number {
    let numerator = 0.0;
    let denominator = 0.0;

    for (const rule of rules) {
        let outputValue = 1.0;
        if (rule.output === "Normal") {
            outputValue = 2.0;
        } else if (rule.output === "Tidak Normal") {
            outputValue = 1.0;
        }

        numerator += rule.firing_strength * outputValue;
        denominator += rule.firing_strength;
    }

    return denominator === 0 ? 0.0 : numerator / denominator;
}

/**
 * Menganalisis lingkungan untuk menentukan status dan sensor tidak normal.
 * Ini adalah fungsi utama yang dipanggil oleh Cloud Function.
 * @param event - Objek event dari pemicu Cloud Function.
 * @param rtdb - Instance Realtime Database dari Firebase Admin SDK.
 * @param fcm - Instance Firebase Cloud Messaging dari Firebase Admin SDK.
 */
export async function processSensorData(
    event: database.DatabaseEvent<database.DataSnapshot, { recordId: string }>,
    rtdb: admin.database.Database,
    fcm: Messaging
): Promise<void> {
    const recordId = event.params.recordId as string;
    const data: SensorData | null = event.data.val();

    if (!data) {
        logger.warn(`❌ Data tidak ada untuk event device LEBIH, record ${recordId}.`);
        return;
    }

    const tds: number | null = data.tank_tds;
    const ph: number | null = data.ph;
    const temp: number | null = data.water_temp;

    if (tds == null || ph == null || temp == null) {
        logger.warn(`❌ Data tidak lengkap untuk device LEBIH, record ${recordId}. TDS: ${tds}, pH: ${ph}, Suhu: ${temp}`);
        return;
    }

    logger.info(`⚙️ Memproses data untuk device LEBIH, record ${recordId}: TDS=${tds}, pH=${ph}, Suhu=${temp}`);

    // ==== Perhitungan Keanggotaan Fuzzy ====
    const tdsFuzzy: FuzzyResult = tdsMembership(tds, tdsRanges);
    const phFuzzy: FuzzyResult = phMembership(ph, phRanges);
    const tempFuzzy: FuzzyResult = tempMembership(temp, tempRanges);

    // ==== Aturan Fuzzy dan Defuzzifikasi ====
    const firedRules: FiredRule[] = fuzzyInference(tdsFuzzy, phFuzzy, tempFuzzy, WEIGHTS);
    const fuzzyScore: number = defuzzification(firedRules);

    const status: string = fuzzyScore > NOTIFICATION_THRESHOLD ? "Normal" : "Tidak Normal";

    // ==== Menentukan Sensor Abnormal ====
    const abnormalReadings: string[] = [];

    const sensorsToCheck = [
        { name: "TDS", value: tds, fuzzy: tdsFuzzy, ranges: tdsRanges, getStatus: (label: string) => label.includes("Rendah") ? "Terlalu Rendah" : "Terlalu Tinggi" },
        { name: "pH", value: ph, fuzzy: phFuzzy, ranges: phRanges, getStatus: (label: string) => label === "Asam" ? "Terlalu Rendah/Asam" : "Terlalu Tinggi/Basa" },
        { name: "Suhu", value: temp, fuzzy: tempFuzzy, ranges: tempRanges, getStatus: (label: string) => label === "Dingin" ? "Terlalu Dingin" : "Terlalu Panas" },
    ];

    for (const sensor of sensorsToCheck) {
        if (sensor.fuzzy.Optimal < OPTIMAL_THRESHOLD) {
            const dominantLabel = Object.keys(sensor.fuzzy)
                .filter(key => key !== "Optimal")
                .sort((a, b) => sensor.fuzzy[b] - sensor.fuzzy[a])
                .find(key => sensor.fuzzy[key] > 0);
            if (dominantLabel) {
                const statusText = sensor.getStatus(dominantLabel);
                abnormalReadings.push(`${sensor.name} (${statusText} - ${sensor.value!.toFixed(1)})`);
            }
        }
    }

    const abnormalDetail: string = abnormalReadings.join(", ");
    if (abnormalReadings.length > 0) {
        logger.info(`⚠️ Kondisi Tidak Normal terdeteksi untuk device LEBIH (Skor Fuzzy: ${fuzzyScore.toFixed(2)}): ${abnormalDetail}`);
    } else {
        logger.info(`✅ Kondisi Normal untuk device LEBIH (Skor Fuzzy: ${fuzzyScore.toFixed(2)}).`);
    }

    // ==== Logika Debouncing Notifikasi & Penyimpanan Status ====
    const deviceStatusRef = rtdb.ref(`/devices/${DEVICE_ID}/statusInfo`);
    const today: string = new Date().toISOString().split("T")[0]!;

    try {
        const statusInfoSnap = await deviceStatusRef.once("value");
        const lastStatusInfo: DeviceStatusInfo = statusInfoSnap.val() || {};

        const currentStatusForDb: CurrentStatusData = {
            status,
            readings: abnormalReadings,
            timestamp: admin.database.ServerValue.TIMESTAMP,
        };
        const lastStatusForCompare: CurrentStatusData = {
            status: lastStatusInfo.currentStatus?.status || "",
            readings: lastStatusInfo.currentStatus?.readings || [],
            timestamp: {} as any,
        };

        if (JSON.stringify({ status, readings: abnormalReadings }) === JSON.stringify({ status: lastStatusForCompare.status, readings: lastStatusForCompare.readings })) {
            const lastNotifDate: string | undefined = lastStatusInfo.lastNotification?.date;
            if (lastNotifDate) {
                if (lastNotifDate === today) {
                    logger.info(`🔁 Notifikasi untuk status (${status}) yang sama sudah dikirim hari ini (${today}) untuk device LEBIH. Skip.`);
                    await deviceStatusRef.child("currentStatus").set(currentStatusForDb);
                    return;
                }
                const daysSinceLastNotif: number = (new Date(today).getTime() - new Date(lastNotifDate).getTime()) / (1000 * 60 * 60 * 24);
                if (daysSinceLastNotif > 2 && status === "Tidak Normal") {
                    logger.info(`⏳ Status tidak normal yang sama sudah berlangsung >2 hari untuk device LEBIH. Notifikasi dihentikan sementara.`);
                    await deviceStatusRef.child("currentStatus").set(currentStatusForDb);
                    return;
                }
            } else if (status === "Tidak Normal") {
                logger.info(`📭 Status sama (${status}), belum ada notifikasi tercatat. Akan coba kirim jika Tidak Normal.`);
            } else {
                logger.info(`ℹ️ Status sama (${status}) dan Normal. Tidak ada notifikasi. Device: LEBIH.`);
                await deviceStatusRef.child("currentStatus").set(currentStatusForDb);
                return;
            }
        }

        await deviceStatusRef.child("currentStatus").set(currentStatusForDb);
        logger.info(`📝 Status terakhir untuk device LEBIH berhasil disimpan: ${status}`);

        if (status === "Tidak Normal") {
            const message = {
                notification: {
                    title: `⚠️ Peringatan: LEBIH`,
                    body: `Kondisi tidak normal: ${abnormalDetail}. Segera periksa!`,
                },
                data: { status, abnormalDetail, recordId, timestamp: String(new Date().getTime()), fuzzyScore: fuzzyScore.toFixed(2) },
                topic: `device_alerts_LEBIH`,
                android: { priority: "high" as "high", notification: { sound: "default", channel_id: "sensor_alerts_channel" } },
                apns: { payload: { aps: { sound: "default", badge: 1, "content-available": 1 } }, headers: { "apns-priority": "10" } },
            };

            await fcm.send(message);

            logger.info(`📤 Notifikasi berhasil dikirim ke topik 'device_alerts_LEBIH'`);
            const notifData: LastNotificationData = { date: today, status: "Sent", detail: abnormalDetail };
            await deviceStatusRef.child("lastNotification").set(notifData);

        } else if (status === "Normal" && lastStatusInfo.currentStatus?.status === "Tidak Normal") {
            logger.info(`✅ Kondisi kembali normal untuk device LEBIH. Mengirim notifikasi pemulihan.`);
            const recoveryMessage = {
                notification: { title: `✅ Info: LEBIH`, body: `Kondisi telah kembali normal.` },
                data: { status, recordId, timestamp: String(new Date().getTime()), fuzzyScore: fuzzyScore.toFixed(2) },
                topic: `device_alerts_LEBIH`,
                android: { priority: "normal" as "normal", notification: { sound: "default", channel_id: "info_channel" } },
                apns: { payload: { aps: { sound: "default", badge: 0 } } },
            };

            await fcm.send(recoveryMessage);

            logger.info(`📤 Notifikasi pemulihan dikirim untuk device LEBIH.`);
            const notifData: LastNotificationData = { date: today, status: "Recovered" };
            await deviceStatusRef.child("lastNotification").set(notifData);
        }
    } catch (error: any) { // Tangkap error sebagai 'any' untuk akses error.message
        logger.error(`❌ Error dalam memproses status atau mengirim notifikasi untuk device LEBIH:`, error);
        // Optionally, log to database that notification failed
        const notifData: LastNotificationData = { date: today, status: "Failed", error: error.message };
        await deviceStatusRef.child("lastNotification").set(notifData);
    }
}