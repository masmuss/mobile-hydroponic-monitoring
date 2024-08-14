class Records {
  final String datetime;
  final num hum;
  final num ph;
  final num tds1;
  final num tds2;
  final num temp;

  Records({
    required this.datetime,
    required this.hum,
    required this.ph,
    required this.tds1,
    required this.tds2,
    required this.temp,
  });

  factory Records.fromJson(Map<Object?, Object?> json) {
    return Records(
      datetime: json['datetime'] as String,
      hum: json['hum'] as num,
      ph: json['ph'] as num,
      tds1: json['tds1'] as num,
      tds2: json['tds2'] as num,
      temp: json['temp'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'hum': hum,
      'ph': ph,
      'tds1': tds1,
      'tds2': tds2,
      'temp': temp,
    };
  }
}
