import 'dart:convert';

List<Question> questionFromJson(String str) => List<Question>.from(json.decode(str).map((x) => Question.fromJson(x)));

String questionToJson(List<Question> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Question {
  Question({
    required this.question,
    required this.a,
    required this.b,
    required this.c,
    required this.d,
    required this.correct,
  });

  final String question;
  final String a;
  final String b;
  final String c;
  final String d;
  final String correct;

  List get options => [a, b, c, d];

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        question: json["Question"],
        a: json["a"],
        b: json["b"],
        c: json["c"],
        d: json["d"],
        correct: json["correct"],
      );

  Map<String, dynamic> toJson() => {
        "Question": question,
        "a": a,
        "b": b,
        "c": c,
        "d": d,
        "correct": correct,
      };
}
