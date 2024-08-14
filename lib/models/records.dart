class Records {
  final String datetime;
  final num hum;
  final num ph;
  final num tds;
  final num temp;

  Records({
    required this.datetime,
    required this.hum,
    required this.ph,
    required this.tds,
    required this.temp,
  });

  factory Records.fromJson(Map<Object?, Object?> json) {
    return Records(
      datetime: json['datetime'] as String,
      hum: json['hum'] as num,
      ph: json['ph'] as num,
      tds: json['tds'] as num,
      temp: json['temp'] as num,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'datetime': datetime,
      'hum': hum,
      'ph': ph,
      'tds': tds,
      'temp': temp,
    };
  }
}
