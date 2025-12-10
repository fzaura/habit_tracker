import 'package:habit_tracker/domain/InterFaces/ErrorInterface/errorInterface.dart';

class ServerFailure extends ErrorInterface {
  const ServerFailure({
    required super .errorMessage,
    required this.statusCode,
     super.stackTrace,
     super.debugInfo,
  }) ;
  final String statusCode;
  
 
}
