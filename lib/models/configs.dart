import 'package:hydroponic/models/relays.dart';
import 'package:hydroponic/models/solvents.dart';

class Configs {
  final Relays relays;
  final Solvents solvents;

  Configs({
    required this.relays,
    required this.solvents,
  });

  factory Configs.fromJson(Map<Object?, dynamic> json) {
    return Configs(
      relays: Relays.fromJson(json['relays']),
      solvents: Solvents.fromJson(json['solvents']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'relays': relays,
      'solvents': solvents,
    };
  }
}
