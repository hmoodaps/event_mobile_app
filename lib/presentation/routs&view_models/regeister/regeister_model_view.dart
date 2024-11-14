import 'package:event_mobile_app/app/dependencies_injection/dependency_injection.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:flutter/material.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../main_page/main_route.dart';

class RegisterModelView extends BaseViewModel with RegisterModelViewFunctions {
  final formKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;
  late EventsBloc _bloc ;




  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }


  @override
  void start() {
    _bloc = instance<EventsBloc>();
  }

  @override
  Future<void> onRegisterPressed({
    required GlobalKey<FormState>? formKey,
    required String fullName,
    required String email,
    required String password,
  }) async {
    CreateUserRequirements req = CreateUserRequirements(email: email , password: password , fullName: fullName);
    if(formKey!.currentState!.validate()){
      _bloc.add(StartCreateUserEvent(  req));
    }
  }

  @override
  onSignInwWithGooglePress() async {
    _bloc.add(SignInWithGoogleEvent());
  }


  @override
  onUserAddedSuccessfully() {
    navigateTo(context, RouteStringsManager.takeUserDetailsRoute);
  }

  @override
  onUserExist() {
    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>MainRoute()) , (Route<dynamic> route) => false);

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

  onUserAddedSuccessfully();
  onUserExist();

}
