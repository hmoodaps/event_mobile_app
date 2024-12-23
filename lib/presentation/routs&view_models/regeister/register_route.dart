import 'dart:io';

import 'package:event_mobile_app/presentation/routs&view_models/regeister/regeister_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_animated_widget/animation_direction.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/text_form_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';

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
    _model = RegisterModelView(context);
    _model.start();
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;

    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => getScaffold(isPressed),
    );
  }

  Widget getScaffold(bool isPressed) => Scaffold(
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
                              color: VariablesManager.isDark
                                  ? Colors.white
                                  : ColorManager.primarySecond,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d14, context),
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
                        height: GetSize.heightValue(SizeManager.d30, context),
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
                            validator: (p0) => validator(p0, context),
                          )),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d20, context),
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
                            validator: (p0) => validator(p0, context),
                          )),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d20, context),
                      ),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i800,
                          child: textFormField(
                              context: context,
                              controller: _model.passwordController,
                              labelText: GeneralStrings.password(context),
                              prefix: Icon(IconsManager.key),
                              onFieldSubmitted: (p0) => toNextField,
                              validator: (p0) => validator(p0, context),
                              suffix: Icon(IconsManager.hide))),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d20, context),
                      ),
                      !isPressed
                          ? googleAndAppleButton(
                              delay: SizeManager.i1200,
                              onTap: () {
                                setState(() {
                                  isPressed = true;
                                });
                                _model.onRegisterPressed(
                                    formKey: _model.formKey,
                                    email: _model.emailController.text,
                                    password: _model.passwordController.text,
                                    fullName: _model.fullNameController.text);
                              },
                              nameOfButton: GeneralStrings.register(context),
                              sufixSvgAssetPath: AssetsManager.login,
                              color: ColorManager.primarySecond,
                              context: context)
                          : CircularProgressIndicator(),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d30, context),
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i1200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                height: GetSize.heightValue(
                                    SizeManager.d1, context),
                                color: ColorManager.primary,
                              ),
                            ),
                            SizedBox(
                              width:
                                  GetSize.widthValue(SizeManager.d2, context),
                            ),
                            Text(
                              GeneralStrings.or(context),
                              style: TextStyleManager.titleStyle(context),
                            ),
                            SizedBox(
                              width:
                                  GetSize.widthValue(SizeManager.d2, context),
                            ),
                            Expanded(
                              child: Container(
                                height: GetSize.heightValue(
                                    SizeManager.d1, context),
                                color: ColorManager.primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d20, context),
                      ),
                      googleAndAppleButton(
                          delay: SizeManager.i1400,
                          onTap: () => _model.onSignInwWithGooglePress(),
                          nameOfButton: GeneralStrings.signWithGoogle(context),
                          prefixSvgAssetPath: AssetsManager.google,
                          context: context),
                      SizedBox(
                          height:
                              GetSize.heightValue(SizeManager.d30, context)),
                      Visibility(
                        visible: Platform.isIOS,
                        child: googleAndAppleButton(
                          nameOfButton: GeneralStrings.signWithApple(context),
                          prefixSvgAssetPath: AssetsManager.apple,
                          context: context,
                        ),
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
