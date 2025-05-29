import { FuzzyRanges, FuzzyRule, Weights } from "../types";

export const OPTIMAL_THRESHOLD: number = 0.5; // Digunakan sebagai ambang batas defuzzifikasi
export const NOTIFICATION_THRESHOLD: number = 0.5; // Digunakan untuk menentukan apakah status "Tidak Normal"

// Bobot untuk masing-masing sensor input
export const WEIGHTS: Weights = {
    tds: 0.6,
    ph: 0.2,
    temp: 0.2,
};

// Rentang membership function untuk masing-masing variabel
export const phRanges: FuzzyRanges = {
    Asam: [0, 0, 6, 7],
    Optimal: [6, 7, 8],
    Basa: [7, 8, 14, 14],
};

export const tdsRanges: FuzzyRanges = {
    "Sangat Rendah": [0, 0, 400, 600],
    Rendah: [400, 600, 900, 1100],
    Optimal: [900, 1100, 1800, 2000],
    Tinggi: [1800, 2000, 3000, 3000],
};

export const tempRanges: FuzzyRanges = {
    Dingin: [0, 0, 23, 25],
    Optimal: [24, 27, 30],
    Panas: [28, 30, 45, 45],
};

// Aturan fuzzy berdasarkan tabel aturan dari kode Dart Anda
export const FUZZY_RULES: FuzzyRule[] = [
    ["Optimal", "Optimal", "Optimal", "Normal"],
    // Tambahkan aturan lain jika ada
];