import 'package:hydroponic/models/configs.dart';
import 'package:hydroponic/models/records.dart';

class Device {
  final String id;
  final String name;
  final Configs configs;
  final Records records;

  Device({
    required this.id,
    required this.name,
    required this.configs,
    required this.records
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      name: json['name'] as String,
      configs: Configs.fromJson(json['configs']),
      records: Records.fromJson(json['records']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'configs': configs.toJson(),
      'records': records.toJson(),
    };
  }
}