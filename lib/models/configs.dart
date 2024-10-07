import 'package:hydroponic/models/relays.dart';
import 'package:hydroponic/models/solvents.dart';

class Configs {
  final Relays relays;
  final Solvents solvents;

  Configs({
    required this.relays,
    required this.solvents,
  });

  factory Configs.fromJson(Map<Object?, Object?> json) {
    return Configs(
      relays: Relays.fromJson(json['relays'] as Map<String, bool>),
      solvents: Solvents.fromJson(json['solvents'] as Map<Object?, Object?>),
    );
  }

  Map<String, Object?> toJson() {
    return {
      'relays': relays,
      'solvents': solvents.toJson(),
    };
  }
}