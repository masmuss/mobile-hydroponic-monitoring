import 'package:hydroponic/models/configs.dart';
import 'package:hydroponic/models/record.dart';

// class Device {
//   final int id;
//   final String name;
//   final Configs configs;
//   final int recordCount;
//   // final List<Record> records;
//   final String target;
//
//   Device({
//     required this.id,
//     required this.name,
//     required this.configs,
//     required this.recordCount,
//     // required this.records,
//     required this.target,
//   });
//
//   factory Device.fromJson(Map<String, dynamic> json) {
//     return Device(
//       id: json['id'] as int,
//       name: json['name'] as String,
//       configs: Configs.fromJson(json['configs'] as Map<Object?, Object?>),
//       recordCount: json['record_count'] as int,
//       // records: (json['records'] as List).map((e) => Record.fromJson(e)).toList(),
//       target: json['target'] as String,
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'configs': configs.toJson(),
//       'record_count': recordCount,
//       // 'records': records.map((e) => e.toJson()).toList(),
//       'target': target,
//     };
//   }
// }

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
