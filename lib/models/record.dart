class Record {
  String datetime;
  double fieldTds;
  double ph;
  double tankTds;
  double waterTemp;

  Record({
    required this.datetime,
    required this.fieldTds,
    required this.ph,
    required this.tankTds,
    required this.waterTemp,
  });

  factory Record.fromJson(Map<Object?, Object?> json) => Record(
    datetime: DateTime.parse(json["datetime"] as String).toString(),
    fieldTds: json["field_tds"] as double,
    ph: json["ph"] as double,
    tankTds: json["tank_tds"] as double,
    waterTemp: json["water_temp"] as double,
  );

  Map<Object?, Object?> toJson() => {
    "datetime": datetime,
    "field_tds": fieldTds,
    "ph": ph,
    "tank_tds": tankTds,
    "water_temp": waterTemp,
  };
}