import 'package:hydroponic/models/configs.dart';

class Device {
  Configs configs;
  int id;
  String name;
  int recordCount;
  dynamic records;
  String target;

  Device({
    required this.configs,
    required this.id,
    required this.name,
    required this.recordCount,
    required this.records,
    required this.target,
  });

  factory Device.fromJson(Map<String, dynamic> json) => Device(
    configs: Configs.fromJson(json["configs"]),
    id: json["id"],
    name: json["name"],
    recordCount: json["record_count"],
    records: json["records"],
    target: json["target"],
  );

  Map<String, dynamic> toJson() => {
    "configs": configs.toJson(),
    "id": id,
    "name": name,
    "record_count": recordCount,
    "records": records,
    "target": target,
  };
}
