import 'dart:async';

import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';

class LoginModelView extends BaseViewModel with LoginModelViewFunctions {
  // initialize variables to apply "Separation of Concerns"
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;
  late final EventsBloc _bloc;

  // Create user in Firebase
  @override
  onLoginPressed({
    required String email,
    required String password,
  }) async {
    CreateUserRequirements req = CreateUserRequirements(
      email: email,
      password: password,
    );
    _bloc.add(LoginEvent(req));
  }

  @override
  void dispose() {
    emailController.dispose(); // Dispose of controllers to avoid memory leaks
    passwordController.dispose();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
  }

  @override
  onForgetPasswordPress() {
    navigateTo(context, RouteStringsManager.forgetPasswordRoute);
  }

  @override
  onSignInwWithGooglePress() async {
    _bloc.add(SignInWithGoogleEvent());
  }

  @override
  onCreateNewUser() {
    Navigator.pushReplacementNamed(
      context,
      RouteStringsManager.takeUserDetailsRoute,
    );
  }

  @override
  onAddExistUser() {
    Navigator.pushReplacementNamed(
      context,
      RouteStringsManager.mainRoute,
    );
  }

  @override
  navigateToHome() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteStringsManager.mainRoute, (route) => false);
  }
  @override
  onForgetPassword() {
  }
}

mixin LoginModelViewFunctions {
  Future<void> onLoginPressed({
    required String email,
    required String password,
  });

  void onForgetPasswordPress();

  onCreateNewUser();

  onSignInwWithGooglePress();

  onAddExistUser();

  navigateToHome();
  onForgetPassword();
}
