import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';

class UnDefinedfailure implements ErrorInterface {
  @override
  String? debugInfo;
  @override
  String errorMessage;

  @override
  String? stackTrace;

  final String? statusCode;

  UnDefinedfailure({
     this.statusCode,
    required this.errorMessage,
    this.debugInfo,
    this.stackTrace,
  });
}
