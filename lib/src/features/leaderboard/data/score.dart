import 'dart:convert';

List<Score> scoresFromJson(String str) => List<Score>.from(json.decode(str).map((x) => Score.fromJson(x)));

String scoresToJson(List<Score> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Score {
  Score({
    required this.name,
    required this.score,
  });

  final String name;
  final int score;

  factory Score.fromJson(Map<String, dynamic> json) => Score(
        name: json["name"],
        score: json["score"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
      };
}
