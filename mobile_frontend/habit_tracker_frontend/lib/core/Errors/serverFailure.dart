import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';

class ServerFailure implements ErrorInterface {
  @override
  String? debugInfo;
  @override
  String errorMessage;

  @override
  String? stackTrace;

  final String statusCode;

  ServerFailure({
    required this.statusCode,
    required this.errorMessage,
    this.debugInfo,
    this.stackTrace,
  });
}
