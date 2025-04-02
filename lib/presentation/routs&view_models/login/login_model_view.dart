import 'dart:async';

import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/notification_handler.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../app/components/tranlate_massages/translate_massage.dart';
import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';

class LoginModelView extends BaseViewModel with LoginModelViewFunctions {
  // initialize variables to apply "Separation of Concerns"
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;
  late final EventsBloc _bloc;

  LoginModelView(this.context);

  // Create user in Firebase
  @override
  onLoginPressed({
    required String email,
    required String password,
  }) async {
    CreateUserRequirements req = CreateUserRequirements(
      token: "",
      email: email,
      password: password,
    );
    _bloc.add(LoginEvent(req));
  }

  late StreamSubscription blocStreamSubscription;

  errorNoti(String error) => errorNotification(
      context: context,
      description: translateErrorMessage(error, context),
      backgroundColor:
          VariablesManager.isDark ? Colors.grey.shade400 : Colors.white);

  _startListen() {
    blocStreamSubscription = _bloc.stream.listen((state) async {
      if (state is SignInWithGoogleStateError) {
        errorNoti(state.error);
      }
      if (state is UserCreatedErrorState) {
        errorNoti(state.error);
      }
      if (state is UserCreatedSuccessState) {
        onCreateNewUser();
      }
      if (state is SignInWithGoogleUserExistState) {
        final docSnapshot = await VariablesManager.firestoreInstance
            .collection(GeneralStrings.users)
            .doc(VariablesManager.firebaseAuthInstance.currentUser!.uid)
            .get();

        if (docSnapshot.exists) {
          final data = docSnapshot.data();

          if (data != null && (data['additionalInfo'] != null)) {
            onAddExistUser();
          } else {
            onCreateNewUser();
          }
        } else {
          if (kDebugMode) {
            print("User document does not exist.");
          }
        }
      }
      if (state is LoginErrorState) {
        errorNoti(state.error);
      }
      if (state is LoginSuccessState) {
        navigateToHome();
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose(); // Dispose of controllers to avoid memory leaks
    passwordController.dispose();
    blocStreamSubscription.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    _startListen();
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
  onForgetPassword() {}
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
