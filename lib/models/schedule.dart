class Schedule {
  int week1;
  int week2;
  int week5;
  int week6;

  Schedule({
    required this.week1,
    required this.week2,
    required this.week5,
    required this.week6,
  });

  factory Schedule.fromJson(Map<Object?, Object?> json) => Schedule(
    week1: json["week_1"] as int,
    week2: json["week_2"] as int,
    week5: json["week_5"] as int,
    week6: json["week_6"] as int,
  );

  Map<Object?, Object?> toJson() => {
    "week_1": week1,
    "week_2": week2,
    "week_5": week5,
    "week_6": week6,
  };
}