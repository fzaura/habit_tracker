abstract class ErrorInterface {
  const ErrorInterface({
    required this.errorMessage,
    this.debugInfo,
    this.stackTrace,
  });
  final String errorMessage;
  final String? stackTrace;
  final String? debugInfo;
}
