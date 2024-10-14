import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/components/constants/assets_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/icons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/notification_handler.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/text_form_manager.dart';
import 'package:event_mobile_app/presentation/routs&view_models/regeister/regeister_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pulsator/pulsator.dart';
import 'package:staggered_animated_widget/animation_direction.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../components/constants/color_manager.dart';
import '../../components/constants/general_strings.dart';
import '../../components/constants/variables_manager.dart';

class RegisterRoute extends StatefulWidget {
  const RegisterRoute({super.key});

  @override
  State<RegisterRoute> createState() => _RegisterRouteState();
}

class _RegisterRouteState extends State<RegisterRoute> {
  final RegisterModelView _model = RegisterModelView();

  @override
  void initState() {
    super.initState();
    _model.context = context;
    _model.start();

  }

  @override
  Widget build(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);
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
                  icon: Icon(Icons.favorite),
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
          state is SignInWithGoogleStateError
          ) {
            Navigator.pop(context);
          }
          if (state is SignInWithGoogleStateError) {
            errorNotification(
                context: context, description: state.error.toString(), backgroundColor: VariablesManager.isDark ? Colors.grey.shade400 : Colors.white);
          }
          if (state is AddUserToFirebaseStateError) {
            errorNotification(
                context: context, description: state.error.toString(), backgroundColor: VariablesManager.isDark ? Colors.grey.shade400 : Colors.white);
          }
          if (state is CreateUserStateError) {
            errorNotification(
                context: context, description: state.error.toString(), backgroundColor: VariablesManager.isDark ? Colors.grey.shade400 : Colors.white);
          }

          if (state is AddUserToFirebaseStateSuccess ||state is SignInWithGoogleStateSuccess ) {
            successNotification(
                context: context, description: GeneralStrings.accountCreated, backgroundColor: VariablesManager.isDark ? Colors.grey.shade400 : Colors.white);
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
                  padding: const EdgeInsets.all(SizeManager.d14),
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
                              GeneralStrings.login,
                              style: TextStyle(
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: SizeManager.d50,
                                  fontFamily: GeneralStrings.cormo,
                                  color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: SizeManager.d14,
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i200,
                        direction: AnimationDirection.fromLeft,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(GeneralStrings.welcomeBack,
                                style: TextStyleManager.lightTitle(context),),),
                      ),
                      SizedBox(
                        height: SizeManager.d30,
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i300,
                        direction: AnimationDirection.fromLeft,
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              GeneralStrings.register,
                              style: TextStyle(
                                  fontWeight: FontWeightManager.bold,
                                  fontSize: SizeManager.d50,
                                  fontFamily: GeneralStrings.cormo,
                                  color: Colors.black),
                            )),
                      ),
                      SizedBox(
                        height: SizeManager.d30,
                      ),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i400,
                          child: textFormField(
                            context: context,
                            controller: _model.fullNameController,
                            hintText: GeneralStrings.ahmadKhalid,
                            labelText: GeneralStrings.fullName,
                            prefix: Icon(IconsManager.profile),
                            onFieldSubmitted: (p0) => _model.toNextField,
                            validator: (p0) => _model.validator(p0),
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
                            labelText: GeneralStrings.email,
                            prefix: Icon(IconsManager.email),
                            onFieldSubmitted: (p0) => _model.toNextField,
                            validator: (p0) => _model.validator(p0),
                          )),
                      SizedBox(
                        height: SizeManager.d20,
                      ),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i800,
                          child: textFormField(
                            context: context,
                              controller: _model.passwordController,
                              labelText: GeneralStrings.password,
                              prefix: Icon(IconsManager.key),
                              onFieldSubmitted: (p0) => _model.toNextField,
                              validator: (p0) => _model.validator(p0),
                              suffix: Icon(IconsManager.hide))),
                      SizedBox(
                        height: SizeManager.d20,
                      ),
                      _button(
                          onTap: () {
                            _model.onRegisterPressed(
                                formKey: _model.formKey,
                                email: _model.emailController.text,
                                password: _model.passwordController.text,
                                fullName: _model.fullNameController.text);
                          },
                          nameOfButton: GeneralStrings.register,
                          sufixSvgAssetPath: AssetsManager.login,
                          color: ColorManager.primarySecond),
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
                              GeneralStrings.or,
                              style: TextStyleManager.lightTitle(context),
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
                      _button(
                          onTap: () => _model.onSignInwWithGooglePress(),
                          nameOfButton: GeneralStrings.signWithGoogle,
                          prefixSvgAssetPath: AssetsManager.google),
                      SizedBox(height: SizeManager.d30),
                      _button(
                          nameOfButton: GeneralStrings.signWithApple,
                          prefixSvgAssetPath: AssetsManager.apple),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );

  Widget _button({
    required String nameOfButton,
    void Function()? onTap,
    String? prefixSvgAssetPath,
    String? sufixSvgAssetPath,
    Color? color,
  }) {
    return StaggeredAnimatedWidget(
      delay: SizeManager.i1400,
      child: GestureDetector(
        onTap: onTap,
        child: ContainerManager.myContainer(
          color: color ?? Colors.grey.shade400,
          context: context,
          child: Padding(
            padding: const EdgeInsets.all(SizeManager.d12),
            child: Align(
              alignment: Alignment.center,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Spacer(),
                    if (prefixSvgAssetPath != null)
                      SvgPicture.asset(
                        prefixSvgAssetPath,
                        height: SizeManager.d50,
                        width: SizeManager.d70,
                      ),
                    SizedBox(width: SizeManager.d20),
                    Text(
                      nameOfButton,
                      style: TextStyleManager.lightTitle(context),
                    ),
                    Spacer(),
                    if (sufixSvgAssetPath != null)
                      SvgPicture.asset(
                        sufixSvgAssetPath,
                        height: SizeManager.d50,
                        width: SizeManager.d70,
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
}
