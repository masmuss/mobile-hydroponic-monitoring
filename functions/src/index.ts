import { database, setGlobalOptions } from "firebase-functions/v2";
import * as admin from "firebase-admin";
import { processSensorData } from "./fuzzy/sensor-data-processor";
import DEVICE_ID from "./lib/constants";

// Inisialisasi Firebase Admin SDK
if (!admin.apps.length) {
    admin.initializeApp();
}

const rtdb = admin.database();
const fcm = admin.messaging();

setGlobalOptions({ region: "asia-southeast1" });
// ==== Cloud Function Utama ====
// Fungsi ini akan dipicu setiap kali ada data baru di path yang ditentukan
export const onNewSensorData = database.onValueCreated(
    `/devices/${DEVICE_ID}/records/{recordId}`,
    async (event: database.DatabaseEvent<database.DataSnapshot, {
        recordId: string;
    }>) => {
        // Panggil handler utama untuk memproses data sensor
        return processSensorData(event, rtdb, fcm);
    }
);