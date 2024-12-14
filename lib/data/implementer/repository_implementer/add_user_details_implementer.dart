import 'package:dartz/dartz.dart';

import '../../../domain/local_models/models.dart';
import '../../../domain/repository/add_user_details.dart';
import '../../../domain/repository/main_repositories/repositories.dart';
import '../failure_class/failure_class.dart';

class AddUserDetailsImplementer implements AddUserDetailsRepo {
  final Repositories repo;

  AddUserDetailsImplementer({
    required this.repo,
  });

  @override
  Future<Either<FailureClass, void>> addUserDetails({
    required CreateUserRequirements req,
  }) {
    return repo.addUserDetails(req: req);
  }
}
