import 'package:habit_tracker/domain/Habits/InterFaces/ErrorInterface/errorInterface.dart';

class AccessDeniedfailure implements ErrorInterface {
  @override
  String? debugInfo;
  @override
  String errorMessage;

  @override
  String? stackTrace;

  final String? statusCode;

  AccessDeniedfailure({
     this.statusCode,
    required this.errorMessage,
    this.debugInfo,
    this.stackTrace,
  });
}
