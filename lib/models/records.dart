class Records {
  final String datetime;
  final int hum;
  final double ph;
  final int tds;
  final double temp;

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
      hum: json['hum'] as int,
      ph: json['ph'] as double,
      tds: json['tds'] as int,
      temp: json['temp'] as double,
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
