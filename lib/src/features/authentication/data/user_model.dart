class User {
  User({
    required this.success,
    required this.message,
    required this.token,
    required this.name,
    required this.mobile,
  });

  final bool success;
  final String message;
  final String token;
  final String? name;
  final String mobile;

  factory User.fromJson(Map<String, dynamic> json) => User(
        success: json["success"],
        message: json["message"],
        token: json["token"],
        name: json["name"],
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "token": token,
        "name": name,
        "mobile": mobile,
      };

  User copyWith({
    bool? success,
    String? message,
    String? token,
    String? name,
    String? mobile,
  }) {
    return User(
      success: success ?? this.success,
      message: message ?? this.message,
      token: token ?? this.token,
      name: name ?? this.name,
      mobile: mobile ?? this.mobile,
    );
  }
}
