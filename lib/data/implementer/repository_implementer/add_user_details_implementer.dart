import 'package:dartz/dartz.dart';

import '../../../domain/local_models/models.dart';
import '../../../domain/repository/add_user_details.dart';
import '../../../domain/repository/main_repositories/repositories.dart';
import '../failure_class/failure_class.dart';

class AddUserDetailsImplementer implements AddUserDetailsRepo {
  final Repositories isolateHelper;

  AddUserDetailsImplementer({
    required this.isolateHelper,
  });

  @override
  Future<Either<FirebaseFailureClass, void>> addUserDetails({
    required CreateUserRequirements req,
  }) {
    return isolateHelper.addUserDetails(req: req);
  }
}
