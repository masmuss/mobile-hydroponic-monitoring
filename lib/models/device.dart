import 'package:hydroponic/models/record.dart';

import 'configs.dart';

class Device {
  final String id;
  final String name;
  final num recordCount;
  final String target;
  final Configs configs;
  final List<Record> records;

  Device({
    required this.id,
    required this.name,
    required this.recordCount,
    required this.target,
    required this.configs,
    required this.records
  });

  factory Device.fromJson(Map<String, dynamic> json) {
    return Device(
      id: json['id'] as String,
      name: json['name'] as String,
      recordCount: json['record_count'] as num,
      target: json['target'] as String,
      configs: Configs.fromJson(json['configs']),
      records: (json['records'] as List).map((e) => Record.fromJson(e)).toList()
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'record_count': recordCount,
      'target': target,
      'configs': configs.toJson(),
      'records': records.map((e) => e.toJson()).toList(),
    };
  }
}