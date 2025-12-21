import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class ServerFailure implements ErrorInterface {
  @override
  String? debugInfo;
  @override
  String errorMessage;

  @override
  String? stackTrace;

  final String? statusCode;

  ServerFailure({
     this.statusCode,
    required this.errorMessage,
    this.debugInfo,
    this.stackTrace,
  });
}
