import 'dart:math';

class FuzzyService {
  // Rentang membership function untuk masing-masing variabel
  final Map<String, List<num>> phRanges = {
    "Asam": [0, 0, 6, 7],
    "Optimal": [6, 7, 8],
    "Basa": [7, 8, 14, 14]
  };

  final Map<String, List<num>> tdsRanges = {
    "Sangat Rendah": [0, 0, 400, 600],
    "Rendah": [400, 600, 900, 1100],
    "Optimal": [900, 1100, 1800, 2000],
    "Tinggi": [1800, 2000, 3000, 3000]
  };

  final Map<String, List<num>> tempRanges = {
    "Dingin": [0, 0, 23, 25],
    "Optimal": [24, 27, 30],
    "Panas": [28, 30, 45, 45]
  };

  /// Fungsi segitiga untuk perhitungan keanggotaan
  double triangleMembership(num x, List<num> params) {
    num a = params[0], b = params[1], c = params[2];

    if (x <= a || x >= c) return 0.0;
    if (a < x && x <= b) return (x - a) / (b - a);
    if (b < x && x < c) return (c - x) / (c - b);
    return 0.0;
  }

  /// Fungsi trapesium untuk perhitungan keanggotaan
  double trapezoidMembership(num x, List<num> params) {
    num a = params[0], b = params[1], c = params[2], d = params[3];

    if (x <= a || x >= d) return 0.0;
    if (a < x && x <= b) return (x - a) / (b - a);
    if (b <= x && x <= c) return 1.0;
    if (c < x && x < d) return (d - x) / (d - c);
    return 0.0;
  }

  /// Menghitung nilai keanggotaan untuk pH
  Map<String, double> phMembership(num x) {
    return {
      "Asam": trapezoidMembership(x, phRanges["Asam"]!),
      "Optimal": triangleMembership(x, phRanges["Optimal"]!),
      "Basa": trapezoidMembership(x, phRanges["Basa"]!)
    };
  }

  /// Menghitung nilai keanggotaan untuk TDS
  Map<String, double> tdsMembership(num x) {
    return {
      "Sangat Rendah": trapezoidMembership(x, tdsRanges["Sangat Rendah"]!),
      "Rendah": trapezoidMembership(x, tdsRanges["Rendah"]!),
      "Optimal": trapezoidMembership(x, tdsRanges["Optimal"]!),
      "Tinggi": trapezoidMembership(x, tdsRanges["Tinggi"]!)
    };
  }

  /// Menghitung nilai keanggotaan untuk suhu air
  Map<String, double> tempMembership(num x) {
    return {
      "Dingin": trapezoidMembership(x, tempRanges["Dingin"]!),
      "Optimal": triangleMembership(x, tempRanges["Optimal"]!),
      "Panas": trapezoidMembership(x, tempRanges["Panas"]!)
    };
  }

  /// Aturan fuzzy berdasarkan tabel aturan
  List<Map<String, dynamic>> fuzzyRules(Map<String, double> tds,
      Map<String, double> ph, Map<String, double> temp) {
    List<List<String>> rules = [
      ["Optimal", "Optimal", "Optimal", "Normal"], // Kondisi optimal
    ];

    List<Map<String, dynamic>> results = [];

    for (var rule in rules) {
      String tdsLabel = rule[0];
      String phLabel = rule[1];
      String tempLabel = rule[2];
      String output = rule[3];

      if (tds.containsKey(tdsLabel) &&
          ph.containsKey(phLabel) &&
          temp.containsKey(tempLabel)) {
        double strength = min(
          min(tds[tdsLabel]!, ph[phLabel]!),
          temp[tempLabel]!,
        );

        results.add({"firing_strength": strength, "output": output});
      }
    }

    if (results.isEmpty) {
      results.add({"firing_strength": 0.0, "output": "Tidak Normal"});
    }

    return results;
  }

  /// Fungsi defuzzifikasi menggunakan Weighted Average (Sugeno)
  double defuzzification(List<Map<String, dynamic>> rules) {
    double numerator = 0.0;
    double denominator = 0.0;

    for (var rule in rules) {
      numerator +=
          rule["firing_strength"] * (rule["output"] == "Normal" ? 1 : 0);
      denominator += rule["firing_strength"];
    }

    return denominator == 0 ? 0 : numerator / denominator;
  }

  /// Analisis lingkungan untuk menentukan status dan sensor tidak normal
  Map<String, dynamic> analyzeEnvironment(num tds, num ph, num temp) {
    final tdsFuzzy = tdsMembership(tds);
    final phFuzzy = phMembership(ph);
    final tempFuzzy = tempMembership(temp);

    List<Map<String, dynamic>> rules = fuzzyRules(tdsFuzzy, phFuzzy, tempFuzzy);

    double fuzzyScore = defuzzification(rules);
    String status = fuzzyScore > 0.5 ? "Normal" : "Tidak Normal";

    List<Map<String, String>> abnormalSensors = [];

    tdsFuzzy.forEach((key, value) {
      if (key != "Optimal" && value > 0) {
        abnormalSensors.add({
          "sensor": "TDS",
          "status": key.contains("Rendah") ? "Terlalu Rendah" : "Terlalu Tinggi"
        });
      }
    });

    phFuzzy.forEach((key, value) {
      if (key != "Optimal" && value > 0) {
        abnormalSensors.add({
          "sensor": "pH",
          "status": key == "Asam" ? "Terlalu Rendah/Asam" : "Terlalu Tinggi/Basa"
        });
      }
    });

    tempFuzzy.forEach((key, value) {
      if (key != "Optimal" && value > 0) {
        abnormalSensors.add({
          "sensor": "Suhu",
          "status": key == "Dingin" ? "Terlalu Dingin" : "Terlalu Panas"
        });
      }
    });

    return {"status": status, "abnormal_sensors": abnormalSensors};
  }
}
