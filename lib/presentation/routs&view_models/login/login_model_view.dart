import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:flutter/cupertino.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../app/dependencies_injection/dependency_injection.dart';
import '../../../domain/local_models/models.dart';

class LoginModelView extends BaseViewModel with LoginModelViewFunctions {
  // initialize variables to apply "Separation of Concerns"
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late final BuildContext context;
  final EventsBloc _bloc = instance<EventsBloc>();

  // Create user in Firebase
  @override
  onLoginPressed({
    required GlobalKey<FormState>? formKey,
    required String email,
    required String password,
  }) async {
    CreateUserRequirements req = CreateUserRequirements(
      email: email,
      password: password,
    );
    if (formKey!.currentState!.validate()) {
      _bloc.add(LoginEvent(req));
    }
  }

  @override
  void dispose() {
    emailController.dispose(); // Dispose of controllers to avoid memory leaks
    passwordController.dispose();
  }

  @override
  void start() {}

  @override
  onForgetPasswordPress() {
    navigateTo(context, RouteStringsManager.forgetPasswordRoute);
  }

  @override
  onSignInwWithApplePress() async {}

  @override
  onSignInwWithGooglePress() async {
    _bloc.add(SignInWithGoogleEvent());
  }

  @override
  onUserAddedSuccessfully() {
    navigateTo(context, RouteStringsManager.takeUserDetailsRoute);
  }
}

mixin LoginModelViewFunctions {
  Future<void> onLoginPressed({
    required GlobalKey<FormState>? formKey,
    required String email,
    required String password,
  });

  void onUserAddedSuccessfully();

  void onForgetPasswordPress();

  void onSignInwWithGooglePress();

  void onSignInwWithApplePress();
}
