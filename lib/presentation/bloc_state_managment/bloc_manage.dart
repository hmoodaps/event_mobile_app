import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/theme_manager.dart';
import '../../app/components/constants/variables_manager.dart';
import '../../data/handel_dark_and_light_mode/handel_dark_light_mode.dart';

class EventsBloc extends Bloc<AppEvents, AppStates> {
  EventsBloc() : super(InitialState()) {
    on<StartCreateUserEvent>((event, emit) => emit(StartCreateUserState()));
    on<CreateUserEventError>(
        (event, emit) => emit(CreateUserStateError(event.error.toString())));
    on<CreateUserEventSuccess>((event, emit) => emit(CreateUserStateSuccess()));

    on<AddUserToFirebaseEvent>((event, emit) => emit(AddUserToFirebaseState()));
    on<AddUserToFirebaseEventSuccess>(
        (event, emit) => emit(AddUserToFirebaseStateSuccess()));
    on<AddUserToFirebaseEventError>((event, emit) =>
        emit(AddUserToFirebaseStateError(event.error.toString())));

    on<LoginEvent>((event, emit) => emit(LoginState()));
    on<LoginSuccessEvent>((event, emit) => emit(LoginSuccessState()));
    on<LoginErrorEvent>(
        (event, emit) => emit(LoginErrorState(event.error.toString())));

    on<SignInWithGoogleEvent>((event, emit) => emit(SignInWithGoogleState()));
    on<SignInWithGoogleEventSuccess>(
        (event, emit) => emit(SignInWithGoogleStateSuccess()));
    on<SignInWithGoogleEventError>((event, emit) =>
        emit(SignInWithGoogleStateError(event.error.toString())));

    on<ChangeNavigationBarIndexEvent>(
        (event, emit) => emit(ChangeNavigationBarIndexState()));

    on<ToggleLightAndDarkEvent>((event, emit) {
      VariablesManager.isDark = !VariablesManager.isDark;
      VariablesManager.themeData =
          VariablesManager.isDark ? darkThemeData() : lightThemeData();
      emit(ToggleLightAndDarkState());
    });

    on<StartFetchFirebaseEvent>((event, emit) => emit(StartFetchFirebaseState()));
    on<InitFetchFirebaseEvent>((event, emit) => emit(InitFetchFirebaseState()));
    on<InitFetchFirebaseErrorEvent>((event, emit) => emit(InitFetchFirebaseErrorState(event.error)));

    on<StartFetchMoviesEvent>((event, emit) => emit(StartFetchMoviesState()));
    on<InitFetchMoviesEvent>((event, emit) => emit(InitFetchMoviesState()));
    on<InitFetchMoviesErrorEvent>((event, emit) => emit(InitFetchMoviesErrorState(event.error)));
  }

  // Static instance to access the bloc from anywhere in the app
  static EventsBloc get(BuildContext context) =>
      BlocProvider.of<EventsBloc>(context);

  // Toggle between themes
  Future<ThemeData?> toggleLightAndDark(BuildContext context) async{
    String toggleModeType = SharedPref.prefs.getString(GeneralStrings.toggleModeType) ?? GeneralStrings.basedOnPhone;

    if(toggleModeType == GeneralStrings.manual){
      AppTheme currentTheme = await AppThemeExtension.loadFromPreferences();
      currentTheme == AppTheme.dark
          ? await AppTheme.light.saveToPreferences()
        : await AppTheme.dark.saveToPreferences();
      add(ToggleLightAndDarkEvent());
    }else{
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    brightness == Brightness.dark
        ? (
            VariablesManager.themeData = darkThemeData(),
            VariablesManager.isDark = true
          )
        : (
            VariablesManager.themeData = lightThemeData(),
            VariablesManager.isDark = false
          );
    add(ToggleLightAndDarkEvent());
    return VariablesManager.themeData;
  }
  }

  lightHeader(BuildContext context) => Theme.of(context).textTheme.bodyLarge;

  lightTitle(BuildContext context) => Theme.of(context).textTheme.titleLarge;

  lightBody(BuildContext context) => Theme.of(context).textTheme.bodyLarge;

  lightParagraph(BuildContext context) => Theme.of(context).textTheme.labelLarge;
}
