import 'package:event_mobile_app/app/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/app/components/constants/text_form_manager.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/forget_password/forget_password_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/getSize/getSize.dart';

class ForgetPasswordRoute extends StatefulWidget {
  const ForgetPasswordRoute({super.key});

  @override
  State<ForgetPasswordRoute> createState() => _ForgetPasswordRouteState();
}

class _ForgetPasswordRouteState extends State<ForgetPasswordRoute> {
  late ForgetPasswordModelView _model;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = ForgetPasswordModelView(context);
    _model.start();
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
        builder: (context, state) => _getScaffold());
  }

  Widget _getScaffold() => Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(SizeManager.d24),
              child: Form(
                key: formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i200,
                          child: Text(
                            GeneralStrings.resetPassword(context),
                            style: TextStyleManager.header(context)
                                ?.copyWith(fontSize: SizeManager.d24),
                          )),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d50, context),
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i400,
                        child: Text(
                          GeneralStrings.ltsResetPassword(context),
                          style: TextStyleManager.titleStyle(context),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 8,
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i600,
                        child: textFormField(
                          controller: _model.emailController,
                          context: context,
                          labelText: GeneralStrings.ahmadEmail,
                          fillColor: ColorManager.privateGrey,
                          filled: true,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => validator(value, context),
                          prefix: Icon(IconsManager.email),
                        ),
                      ),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d50, context),
                      ),
                      googleAndAppleButton(
                        nameOfButton: GeneralStrings.resetPassword(context),
                        context: context,
                        delay: SizeManager.i800,
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            _model.resetPassword(
                                _model.emailController.text.trim());
                          }
                        },
                        color: ColorManager.primarySecond,
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
