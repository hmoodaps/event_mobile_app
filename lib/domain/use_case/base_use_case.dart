import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';

abstract class BaseUseCase<Input , output>{
Future <Either<AppEvents,output>> execute();
}