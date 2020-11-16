class APIErrorException implements Exception {
  final String message;

  APIErrorException(this.message);

  @override
  String toString() {
    return this.message;
  }
}
