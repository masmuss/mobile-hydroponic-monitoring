class Record {
  String datetime;
  Map<String, num> sensorData;

  Record({
    required this.datetime,
    required this.sensorData,
  });

  factory Record.fromJson(Map<Object?, Object?> json) {
    Map<String, num> sensorMap = {};

    json.forEach((key, value) {
      if (key is String && value is num && key != "datetime") {
        sensorMap[key] = value;
      }
    });

    return Record(
      datetime: json["datetime"] as String,
      sensorData: sensorMap,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "datetime": datetime,
      ...sensorData,
    };
  }
}
