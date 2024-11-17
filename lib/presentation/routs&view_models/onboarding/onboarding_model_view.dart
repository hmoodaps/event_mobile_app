import 'dart:async';

import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
import '../../../data/local_storage/shared_local.dart';

class OnboardingModelView extends BaseViewModel
    with OnboardingModelViewInputs, OnboardingModelViewOutput {
  final StreamController<bool> _lastPageStreamController =
      StreamController<bool>();
  late BuildContext? context;
  late List<Widget> pages;

  @override
  void start() {}

  @override
  void dispose() {
    _lastPageStreamController.close();
  }

  @override
  Sink<bool> get lastPageSink => _lastPageStreamController.sink;

  @override
  Stream<bool> get lastPageStream => _lastPageStreamController.stream;

  @override
  void checkIndex(int index) {
    bool isLast = index == pages.length - 1;
    lastPageSink.add(isLast);
  }

  @override
  void onContinuePressed() {
    SharedPref.saveBool(key: GeneralStrings.isFirstTimeOpened, value: false);
    navigateTo(context!, RouteStringsManager.questionRoute);
  }
}

mixin OnboardingModelViewInputs {
  Sink<bool> get lastPageSink;

  void checkIndex(int index);

  void onContinuePressed();
}

mixin OnboardingModelViewOutput {
  Stream<bool> get lastPageStream;
}

//on boarding models
class OnboardingModels {}
