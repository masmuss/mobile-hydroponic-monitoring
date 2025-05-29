import { MembershipParams, FuzzyResult, FuzzyRanges } from "../types";

/**
 * Fungsi segitiga untuk perhitungan keanggotaan.
 * @param x - Nilai input.
 * @param params - [a, b, c] di mana b adalah puncak (membership 1).
 * @returns Nilai keanggotaan (antara 0.0 dan 1.0).
 */
export function triangleMF(x: number, params: MembershipParams): number {
    const [a, b, c] = params;
    if (x < a || x > c) return 0.0;
    if (x === b) return 1.0;

    if (x >= a && x < b) {
        return (b - a === 0) ? ((x === a) ? 1.0 : 0.0) : Math.max(0, Math.min(1, (x - a) / (b - a)));
    }
    if (x > b && x <= c) {
        return (c - b === 0) ? ((x === b) ? 1.0 : 0.0) : Math.max(0, Math.min(1, (c - x) / (c - b)));
    }
    return 0.0; // Fallback
}

/**
 * Fungsi trapesium untuk perhitungan keanggotaan.
 * @param x - Nilai input.
 * @param params - [a, b, c, d] di mana b-c adalah plateau (membership 1).
 * @returns Nilai keanggotaan (antara 0.0 dan 1.0).
 */
export function trapezoidMF(x: number, params: MembershipParams): number {
    const [a, b, c, d] = params;
    if (x < a || x > d) return 0.0;
    if (x >= b && x <= c) return 1.0;

    if (x >= a && x < b) {
        return (b - a === 0) ? ((x === a) ? 1.0 : 0.0) : Math.max(0, Math.min(1, (x - a) / (b - a)));
    }
    if (x > c && x <= d) {
        return (d - c === 0) ? ((x === c) ? 1.0 : 0.0) : Math.max(0, Math.min(1, (d - x) / (d - c)));
    }
    return 0.0; // Fallback
}

/**
 * Menghitung nilai keanggotaan untuk pH.
 * @param x - Nilai pH.
 * @param ranges - Objek phRanges dari config.
 * @returns Map nilai keanggotaan pH.
 */
export function phMembership(x: number, ranges: FuzzyRanges): FuzzyResult {
    return {
        "Asam": trapezoidMF(x, ranges["Asam"]),
        "Optimal": triangleMF(x, ranges["Optimal"]),
        "Basa": trapezoidMF(x, ranges["Basa"]),
    };
}

/**
 * Menghitung nilai keanggotaan untuk TDS.
 * @param x - Nilai TDS.
 * @param ranges - Objek tdsRanges dari config.
 * @returns Map nilai keanggotaan TDS.
 */
export function tdsMembership(x: number, ranges: FuzzyRanges): FuzzyResult {
    return {
        "Sangat Rendah": trapezoidMF(x, ranges["Sangat Rendah"]),
        "Rendah": trapezoidMF(x, ranges["Rendah"]),
        "Optimal": trapezoidMF(x, ranges["Optimal"]),
        "Tinggi": trapezoidMF(x, ranges["Tinggi"]),
    };
}

/**
 * Menghitung nilai keanggotaan untuk suhu air.
 * @param x - Nilai suhu.
 * @param ranges - Objek tempRanges dari config.
 * @returns Map nilai keanggotaan suhu.
 */
export function tempMembership(x: number, ranges: FuzzyRanges): FuzzyResult {
    return {
        "Dingin": trapezoidMF(x, ranges["Dingin"]),
        "Optimal": triangleMF(x, ranges["Optimal"]),
        "Panas": trapezoidMF(x, ranges["Panas"]),
    };
}