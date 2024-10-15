import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:event_mobile_app/presentation/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/routs_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../components/constants/general_strings.dart';

class LoginModelView extends BaseViewModel with LoginModelViewFunctions {
  // initialize variables to apply "Separation of Concerns " ::
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;

  late final EventsBloc _bloc;

//create user in firebase
  @override
  onLoginPressed({
    required GlobalKey<FormState>? formKey,
    required String email,
    required String password,
  }) async {
    if (formKey!.currentState!.validate()) {
      _bloc.add(StartCreateUserEvent());
      await VariablesManager.auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        _bloc.add(LoginSuccessEvent());
      }).catchError((error) {
        if (kDebugMode) {
          print(error.toString());
        }
        _bloc.add(LoginErrorEvent(error));
      });
    }
  }

  @override
  toNextField(BuildContext context) {
    return FocusScope.of(context).nextFocus();
  }

  @override
  validator(String? value) {
    if (value == null || value.isEmpty) {
      return GeneralStrings.fieldRequired;
    }
    return null;
  }

  @override
  void dispose() {
    _bloc.close();
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
  onSignInwWithApplePress() async {}

  @override
  onSignInwWithGooglePress() async {
    _bloc.add(SignInWithGoogleEvent());
    AuthCredential userInfoAndCredential = await signInWithGoogle(context);
    VariablesManager.auth
        .signInWithCredential(userInfoAndCredential)
        .then((value) async {
      User? user = value.user;
      if (kDebugMode) {
        print('first$value');
      }
      _bloc.add(SignInWithGoogleEventSuccess());
      _bloc.add(AddUserToFirebaseEvent());
      await addUserToFirebase(
              fullName: user!.displayName,
              email: user.email,
              userPhotoUrl: user.photoURL,
              uid: user.uid)
          .then((value) {
        _bloc.add(AddUserToFirebaseEventSuccess());
      }).catchError((error) {
        _bloc.add(AddUserToFirebaseEventError(error));
      });
    }).catchError((error) {
      _bloc.add(SignInWithGoogleEventError(error));
    });
  }

  @override
  onUserAddedSuccessfully() {
    navigateTo(context, RouteStringsManager.takeUserDetailsRoute);
  }

  @override
  checkUserExisting() {
    return VariablesManager.userIds.contains(VariablesManager.currentUser!.uid);
  }
}

mixin LoginModelViewFunctions {
  Future<void> onLoginPressed(
      {required GlobalKey<FormState>? formKey,
      required String email,
      required String password});

  validator(String value);

  onUserAddedSuccessfully();

  onForgetPasswordPress();

  onSignInwWithGooglePress();

  onSignInwWithApplePress();

  bool checkUserExisting();

  toNextField(BuildContext context);
}
