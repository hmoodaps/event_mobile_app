import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/data/implementer/failure_class/failure_class.dart';

abstract class BaseUseCase<Input , output>{
Future <Either<FailureClass,output>> execute(Input input);
}
abstract class FirebaseUseCase<Input , output>{
Future <Either<FirebaseFailureClass,output>> execute(Input input);
}