class Relays {
  Map<String, bool> auto;
  Map<String, bool> manual;

  Relays({
    required this.auto,
    required this.manual,
  });

  /// Factory untuk mengubah JSON ke model `Relays`
  factory Relays.fromJson(Map<Object?, Object?> json) {
    return Relays(
      auto: _parseRelayData(json["auto"]),
      manual: _parseRelayData(json["manual"]),
    );
  }

  /// Konversi kembali ke JSON
  Map<String, dynamic> toJson() => {
    "auto": auto,
    "manual": manual,
  };

  /// Fungsi helper untuk parsing data relay dari JSON
  static Map<String, bool> _parseRelayData(dynamic data) {
    if (data is Map<Object?, Object?>) {
      return data.map((key, value) => MapEntry(key.toString(), value as bool));
    }
    return {};
  }
}
