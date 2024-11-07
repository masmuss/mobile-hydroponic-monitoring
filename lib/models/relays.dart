class Relays {
  dynamic auto;
  dynamic manual;

  Relays({
    required this.auto,
    required this.manual,
  });

  factory Relays.fromJson(Map<Object?, Object?> json) => Relays(
    auto: json["auto"],
    manual: json["manual"],
  );

  Map<String, dynamic> toJson() => {
    "auto": auto.toJson(),
    "manual": manual.toJson(),
  };
}

class Auto {
  bool nutrientA;
  bool nutrientB;
  bool phBuffer;
  bool aerator;

  Auto({
    required this.nutrientA,
    required this.nutrientB,
    required this.phBuffer,
    required this.aerator,
  });

  factory Auto.fromJson(Map<Object?, Object?> json) => Auto(
    nutrientA: json["nutrient_a"] as bool,
    nutrientB: json["nutrient_b"] as bool,
    phBuffer: json["ph_buffer"] as bool,
    aerator: json["aerator"] as bool,
  );

  Map<String, dynamic> toJson() => {
    "nutrient_a": nutrientA,
    "nutrient_b": nutrientB,
    "ph_buffer": phBuffer,
    "aerator": aerator,
  };
}