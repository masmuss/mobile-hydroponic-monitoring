class Record {
  final String datetime;
  final num hum;
  final num ph;
  final num tds;
  final num temp;

  Record({
    required this.datetime,
    required this.hum,
    required this.ph,
    required this.tds,
    required this.temp,
  });

  factory Record.fromJson(Map<Object?, Object?> json) {
    return Record(
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

  // Override the toString() method to log the data more easily
  @override
  String toString() {
    return 'Record(datetime: $datetime, hum: $hum, ph: $ph, tds: $tds, temp: $temp)';
  }
}
