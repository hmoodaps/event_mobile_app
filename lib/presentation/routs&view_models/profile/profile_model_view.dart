import 'dart:async';

import 'package:event_mobile_app/app/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/app/components/constants/routs_manager.dart';
import 'package:event_mobile_app/app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import '../../../app/components/constants/dio_and_mapper_constants.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/handle_app_language/handle_app_language.dart';
import '../../../app/handle_app_theme/handle_app_theme_colors.dart';
import '../../../data/local_storage/shared_local.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';

class ProfileModelView extends BaseViewModel with ProfileModelViewFunctions {
  late final EventsBloc bloc;
  late final BuildContext context;
  late final StreamSubscription blocStreamSubscription;

  int? selectedLanguageIndex;
  int? selectedColorIndex;
  int? selectedModeIndex;
  int? toggleBetweenModesIndex;

  @override
  void dispose() {
    blocStreamSubscription.cancel();
  }

  @override
  void start() {
    bloc = EventsBloc.get(context);
    loadPreferences();
    blocStreamSubscription = bloc.stream.listen((state) {
      if (state is LoadPreferencesState) {
        selectedColorIndex = state.selectedColorIndex;
        selectedLanguageIndex = state.selectedLanguageIndex;
        selectedModeIndex = state.selectedModeIndex;
      }
      if (state is ChangeAppLanguageState) {
        selectedLanguageIndex = state.selectedLanguageIndex;
      }
      if (state is ChangeColorThemeState) {
        selectedColorIndex = state.selectedColorIndex;
      }
    });
  }

  @override
  Future<void> loadPreferences() async {
    String currentLanguage =
        SharedPref.prefs.getString(GeneralStrings.appLanguage) ?? 'en';
    selectedLanguageIndex = _getLanguageIndex(currentLanguage);

    String currentColor =
        SharedPref.prefs.getString(GeneralStrings.colorTheme) ?? 'green';
    selectedColorIndex = _getColorIndex(currentColor);
bool isManual = SharedPref.getBool(GeneralStrings.isManual)!;
    selectedModeIndex = _getModeIndex(isManual);

    bloc.add(LoadPreferencesEvent(
      selectedModeIndex:selectedModeIndex ,
      selectedLanguageIndex: selectedLanguageIndex!,
      selectedColorIndex: selectedColorIndex!,
    ));
  }

  int _getLanguageIndex(String language) {
    switch (language) {
      case 'nl':
        return AppConstants.intZero;
      case 'es':
        return SizeManager.i1;
      case 'fr':
        return SizeManager.i2;
      case 'ar':
        return SizeManager.i3;
        case 'tr':
        return SizeManager.i5;
      case 'en':
      default:
        return SizeManager.i4;
    }
  }

  int _getColorIndex(String color) {
    switch (color) {
      case 'green':
        return AppConstants.intZero;
      case 'blue':
        return SizeManager.i1;
      case 'purple':
        return SizeManager.i2;
      default:
        return AppConstants.intZero;
    }
  }
  int _getModeIndex(bool isManual) {
    switch (isManual) {
      case false:
        return AppConstants.intZero;
      case true:
        return SizeManager.i1;
      default:
        return AppConstants.intZero;
    }
  }

  void _changeLanguage(ApplicationLanguage language, int index) {
    bloc.add(ChangeLanguageEvent(
      applicationLanguage: language,
      selectedLanguageIndex: index,
    ));
  }

  void _changeColor(AppColorsTheme color, int index) {
    bloc.add(ChangeColorModeEvent(
      appColorsTheme: color,
      selectedColorIndex: index,
    ));
  }

  @override
  void onFeedbackButtonPressed() {
    _logButtonPress("Feedback");
  }

  @override
  void onAboutUsButtonPressed() {
    _logButtonPress("About Us");
  }

  @override
  void onPrivacyButtonPressed() {
    _logButtonPress("Privacy");
  }

  @override
  void onLogoutButtonPressed() {
    bloc.add(LogoutEvent());
  }

  @override
  void onOrdersButtonPressed() {
    _logButtonPress("Orders");
  }

  @override
  void onCouponsButtonPressed() {
    _logButtonPress("Coupons");
  }

  @override
  void onMyAppBalanceButtonPressed() {
    _logButtonPress("My App Balance");
  }

  @override
  void onAddressButtonPressed() {
    _logButtonPress("Address");
  }

  @override
  void onPaymentMethodsButtonPressed() {
    _logButtonPress("Payment Methods");
  }

  void _logButtonPress(String buttonName) {
    if (kDebugMode) {
      print("$buttonName button pressed!");
    }
  }

  @override
  void onLoginOrRegister() {
    navigateTo(context, RouteStringsManager.questionRoute);
  }

  // Language change methods
  @override
  void onChangeLanguageNetherlands() =>
      _changeLanguage(ApplicationLanguage.nl, AppConstants.intZero);
  void onChangeLanguageTurkish() =>
      _changeLanguage(ApplicationLanguage.tr, SizeManager.i5);

  @override
  void onChangeLanguageSpanish() =>
      _changeLanguage(ApplicationLanguage.es, SizeManager.i1);

  @override
  void onChangeLanguageFranch() =>
      _changeLanguage(ApplicationLanguage.fr, SizeManager.i2);

  @override
  void onChangeLanguageArabic() =>
      _changeLanguage(ApplicationLanguage.ar, SizeManager.i3);

  @override
  void onChangeLanguageEnglish() =>
      _changeLanguage(ApplicationLanguage.en, SizeManager.i4);

  // Theme and color change methods
  @override
  void onChangeThemeBasedOnPhone() {
  bloc.add(ChangeModeThemeEvent(false));
  }

  @override
  void onChangeThemeManual() {
    bloc.add(ChangeModeThemeEvent(true));
  }
  @override
  void onChangeThemeManualToDark() {
    bloc.add(ChangeModeEvent(AppTheme.dark));
  }
  @override
  void onChangeThemeManualToLight() {
    bloc.add(ChangeModeEvent(AppTheme.light));
  }

  @override
  void onChangeColorGreen() =>
      _changeColor(AppColorsTheme.green, AppConstants.intZero);

  @override
  void onChangeColorBlue() => _changeColor(AppColorsTheme.blue, SizeManager.i1);

  @override
  void onChangeColorPurple() =>
      _changeColor(AppColorsTheme.purple, SizeManager.i2);
}

mixin ProfileModelViewFunctions {
  Future<void> loadPreferences();

  void onFeedbackButtonPressed();

  void onAboutUsButtonPressed();

  void onPrivacyButtonPressed();

  void onLogoutButtonPressed();

  void onOrdersButtonPressed();

  void onCouponsButtonPressed();

  void onMyAppBalanceButtonPressed();

  void onAddressButtonPressed();

  void onPaymentMethodsButtonPressed();

  void onLoginOrRegister();

  void onChangeLanguageNetherlands();

  void onChangeLanguageSpanish();

  void onChangeLanguageFranch();

  void onChangeLanguageArabic();

  void onChangeLanguageEnglish();

  void onChangeThemeBasedOnPhone();

  void onChangeThemeManual();

  void onChangeColorGreen();

  void onChangeColorBlue();

  void onChangeColorPurple();
  void onChangeThemeManualToDark();
  void onChangeThemeManualToLight();
}
