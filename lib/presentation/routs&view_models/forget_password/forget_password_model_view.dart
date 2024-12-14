import 'dart:async';

import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/components/constants/notification_handler.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';

import '../../../app/components/tranlate_massages/translate_massage.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';

class ForgetPasswordModelView extends BaseViewModel
    with ForgetPasswordModelFunctions {
  final emailController = TextEditingController();
  late final EventsBloc _bloc;
  late StreamSubscription blocStreamSubscription;
  late final BuildContext context;

  ForgetPasswordModelView(this.context);

  @override
  void dispose() {
    emailController.dispose();
    // تأكد من إلغاء الاشتراك عند التخلص من ViewModel.
    blocStreamSubscription.cancel();
  }

  @override
  resetPassword(String email) {
    _bloc.add(ResetPasswordEvent(email));
  }

  @override
  onResetPasswordSuccessState() {
    successNotification(
        context: context,
        description: GeneralStrings.passwordResetSuccess(context),
        backgroundColor: VariablesManager.isDark
            ? ColorManager.privateGrey
            : ColorManager.primary);
    navigateToMainRoute(context);
  }

  errorNoti(String error) => errorNotification(
      context: context,
      description: translateErrorMessage(error, context),
      backgroundColor:
          VariablesManager.isDark ? Colors.grey.shade400 : Colors.white);

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    startListin();
  }

  startListin() {
    blocStreamSubscription = _bloc.stream.listen(
      (state) {
        if (state is ResetPasswordSuccessState) {
          onResetPasswordSuccessState();
        }
        if (state is ResetPasswordErrorState) {
          errorNoti(state.error);
        }
      },
    );
  }
}

mixin ForgetPasswordModelFunctions {
  resetPassword(String email);

  onResetPasswordSuccessState();
}
