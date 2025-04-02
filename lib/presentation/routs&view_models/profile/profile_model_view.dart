import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mobile_app/app/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/app/components/constants/routs_manager.dart';
import 'package:event_mobile_app/app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/about_us_route/about_us_model_view.dart';
import 'package:event_mobile_app/presentation/routs&view_models/coupon_route/coupons_model_view.dart';
import 'package:event_mobile_app/presentation/routs&view_models/feedback_and_complaints_route/feedback_and_complaints_model_view.dart';
import 'package:event_mobile_app/presentation/routs&view_models/orders_rout/orders_rout.dart';
import 'package:event_mobile_app/presentation/routs&view_models/orders_rout/orders_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/dio_and_mapper_constants.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../app/dependencies_injection/dependency_injection.dart' as FirebaseFirestore;
import '../../../app/handle_app_language/handle_app_language.dart';
import '../../../app/handle_app_theme/handle_app_theme_colors.dart';
import '../../../data/local_storage/shared_local.dart';
import '../../../domain/models/billing_info/billing_info.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';

class ProfileModelView extends BaseViewModel with ProfileModelViewFunctions {
  late final EventsBloc bloc;
  late final BuildContext context;
  late final StreamSubscription blocStreamSubscription;

  ProfileModelView(this.context);

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
    bool isManual = SharedPref.prefs.getBool(GeneralStrings.isManual)!;
    selectedModeIndex = _getModeIndex(isManual);

    bloc.add(LoadPreferencesEvent(
      selectedModeIndex: selectedModeIndex,
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
      case 'ru': // Russian language index
        return SizeManager.i6;
      case 'it': // Italian language index
        return SizeManager.i7;
      case 'de': // German language index
        return SizeManager.i8;
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
      context: context,
    ));
  }

  @override
  void onFeedbackButtonPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => FeedbackPage(),));
  }

  @override
  void onAboutUsButtonPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => AboutUsPage(),));
  }

  @override
  void onPrivacyButtonPressed() {
    _logButtonPress("Privacy");
  }

  @override
  void onLogoutButtonPressed() {
    bloc.add(LogoutEvent());
  }

  // Future<List<BillingInfo>> _getUserBillsSimplified() async {
   Future<List<Map<String , dynamic>>> _getUserBillsSimplified() async {
    try {
      final List<BillingInfo> billsInfo = [] ;
      final userDoc = await VariablesManager.firestoreInstance
          .collection(GeneralStrings.users)
          .doc(FirebaseAuth.instance.currentUser!.uid).get();

      if (!userDoc.exists) {
        throw Exception('User not found');
      }
      final bills = userDoc.data()?['bills'] as List<dynamic>?;

      if (bills == null || bills.isEmpty) {
        return [];
      }

      return bills.map((bill) => bill as Map<String, dynamic>).toList();
      // for(Map<String, dynamic> bill in bills){
      //   final BillingInfo billingInfo = BillingInfo.fromJson(bill);
      //   billsInfo.add(billingInfo);
      // }
      // return billsInfo;
    } catch (e) {
      print('Error fetching bills: $e');
      throw Exception('Failed to load bills');
    }
  }
  @override
  void onOrdersButtonPressed()async {
  final  bills = await _getUserBillsSimplified();

     Navigator.push(context, MaterialPageRoute(builder: (context) => BillsPage(bills: bills),));
    // Navigator.push(context, MaterialPageRoute(builder: (context) => PurchasedMoviesPage(bills: bills),));
  }

  @override
  void onCouponsButtonPressed() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => CouponsPage(),));
  }

  @override
  void onMyAppBalanceButtonPressed() {
    _logButtonPress("My App Balance");
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

  @override
  void onChangeLanguageRussian() =>
      _changeLanguage(ApplicationLanguage.ru, SizeManager.i6);

  @override
  void onChangeLanguageItalian() =>
      _changeLanguage(ApplicationLanguage.it, SizeManager.i7);

  @override
  void onChangeLanguageGerman() =>
      _changeLanguage(ApplicationLanguage.de, SizeManager.i8);

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


  void onLogoutButtonPressed();

  void onOrdersButtonPressed();

  void onCouponsButtonPressed();

  void onMyAppBalanceButtonPressed();


  void onLoginOrRegister();

  void onChangeLanguageNetherlands();

  void onChangeLanguageSpanish();

  void onChangeLanguageFranch();

  void onChangeLanguageArabic();

  void onChangeLanguageGerman();

  void onChangeLanguageRussian();

  void onChangeLanguageItalian();

  void onChangeLanguageEnglish();

  void onChangeThemeBasedOnPhone();

  void onChangeThemeManual();

  void onChangeColorGreen();

  void onChangeColorBlue();

  void onChangeColorPurple();

  void onChangeThemeManualToDark();

  void onChangeThemeManualToLight();
}


