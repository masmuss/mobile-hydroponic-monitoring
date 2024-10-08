class Configs {
  final bool relay1;
  final bool relay2;
  final bool relay3;
  final bool relay4;
  final bool relay5;

  Configs({
    required this.relay1,
    required this.relay2,
    required this.relay3,
    required this.relay4,
    required this.relay5,
  });

  factory Configs.fromJson(Map<Object?, Object?> json) {
    return Configs(
      relay1: json['relay1'] as bool,
      relay2: json['relay2'] as bool,
      relay3: json['relay3'] as bool,
      relay4: json['relay4'] as bool,
      relay5: json['relay5'] as bool,
    );
  }

  Map<String, bool> toJson() {
    return {
      'relay1': relay1,
      'relay2': relay2,
      'relay3': relay3,
      'relay4': relay4,
      'relay5': relay5,
    };
  }
}