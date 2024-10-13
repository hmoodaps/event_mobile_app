import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/components/constants/assets_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/general_strings.dart';
import 'package:event_mobile_app/presentation/components/constants/icons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/notification_handler.dart';
import 'package:event_mobile_app/presentation/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/routs_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/text_form_manager.dart';
import 'package:event_mobile_app/presentation/routs&view_models/login/login_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:staggered_animated_widget/animation_direction.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';
import '../../components/constants/color_manager.dart';

class LoginRoute extends StatefulWidget {
  const LoginRoute({super.key});

  @override
  State<LoginRoute> createState() => _LoginRouteState();
}

class _LoginRouteState extends State<LoginRoute> {
  final LoginModelView _model = LoginModelView();

  @override
  void initState() {
    _model.context = context;
    _model.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => getScaffold(),
        listener: (context, state) {
          if(state is LoginState){
            showDialog(context: context, builder: (context) => Center(
              child: LoadingIndicator(
                indicatorType: Indicator.squareSpin, /// Required, The loading type of the widget
                colors: const [ColorManager.primarySecond],       /// Optional, The color collections
                strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor
            ),),);
          }
          if(state is LoginSuccessState ||state is LoginErrorState  ||state is  SignInWithGoogleStateSuccess ||state is  SignInWithGoogleStateError){Navigator.pop(context);}
          if(state is LoginSuccessState){
            navigatorToTheMain(context);
          }
          if(state is LoginErrorState){
            errorNotification(context: context, description: state.error.toString());
          }
          if(state is SignInWithGoogleState){
            showDialog(context: context, builder: (context) => Center(
              child: LoadingIndicator(
                  indicatorType: Indicator.squareSpin, /// Required, The loading type of the widget
                  colors: const [ColorManager.primarySecond],       /// Optional, The color collections
                  strokeWidth: 2,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                  backgroundColor: Colors.transparent,      /// Optional, Background of the widget
                  pathBackgroundColor: Colors.transparent   /// Optional, the stroke backgroundColor
              ),),);

          }
          if(state is SignInWithGoogleStateSuccess){
            if(_model.checkUserExisting()){
              navigatorToTheMain(context);
            }else{
              navigateTo(context, RouteStringsManager.takeUserDetailsRoute);
            }
          }
          if(state is SignInWithGoogleStateError){            errorNotification(context: context, description: state.error.toString());


          }
        });
  }

  Widget getScaffold() => Scaffold(
        appBar: AppBar(
          backgroundColor: ColorManager.primarySecond,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconsManager.arrowBack,
            color: ColorManager.primary,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _model.formKey,
            child: Padding(
              padding: const EdgeInsets.all(SizeManager.d20),
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
                          GeneralStrings .login,
                          style: TextStyle(
                              fontWeight: FontWeightManager.bold,
                              fontSize: SizeManager.d50,
                              fontFamily: GeneralStrings .cormo,
                              color: Colors.black),
                        )),
                  ),
                  SizedBox(
                    height: SizeManager.d30,
                  ),
                  StaggeredAnimatedWidget(
                    delay: SizeManager.i400,
                    direction: AnimationDirection.fromLeft,
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(GeneralStrings .welcomeBack,
                            style: TextStyleManager.lightTitle)),
                  ),
                  SizedBox(
                    height: SizeManager.d30,
                  ),
                  StaggeredAnimatedWidget(
                      delay: SizeManager.i600,
                      child: textFormField(
                        controller: _model.emailController,
                        hintText: GeneralStrings .ahmadEmail,
                        labelText: GeneralStrings .email,
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
                          controller: _model.passwordController,
                          labelText: GeneralStrings .password,
                          prefix: Icon(IconsManager.key),
                          onFieldSubmitted: (p0) => _model.toNextField,
                          validator: (p0) => _model.validator(p0),
                          suffix: Icon(IconsManager.hide))),
                  SizedBox(
                    height: SizeManager.d10,
                  ),
                  StaggeredAnimatedWidget(
                    delay: SizeManager.i900,
                    child: TextButton(
                      onPressed: () => _model.onForgetPasswordPress,
                      child: Text(
                        GeneralStrings .forgetPassword,
                        style: TextStyle(
                          color: ColorManager.primarySecond,
                          fontSize: SizeManager.d18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeManager.d20,
                  ),
                  _button(
                      delay: SizeManager.i1000,
                      onTap: () {
                        _model.onLoginPressed(
                          formKey: _model.formKey,
                          email: _model.emailController.text,
                          password: _model.passwordController.text,
                        );
                      },
                      nameOfButton: GeneralStrings .login,
                      sufixSvgAssetPath: AssetsManager.login,
                      color: ColorManager.primarySecond),
                  SizedBox(
                    height: SizeManager.d30,
                  ),
                  StaggeredAnimatedWidget(
                    delay: SizeManager.i1200,
                    direction: AnimationDirection.fromLeft,
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
                          GeneralStrings .or,
                          style: TextStyleManager.lightTitle,
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
                    onTap: ()=>_model.onSignInwWithGooglePress(),
                      delay: 1400,
                      nameOfButton: GeneralStrings .signWithGoogle,
                      prefixSvgAssetPath: AssetsManager.google),
                  SizedBox(height: SizeManager.d30),
                  _button(
                      delay: 1600,
                      nameOfButton: GeneralStrings .signWithApple,
                      prefixSvgAssetPath: AssetsManager.apple),
                ],
              ),
            ),
          ),
        ),
      );

  Widget _button(
      {required String nameOfButton,
      void Function()? onTap,
      String? prefixSvgAssetPath,
      String? sufixSvgAssetPath,
      Color? color,
      int? delay}) {
    return StaggeredAnimatedWidget(
      delay: delay ?? SizeManager.i1400,
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
                      style: TextStyleManager.lightTitle,
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
