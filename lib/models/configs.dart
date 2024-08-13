class Configs {
  final int relay1;
  final int relay2;
  final int relay3;
  final int relay4;
  final int relay5;

  Configs({
    required this.relay1,
    required this.relay2,
    required this.relay3,
    required this.relay4,
    required this.relay5,
  });

  factory Configs.fromJson(Map<Object?, Object?> json) {
    return Configs(
      relay1: json['relay1'] as int,
      relay2: json['relay2'] as int,
      relay3: json['relay3'] as int,
      relay4: json['relay4'] as int,
      relay5: json['relay5'] as int,
    );
  }

  Map<String, int> toJson() {
    return {
      'relay1': relay1,
      'relay2': relay2,
      'relay3': relay3,
      'relay4': relay4,
      'relay5': relay5,
    };
  }
}