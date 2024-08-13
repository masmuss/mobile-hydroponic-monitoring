import 'package:hydroponic/models/configs.dart';
import 'package:hydroponic/models/records.dart';

class DeviceData {
  final Configs configs;
  final int id;
  final String name;
  final Records records;

  DeviceData({required this.configs, required this.id, required this.name, required this.records});

  // Factory constructor to create DeviceData from a JSON map
  factory DeviceData.fromJson(Map<String, dynamic> json) {
    return DeviceData(
      configs: Configs.fromJson(json['configs']),
      id: json['id'] as int,
      name: json['name'] as String,
      records: Records.fromJson(json['records']),
    );
  }

  // Method to convert DeviceData to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'configs': configs.toJson(),
      'id': id,
      'name': name,
      'records': records.toJson(),
    };
  }
}
