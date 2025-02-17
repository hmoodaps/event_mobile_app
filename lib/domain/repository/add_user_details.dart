import 'package:dartz/dartz.dart';

import '../../../data/implementer/failure_class/failure_class.dart';
import '../local_models/models.dart';

abstract class AddUserDetailsRepo {
  Future<Either<FailureClass, void>> addUserDetails({
    required CreateUserRequirements req,
  });
}
