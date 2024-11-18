import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/route_strings_manager.dart';
import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';

class RegisterModelView extends BaseViewModel with RegisterModelViewFunctions {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;
  late EventsBloc _bloc;

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
  }

  @override
  Future<void> onRegisterPressed({
    required GlobalKey<FormState>? formKey,
    required String fullName,
    required String email,
    required String password,
  }) async {
    CreateUserRequirements req = CreateUserRequirements(
        email: email, password: password, fullName: fullName);
    if (formKey!.currentState!.validate()) {
      _bloc.add(StartCreateUserEvent(req));
    }
  }

  @override
  onSignInwWithGooglePress() async {
    _bloc.add(SignInWithGoogleEvent());
  }

  @override
  onCreateNewUser() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteStringsManager.takeUserDetailsRoute, (route) => false);
  }

  @override
  onAddExistUser() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteStringsManager.mainRoute, (route) => false);
  }
}

mixin RegisterModelViewFunctions {
  Future<void> onRegisterPressed({
    required GlobalKey<FormState>? formKey,
    required String fullName,
    required String email,
    required String password,
  });

  onSignInwWithGooglePress();

  onAddExistUser();

  onCreateNewUser();
}
