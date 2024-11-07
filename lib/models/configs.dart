import 'package:flutter/foundation.dart';
import 'package:hydroponic/models/relays.dart';
import 'package:hydroponic/models/schedule.dart';

class Configs {
  String mode;
  dynamic relays;
  dynamic schedule;

  Configs({
    required this.mode,
    required this.relays,
    required this.schedule,
  });

  factory Configs.fromJson(Map<Object?, Object?> json) => Configs(
    mode: json["mode"] as String,
    relays: json["relays"] as dynamic,
    schedule: json["schedule"] as dynamic,
  );

  Map<Object?, dynamic> toJson() => {
    "mode": mode,
    "relays": relays.toJson(),
    "schedule": schedule.toJson(),
  };
}