import 'dart:developer';

class Log {
  final String datetime;
  final int nutrient;
  final String outputCategory;

  Log({
    required this.datetime,
    required this.nutrient,
    required this.outputCategory,
  });

  // Konversi dari JSON (dari Firebase) dengan penanganan null
  factory Log.fromJson(Map<dynamic, dynamic> json) {
    String datetimeStr;
    try {
      datetimeStr = json['datetime'] as String? ?? '';
      if (datetimeStr.isNotEmpty) {
        DateTime.parse(datetimeStr); // Validasi format datetime
      }
    } catch (e) {
      log('Invalid datetime format in JSON: ${json['datetime']}, error: $e');
      datetimeStr = '';
    }

    return Log(
      datetime: datetimeStr,
      nutrient: (json['nutrient'] as num?)?.toInt() ?? 0,
      outputCategory: json['outputCategory'] as String? ?? '',
    );
  }

  // Konversi ke JSON (opsional, jika perlu mengirim data ke Firebase)
  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'nutrient': nutrient,
      'outputCategory': outputCategory,
    };
  }
}
