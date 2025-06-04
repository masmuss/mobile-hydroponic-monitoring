// Tipe untuk rentang membership function (misal: [0, 0, 6, 7] atau [6, 7, 8])
export type MembershipParams = number[];

// Tipe untuk objek rentang variabel (misal: phRanges)
export type FuzzyRanges = {
    [key: string]: MembershipParams;
};

// Tipe untuk hasil fuzzyfikasi (misal: { "Asam": 0.5, "Optimal": 0.3 })
export type FuzzyResult = {
    [key: string]: number;
};

// Tipe untuk bobot sensor
export type Weights = {
    tds: number;
    ph: number;
    temp: number;
};

// Tipe untuk aturan fuzzy (misal: ["Optimal", "Optimal", "Optimal", "Normal"])
export type FuzzyRule = [string, string, string, string];

// Tipe untuk hasil aturan yang terpicu (firing_strength)
export type FiredRule = {
    firing_strength: number;
    output: string;
};

// Tipe untuk detail sensor abnormal
export type AbnormalSensorDetail = {
    sensor: string;
    status: string; // Misal: "Terlalu Rendah", "Terlalu Tinggi", "Terlalu Asam"
};

// Tipe untuk data sensor mentah yang diterima
export type SensorData = {
    tank_tds: number | null;
    ph: number | null;
    water_temp: number | null;
    // Tambahkan properti lain jika ada di data Anda
};

// Tipe untuk objek status yang disimpan di Realtime Database
export type CurrentStatusData = {
    status: string; // "Normal" atau "Tidak Normal"
    readings: string[]; // Contoh: ["TDS (Terlalu Rendah - 250.0)", "pH (Asam - 6.0)"]
    timestamp: object; // Menggunakan admin.database.ServerValue.TIMESTAMP
};

// Tipe untuk objek notifikasi terakhir yang disimpan di Realtime Database
export type LastNotificationData = {
    date: string; // Format YYYY-MM-DD
    status: "Sent" | "Failed" | "Recovered" | "NormalRecovery";
    detail?: string; // Detail pesan abnormal (opsional)
    error?: string; // Pesan error jika gagal (opsional)
};

// Tipe untuk seluruh objek statusInfo di Realtime Database
export type DeviceStatusInfo = {
    currentStatus?: CurrentStatusData;
    lastNotification?: LastNotificationData;
};