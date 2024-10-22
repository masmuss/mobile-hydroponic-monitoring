class Solvents {
  final num a;
  final num b;

  Solvents({
    required this.a,
    required this.b,
  });

  factory Solvents.fromJson(Map<Object?, Object?> json) {
    return Solvents(
      a: json['a'] as num,
      b: json['b'] as num,
    );
  }

  Map<String, num> toJson() {
    return {
      'a': a,
      'b': b,
    };
  }
}
