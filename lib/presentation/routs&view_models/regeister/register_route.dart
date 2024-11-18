import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mobile_app/presentation/routs&view_models/regeister/regeister_model_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
import '../../../app/components/tranlate_massages/translate_massage.dart';
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
    _model = RegisterModelView();
    _model.context = context;
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
    bool isPressed = false;
    // EventsBloc bloc = instance();
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => getScaffold(isPressed),
        listener: (context, state) async {
          if (state is SignInWithGoogleStateError) {
            errorNotification(
                context: context,
                description: translateErrorMessage(state.error, context),
                backgroundColor: VariablesManager.isDark
                    ? Colors.grey.shade400
                    : Colors.white);
          }

          if (state is UserCreatedErrorState) {
            errorNotification(
                context: context,
                description: translateErrorMessage(state.error, context),
                backgroundColor: VariablesManager.isDark
                    ? Colors.grey.shade400
                    : Colors.white);
          }


          if (state is UserCreatedSuccessState) {
            _model.onCreateNewUser();
          }

          if (state is SignInWithGoogleUserExistState) {
            final docSnapshot = await FirebaseFirestore.instance
                .collection(GeneralStrings.users)
                .doc(FirebaseAuth.instance.currentUser!.uid)
                .get();

            if (docSnapshot.exists) {
              final data = docSnapshot.data();

              if (data != null && (data['additionalInfo'] != null)) {
                _model.onAddExistUser();
              } else {
                _model.onCreateNewUser();
              }
            } else {
              if (kDebugMode) {
                print("User document does not exist.");
              }
            }
          }
        });
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
                      !isPressed
                          ? googleAndAppleButton(
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
