class CustomException implements Exception {
  final String message;
  final String prefix;

  CustomException([this.message = '', this.prefix = '']);

  @override
  String toString() {
    return '$prefix$message';
  }
}


