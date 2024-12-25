import 'dart:async';

import 'package:event_mobile_app/app/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../app/components/constants/notification_handler.dart';
import '../../../app/components/tranlate_massages/translate_massage.dart';
import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';

class TakeUserDetailsModelView extends BaseViewModel
    with TakeUserDetailsFunctions {
  TakeUserDetailsModelView(this.context);

  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController additionalInfo = TextEditingController();
  TextEditingController street = TextEditingController();
  late final StreamSubscription blocStreamSubscription;

  late final BuildContext context;

  final formKey = GlobalKey<FormState>();

  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(
      DateTime.now().year - 16 - 1930 + 1, (index) => 1930 + index);

  int selectedDay = 26;
  int selectedMonth = 5;
  int selectedYear = 1999;
  late EventsBloc _bloc;

  @override
  void dispose() {
    blocStreamSubscription.cancel();
    dateOfBirth.dispose();
    houseNumber.dispose();
    mobileNumber.dispose();
    postalCode.dispose();
    city.dispose();
    additionalInfo.dispose();
    street.dispose();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    startListen();
  }

  @override
  onContinueTap({required CreateUserRequirements req}) {
    _bloc.add(AddUserDetailsEvent(req: req));
  }

  @override
  onSkipTap() {
    Navigator.pushNamedAndRemoveUntil(
        context, RouteStringsManager.mainRoute, (route) => false);
  }

  navigateToMain() {
    Navigator.pushReplacementNamed(
      context,
      RouteStringsManager.mainRoute,
    );
  }

  errorNoti(String msg) => errorNotification(
      context: context, description: translateErrorMessage(msg, context));

  startListen() {
    blocStreamSubscription = _bloc.stream.listen((state) async {
      if (state is AddUserDetailsSuccessState) {
        navigateToMain();
      }
      if (state is AddUserDetailsErrorState) {
        errorNoti(state.error);
      }
    });
  }
}

mixin TakeUserDetailsFunctions {
  onContinueTap({required CreateUserRequirements req});

  onSkipTap();
}
