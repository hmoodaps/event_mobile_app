import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/dependencies_injection/dependency_injection.dart';
import 'package:event_mobile_app/domain/repository/login_to_firebase_repo.dart';
import '../../../domain/isolate/isolate_helper.dart';
import '../../../domain/local_models/models.dart';
import '../failure_class/failure_class.dart';

class LoginToFirebaseImplementer implements LoginToFirebaseRepo{
  final IsolateHelper isolateHelper = instance<IsolateHelper>();
  // Log in to Firebase
  @override
  Future<Either<FirebaseFailureClass, String>> loginToFirebase({required CreateUserRequirements req}) async {
     return await isolateHelper.loginToFirebase(req: req);
  }

}