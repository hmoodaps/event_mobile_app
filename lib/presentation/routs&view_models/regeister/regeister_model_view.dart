import 'dart:async';

import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/notification_handler.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../app/components/tranlate_massages/translate_massage.dart';
import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';

class RegisterModelView extends BaseViewModel with RegisterModelViewFunctions {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;
  late EventsBloc _bloc;
  late final StreamSubscription blocStreamSubscription;

  RegisterModelView(this.context);

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    blocStreamSubscription.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    _startListen();
  }

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
    });
  }

  @override
  Future<void> onRegisterPressed({
    required GlobalKey<FormState>? formKey,
    required String fullName,
    required String email,
    required String password,
  }) async {
    CreateUserRequirements req = CreateUserRequirements(
        email: email, password: password, fullName: fullName, token: '');
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
