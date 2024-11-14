import 'dart:io';
import 'package:event_mobile_app/app/components/tranlate_massages/translate_massage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/regeister/regeister_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulsator/pulsator.dart';
import 'package:staggered_animated_widget/animation_direction.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';
import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/notification_handler.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/text_form_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/local_models/models.dart';

class RegisterRoute extends StatefulWidget {
  const RegisterRoute({super.key});

  @override
  State<RegisterRoute> createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  late final RegisterModelView _model;

  @override
  void initState() {
    super.initState();
    _model = RegisterModelView();
    _model.context = context;
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
    // EventsBloc bloc = instance();
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => getScaffold(),
        listener: (context, state) {
          if (state is SignInWithGoogleState) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child:
                    // The clean code principle hasn't been followed here,
                    // as this widget may change or be replaced with a progress indicator in the future.
                    // It might be worthwhile to consider making the code more flexible
                    // by using an interface or a function to easily change the type of widget.

                    PulseIcon(
                  icon: Icons.favorite,
                  pulseColor: Colors.red,
                  iconColor: Colors.white,
                  iconSize: 44,
                  innerSize: 54,
                  pulseSize: 116,
                  pulseCount: 4,
                  pulseDuration: Duration(seconds: 4),
                ),
              ),
            );
          }
          if (state is StartCreateUserState) {
            showDialog(
              context: context,
              builder: (context) => Center(
                child: Image.asset(
                  'assets/images/cuteAnimation.gif',
                  width: 200,
                  height: 200,
                ),
              ),
            );
          }
          if (state is AddUserToFirebaseStateSuccess ||
              state is AddUserToFirebaseStateError ||
              state is CreateUserStateError ||
              state is SignInWithGoogleStateSuccess ||
              state is SignInWithGoogleStateError) {
            Navigator.pop(context);
          }
          if (state is SignInWithGoogleStateError) {
            errorNotification(
                context: context,
                description: translateErrorMessage(state.error, context),
                backgroundColor: VariablesManager.isDark
                    ? Colors.grey.shade400
                    : Colors.white);
          }
          if (state is AddUserToFirebaseStateError) {
            errorNotification(
                context: context,
                description: translateErrorMessage(state.error, context),
                backgroundColor: VariablesManager.isDark
                    ? Colors.grey.shade400
                    : Colors.white);
          }
          if (state is CreateUserStateError) {
            errorNotification(
                context: context,
                description: translateErrorMessage(state.error, context),
                backgroundColor: VariablesManager.isDark
                    ? Colors.grey.shade400
                    : Colors.white);
          }

          if (state is AddUserToFirebaseStateSuccess ||
              state is SignInWithGoogleStateSuccess) {
            successNotification(
                context: context,
                description: GeneralStrings.accountCreated(context),
                backgroundColor: VariablesManager.isDark
                    ? Colors.grey.shade400
                    : Colors.white);
          }
          if (state is SignInWithGoogleUserExist) {
            _model.onUserExist();
          }
          if (state is SignInWithGoogleUserNotExist) {
            _model.onUserAddedSuccessfully();
          }
        });
  }

  Widget getScaffold() => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconsManager.arrowBack),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _model.formKey,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(SizeManager.d14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i200,
                        direction: AnimationDirection.fromLeft,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            GeneralStrings.register(context),
                            style: TextStyle(
                                fontWeight: FontWeightManager.bold,
                                fontSize: SizeManager.d50,
                                fontFamily: GeneralStrings.cormo,
                                color:               VariablesManager.isDark ? Colors.white: ColorManager.primarySecond ,
                                ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeManager.d14,
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i300,
                        direction: AnimationDirection.fromLeft,
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            GeneralStrings.letsCreateAccount(context),
                            style: TextStyleManager.bodyStyle(context),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: SizeManager.d30,
                      ),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i400,
                          child: textFormField(
                            context: context,
                            controller: _model.fullNameController,
                            hintText: GeneralStrings.ahmadKhalid(context),
                            labelText: GeneralStrings.fullName(context),
                            prefix: Icon(IconsManager.profile),
                            onFieldSubmitted: (p0) => toNextField,
                            validator: (p0) => validator(p0),
                          )),
                      SizedBox(
                        height: SizeManager.d20,
                      ),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i600,
                          child: textFormField(
                            context: context,
                            controller: _model.emailController,
                            hintText: GeneralStrings.ahmadEmail,
                            labelText: GeneralStrings.email(context),
                            prefix: Icon(IconsManager.email),
                            onFieldSubmitted: (p0) => toNextField,
                            validator: (p0) => validator(p0),
                          )),
                      SizedBox(
                        height: SizeManager.d20,
                      ),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i800,
                          child: textFormField(
                              context: context,
                              controller: _model.passwordController,
                              labelText: GeneralStrings.password(context),
                              prefix: Icon(IconsManager.key),
                              onFieldSubmitted: (p0) => toNextField,
                              validator: (p0) => validator(p0),
                              suffix: Icon(IconsManager.hide))),
                      SizedBox(
                        height: SizeManager.d20,
                      ),
                      googleAndAppleButton(
                          onTap: () {
                            _model.onRegisterPressed(
                                formKey: _model.formKey,
                                email: _model.emailController.text,
                                password: _model.passwordController.text,
                                fullName: _model.fullNameController.text);
                          },
                          nameOfButton: GeneralStrings.register(context),
                          sufixSvgAssetPath: AssetsManager.login,
                          color: ColorManager.primarySecond,
                          context: context),
                      SizedBox(
                        height: SizeManager.d30,
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i1000,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: 1,
                                color: ColorManager.primary,
                              ),
                            ),
                            SizedBox(
                              width: SizeManager.d2,
                            ),
                            Text(
                              GeneralStrings.or(context),
                              style: TextStyleManager.titleStyle(context),
                            ),
                            SizedBox(
                              width: SizeManager.d2,
                            ),
                            Expanded(
                              child: Container(
                                height: 1,
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: SizeManager.d20,
                      ),
                      googleAndAppleButton(
                          onTap: () => _model.onSignInwWithGooglePress(),
                          nameOfButton: GeneralStrings.signWithGoogle(context),
                          prefixSvgAssetPath: AssetsManager.google,
                          context: context),
                      if (Platform.isIOS) SizedBox(height: SizeManager.d30),
                      if (Platform.isIOS)
                        googleAndAppleButton(
                          nameOfButton: GeneralStrings.signWithApple(context),
                          prefixSvgAssetPath: AssetsManager.apple,
                          context: context,
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
}
