class CustomException implements Exception {
  CustomException({
    this.title,
    this.message,
  });

  final String? title;

  final String? message;
}
