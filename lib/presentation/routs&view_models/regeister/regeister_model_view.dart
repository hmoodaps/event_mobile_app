import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/domain/models/user_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:event_mobile_app/presentation/components/constants/general_strings.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../components/constants/route_strings_manager.dart';
import '../../components/constants/routs_manager.dart';

class RegisterModelView extends BaseViewModel with RegisterModelViewFunctions {
  // initialize variables to apply "Separation of Concerns " ::
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;

  late final EventsBloc _bloc;

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
  Future<void> onRegisterPressed(
      {required GlobalKey<FormState>? formKey,
      required String fullName,
      required String email,
      required String password}) async {
    if (formKey!.currentState!.validate()) {
      _bloc.add(StartCreateUserEvent());
      await createUserAtFirebase(
              formKey: formKey,
              email: email,
              password: password,
              fullName: fullName)
          .then((value) {
        _bloc.add(CreateUserEventSuccess());
      }).catchError((error) {
        _bloc.add(CreateUserEventError(error));
      }).then((value) async {
        _bloc.add(AddUserToFirebaseEvent());
        await addUserToFirebase(email: email, fullName: fullName).then((value) {
          _bloc.add(AddUserToFirebaseEventSuccess());
        }).catchError((error) {
          _bloc.add(AddUserToFirebaseEventError(error));
        });
      });
    }
  }

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
}

mixin RegisterModelViewFunctions {
  Future<void> onRegisterPressed(
      {required GlobalKey<FormState>? formKey,
      required String fullName,
      required String email,
      required String password});

  validator(String value);

  onSignInwWithGooglePress();
  onUserAddedSuccessfully();

  toNextField(BuildContext context);
}
