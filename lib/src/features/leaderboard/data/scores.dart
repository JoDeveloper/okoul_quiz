import 'dart:convert';

List<Scores> scoresFromJson(String str) => List<Scores>.from(json.decode(str).map((x) => Scores.fromJson(x)));

String scoresToJson(List<Scores> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Scores {
  Scores({
    required this.name,
    required this.score,
  });

  final String name;
  final int score;

  factory Scores.fromJson(Map<String, dynamic> json) => Scores(
        name: json["name"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
      };
}
