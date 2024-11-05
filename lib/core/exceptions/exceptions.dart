class ServerException implements Exception {
  final String message;
  ServerException({
    required this.message,
  });
  @override
  String toString() {
    return message.toString();
  }
}
class ClientException implements Exception {
  final String message;
  ClientException({
    required this.message,
  });
  @override
  String toString() {
    return message.toString();
  }
}