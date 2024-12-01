import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import 'package:event_mobile_app/app/handle_app_language/handle_app_language.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../app/components/constants/theme_manager.dart';
import '../../app/components/constants/variables_manager.dart';
import '../../app/components/firebase_error_handler/firebase_error_handler.dart';
import '../../app/dependencies_injection/dependency_injection.dart';
import '../../app/handle_app_theme/handle_app_theme_colors.dart';
import '../../data/implementer/failure_class/failure_class.dart';
import '../../data/models/movie_model.dart';
import '../../domain/repository/add_user_details.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/init_repository.dart';
import '../../domain/repository/login_to_firebase_repo.dart';
import '../../domain/repository/register_in_firebase_repo.dart';
import '../../main.dart';
import 'events.dart';

class EventsBloc extends Bloc<AppEvents, AppStates> {
  // ======== Auth Handler ==========
  // Object for handling authentication=related operations
  final AuthRepository _auth = instance();

  // ======== Login Handler ==========
  // Object for managing login operations in Firebase
  final LoginToFirebaseRepo _login = instance();

  // ======== Register Handler ==========
  // Object for handling user registration operations
  final RegisterInFirebaseRepo _register = instance();

  // ======== Repository Handler ==========
  // Main injected_repository object for data management and access across the app
  final InitRepository _repository = instance();

  // ======== Add user Handler ==========
  // Main injected_repository object for data management and access across the app
  final AddUserDetailsRepo _addUserDetailsRepo = instance();

  EventsBloc() : super(InitialState()) {
    // Registering event handlers to listen and respond to various events
    on<StartCreateUserEvent>(_onCreateUserEvent);
    on<CreatingUserResultEvent>(_onCreatingUserResultEvent);
    on<ExtractDominantColorEvent>(_onExtractDominantColorEvent);
    on<LoginEvent>(_onLoginEvent);
    on<LoginResultEvent>(_onLoginResultEvent);
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<SignInWithGoogleResultEvent>(_onSignInWithGoogleResultEvent);
    on<SignInWithGoogleEventError>(_onSignInWithGoogleEventError);
    on<SignInWithGoogleEventSuccess>(_onSignInWithGoogleEventSuccess);
    on<StartFetchFirebaseEvent>(_onStartFetchFirebaseEvent);
    on<FetchFirebaseResultEvent>(_onStartFetchFirebaseEventResult);
    on<StartFetchMoviesEvent>(_onStartFetchMoviesEvent);
    on<FetchMoviesResultEvent>(_onFetchMoviesResultEvent);
    on<ToggleLightAndDarkEvent>(_onToggleLightAndDarkEvent);
    on<InternetStatusChangeEvent>(_onInternetStatusChangeEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<ChangeNavigationBarIndexEvent>(_onChangeNavigationBarIndexEvent);
    on<AddUserDetailsEvent>(_onAddUserDetailsEvent);
    on<AddUserDetailsResultEvent>(_onAddUserDetailsResultEvent);
    on<AddUserDetailsErrorEvent>(_onAddUserDetailsErrorEvent);
    on<AddUserDetailsSuccessEvent>(_onAddUserDetailsSuccessEvent);
    on<MoviesLoadedErrorEvent>(_onMoviesLoadedErrorEvent);
    on<MoviesLoadedSuccessEvent>(_onMoviesLoadedSuccessEvent);
    on<FetchFirebaseErrorEvent>(_onFetchFirebaseErrorEvent);
    on<FetchFirebaseSuccessEvent>(_onFetchFirebaseSuccessEvent);
    on<UserCreatedErrorEvent>(_onUserCreatedErrorEvent);
    on<UserCreatedSuccessEvent>(_onUserCreatedSuccessEvent);
    on<LoginErrorEvent>(_onLoginErrorEvent);
    on<LoginSuccessEvent>(_onLoginSuccessEvent);
    on<ChangeColorModeEvent>(_onChangeColorModeEvent);
    on<ChangeLanguageEvent>(_onChangeLanguageEvent);
    on<AddUserToFirebaseEvent>(_onAddUserToFirebaseEvent);
    on<SignInWithGoogleUserExistEvent>(_onSignInWithGoogleUserExistEvent);
    on<ResetPasswordEvent>(_onResetPasswordEvent);
    on<ResetPasswordErrorEvent>(_onResetPasswordErrorEvent);
    on<ResetPasswordSuccessEvent>(_onResetPasswordSuccessEvent);
    on<LoadPreferencesEvent>(_onLoadPreferencesEvent);
    on<ToLogoutEvent>(_onToLogoutEvent);
    on<ChangeModeEvent>(_onChangeModeEvent);
    on<ChangeModeThemeEvent>(_onChangeModeThemeEvent);
  }

  //create instance from Event bloc if we need new instance and cant use it from DI
  static EventsBloc get(context) => BlocProvider.of<EventsBloc>(context);

//====================Add User Details Handler=============================
  _onAddUserDetailsEvent(
      AddUserDetailsEvent event, Emitter<AppStates> emit) async {
    emit(AddUsersDetailsState());
    await _addUserDetailsRepo.addUserDetails(req: event.req).then((result) {
      add(AddUserDetailsResultEvent(result));
    });
  }

  _onAddUserDetailsResultEvent(
      AddUserDetailsResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold((error) {
      add(AddUserDetailsErrorEvent(error.firebaseException));
    }, (success) {
      add(AddUserDetailsSuccessEvent());
    });
  }

  Future<void> _onAddUserDetailsErrorEvent(
      AddUserDetailsErrorEvent event, Emitter<AppStates> emit) async {
    firebaseAuthErrorsHandler(
      state: (error) => AddUserDetailsErrorState(error),
      emit: emit,
      failure: event.error,
    );
  }

  Future<void> _onAddUserDetailsSuccessEvent(
      AddUserDetailsSuccessEvent event, Emitter<AppStates> emit) async {
    emit(AddUserDetailsSuccessState());
  }

//====================Log OUT=============================

  Future<void> _onLogoutEvent(
      LogoutEvent event, Emitter<AppStates> emit) async {
    await _login.logout();

    SharedPref.prefs.remove(GeneralStrings.currentUser);
    add(ToLogoutEvent());
  }

  Future<void> _onToLogoutEvent(
      ToLogoutEvent event, Emitter<AppStates> emit) async {
    emit(LoginState());
  }

  // ======== StartFetchMoviesEvent Handler ==========

  // Initiates fetching of movies, emits loading state, then fetches movies
  // from the injected_repository and triggers FetchMoviesResultEvent with the result
  // Processes the result of fetching movies, handling success and failure
  Future<void> _onStartFetchMoviesEvent(
      StartFetchMoviesEvent event, Emitter<AppStates> emit) async {
    VariablesManager.movies.clear();
    emit(StartFetchMoviesState());
    await _repository.fetchMovies().then((result) {
      add(FetchMoviesResultEvent(result));
    });
  }

  Future<void> _onFetchMoviesResultEvent(
      FetchMoviesResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        add(MoviesLoadedErrorEvent(fail.toString()));
      },
      (movies) {
        if (VariablesManager.movies.isNotEmpty) {
          VariablesManager.movies.clear();
        }
        VariablesManager.movies.addAll(movies);
        getPhotos(VariablesManager.movies).then((value) {
          if (kDebugMode) {
            print("done!");
          }
          add(MoviesLoadedSuccessEvent());
        });
      },
    );
  }

  Future<void> _onMoviesLoadedErrorEvent(
      MoviesLoadedErrorEvent event, Emitter<AppStates> emit) async {
    emit(MoviesLoadedErrorState(event.fail));
  }

  Future<void> _onMoviesLoadedSuccessEvent(
      MoviesLoadedSuccessEvent event, Emitter<AppStates> emit) async {
    emit(MoviesLoadedSuccessState());
  }

  // ======== StartFetchFirebaseEvent Handler ==========

  // Starts Firebase initialization and adds the FetchFirebaseResultEvent
  // with the outcome of the injected_repository's initFirebase call

  Future<void> _onStartFetchFirebaseEvent(
      StartFetchFirebaseEvent event, Emitter<AppStates> emit) async {
    emit(StartFetchFirebaseState());
    Either<FirebaseFailureClass, List<String>> result =
        await _repository.initFirebase();
    add(FetchFirebaseResultEvent(result));
  }

  Future<void> _onStartFetchFirebaseEventResult(
      FetchFirebaseResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        add(FetchFirebaseErrorEvent(fail.firebaseException));
      },
      (success) {
        if (VariablesManager.userIds.isNotEmpty) {
          VariablesManager.userIds.clear();
        }
        VariablesManager.userIds.addAll(success);
        if (kDebugMode) {
          print(VariablesManager.userIds);
        }
        add(FetchFirebaseSuccessEvent());
      },
    );
  }

  Future<void> _onFetchFirebaseErrorEvent(
      FetchFirebaseErrorEvent event, Emitter<AppStates> emit) async {
    firebaseAuthErrorsHandler(
      state: (error) => FetchFirebaseErrorState(error),
      emit: emit,
      failure: event.fail,
    );
  }

  Future<void> _onFetchFirebaseSuccessEvent(
      FetchFirebaseSuccessEvent event, Emitter<AppStates> emit) async {
    emit(FetchFirebaseSuccessState());
  }

  // Starts user creation by calling createUserAtFirebase and triggers
  // CreatingUserResultEvent with the result for further processing
  // Processes user creation result, handling success by moving to add user
  // to Firebase, or failure by showing error state

  Future<void> _onCreateUserEvent(
      StartCreateUserEvent event, Emitter<AppStates> emit) async {
    emit(StartUserCreateState());

    Either<FirebaseFailureClass, UserCredential> result =
        await _register.createUserAtFirebase(req: event.req);

    if (kDebugMode) {
      print(result.toString());
    }
    add(CreatingUserResultEvent(event.req, result));
  }

  Future<void> _onCreatingUserResultEvent(
      CreatingUserResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        add(UserCreatedErrorEvent(fail.firebaseException));
      },
      (success) {
        if (success.user != null) {
          SharedPref.prefs
              .setString(GeneralStrings.currentUser, success.user!.uid);
          add(UserCreatedSuccessEvent(success.user!));
        }
      },
    );
  }

  Future<void> _onUserCreatedErrorEvent(
      UserCreatedErrorEvent event, Emitter<AppStates> emit) async {
    firebaseAuthErrorsHandler(
      emit: emit,
      failure: event.fail,
      state: (String error) => UserCreatedErrorState(error),
    );
  }

  Future<void> _onUserCreatedSuccessEvent(
      UserCreatedSuccessEvent event, Emitter<AppStates> emit) async {
    _register
        .addUserToFirebase(
            req: CreateUserRequirements(
      fullName: event.user.displayName,
      email: event.user.email,
    ))
        .then((_) {
      add(AddUserToFirebaseEvent());
    });
  }

  // ======== Add User To Firebase Handler ==========
//adding user to firebase will be incloded with creation user
  //whether normal register or with google register
  Future<void> _onAddUserToFirebaseEvent(
      AddUserToFirebaseEvent event, Emitter<AppStates> emit) async {
    emit(UserCreatedSuccessState());
  }

  // ======== LoginEvent Handler ==========
  // Initiates login process, emits loading state, performs login, and triggers
  // LoginResultEvent with result to proceed with login outcome handling
  // Handles result of login, emitting success state or showing error state upon failure

  Future<void> _onLoginEvent(LoginEvent event, Emitter<AppStates> emit) async {
    emit(LoginState());
    Either<FirebaseFailureClass, String> result =
        await _login.loginToFirebase(req: event.req);
    add(LoginResultEvent(result));
  }

  Future<void> _onLoginResultEvent(
      LoginResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        add(LoginErrorEvent(fail.firebaseException));
      },
      (success) {
        add(LoginSuccessEvent());
      },
    );
  }

  Future<void> _onLoginErrorEvent(
      LoginErrorEvent event, Emitter<AppStates> emit) async {
    firebaseAuthErrorsHandler(
      emit: emit,
      failure: event.fail,
      state: (String error) => LoginErrorState(error),
    );
  }

  Future<void> _onLoginSuccessEvent(
      LoginSuccessEvent event, Emitter<AppStates> emit) async {
    emit(LoginSuccessState());
  }

  // ======== SignInWithGoogleEvent Handler ==========
  // Initiates Google sign=in, emits loading state, performs sign=in, and triggers
  // SignInWithGoogleResultEvent with the result for further handling
  // Processes result of Google sign=in, checking if the user exists or not,
  // and emits respective states based on the outcome
//also after creatting user by google automatiklly will add to firebase
  Future<void> _onSignInWithGoogleEvent(
      SignInWithGoogleEvent event, Emitter<AppStates> emit) async {
    emit(StartSignInWithGoogleState());
    Either<FailureClass, User> result = await _auth.signInWithGoogle();
    add(SignInWithGoogleResultEvent(result));
  }

  Future<void> _onSignInWithGoogleResultEvent(
      SignInWithGoogleResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        add(SignInWithGoogleEventError(fail.toString()));
      },
      (user) {
        add(SignInWithGoogleEventSuccess(user));
      },
    );
  }

  Future<void> _onSignInWithGoogleEventError(
      SignInWithGoogleEventError event, Emitter<AppStates> emit) async {
    emit(SignInWithGoogleStateError(event.fail.toString()));
  }

  Future<void> _onSignInWithGoogleEventSuccess(
      SignInWithGoogleEventSuccess event, Emitter<AppStates> emit) async {
    VariablesManager.userIds.contains(event.user.uid)
        ? add(SignInWithGoogleUserExistEvent())
        : add(UserCreatedSuccessEvent(event.user));
  }

  Future<void> _onSignInWithGoogleUserExistEvent(
      SignInWithGoogleUserExistEvent event, Emitter<AppStates> emit) async {
    emit(SignInWithGoogleUserExistState());
  }

//============ on Change Color and language mode ============
  //i can handle both of them in one event but after i tried
  // i found like this its will be better for handling both of them
  //to concern missions
  Future<void> _onChangeColorModeEvent(
      ChangeColorModeEvent event, Emitter<AppStates> emit) async {
    // Change the color theme using the helper
    AppColorHelper.changeColorTheme(event);

    // Use switch to handle setting the color theme
    switch (event.appColorsTheme) {
      case AppColorsTheme.green:
        SharedPref.prefs.setString(GeneralStrings.colorTheme, 'green');
        break;

      case AppColorsTheme.blue:
        SharedPref.prefs.setString(GeneralStrings.colorTheme, 'blue');
        break;

      case AppColorsTheme.purple:
        SharedPref.prefs.setString(GeneralStrings.colorTheme, 'purple');
        break;

      default:
        // Optional: handle unknown themes if needed
        break;
    }

    // Emit the state change
    emit(ChangeColorThemeState(selectedColorIndex: event.selectedColorIndex));
  }

  Future<void> _onChangeLanguageEvent(
      ChangeLanguageEvent event, Emitter<AppStates> emit) async {
    HandleAppLanguage.changeAppLanguage(event);
    // Use switch to handle setting the color theme
    switch (event.applicationLanguage) {
      case ApplicationLanguage.en:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'en');
        break;
        case ApplicationLanguage.tr:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'tr');
        break;
      case ApplicationLanguage.fr:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'fr');
        break;
      case ApplicationLanguage.es:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'es');
        break;
      case ApplicationLanguage.nl:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'nl');
        break;
      case ApplicationLanguage.ar:
        SharedPref.prefs.setString(GeneralStrings.appLanguage, 'ar');
        break;

      default:
        // Optional: handle unknown themes if needed
        break;
    }
    emit(ChangeAppLanguageState(
        selectedLanguageIndex: event.selectedLanguageIndex));
  }

  // ======== lode color language and mode frm preferences ==========
  // to load the prefernces from shared_prefernce
  _onLoadPreferencesEvent(LoadPreferencesEvent event, Emitter<AppStates> emit) {
    emit(LoadPreferencesState(
        selectedColorIndex: event.selectedColorIndex,
        selectedLanguageIndex: event.selectedLanguageIndex,
        selectedModeIndex: event.selectedModeIndex));
  }

  // ======== InternetStatusChangeEvent Handler ==========
  // Listens to internet connectivity status changes and emits either ConnectedState
  // or DisconnectedState based on the current connectivity status
  //i didn't handle with the internet is weak or stable >>
  Future<void> _onInternetStatusChangeEvent(
      InternetStatusChangeEvent event, Emitter<AppStates> emit) async {
    await for (var status in InternetConnection().onStatusChange) {
      if (status == InternetStatus.connected) {
        emit(ConnectedState());
      } else {
        emit(DisconnectedState());
      }
    }
  }

  // ======== reset password Handler ==========
// i made it just to sent an email to user to reset the password
  //by firebase .
  Future<void> _onResetPasswordEvent(
      ResetPasswordEvent event, Emitter<AppStates> emit) async {
    final result = await _login.forgetPassword(event.email);
    result.fold((error) {
      add(ResetPasswordErrorEvent(error.firebaseException));
    }, (success) {
      add(ResetPasswordSuccessEvent());
    });
  }

  Future<void> _onResetPasswordErrorEvent(
      ResetPasswordErrorEvent event, Emitter<AppStates> emit) async {
    firebaseAuthErrorsHandler(
      emit: emit,
      failure: event.error,
      state: (String error) => ResetPasswordErrorState(error),
    );
  }

  Future<void> _onResetPasswordSuccessEvent(
      ResetPasswordSuccessEvent event, Emitter<AppStates> emit) async {
    emit(ResetPasswordSuccessState());
  }

  // ======== ChangeNavigationBarIndexEvent Handler ==========
  // Updates the current navigation bar index and emits the related state
  Future<void> _onChangeNavigationBarIndexEvent(
      ChangeNavigationBarIndexEvent event, Emitter<AppStates> emit) async {
    emit(ChangeNavigationBarIndexState());
  }

// ======== ToggleLightAndDarkEvent Handler ==========
// This method is responsible for switching between light and dark themes.
// It first checks whether the theme is set to manual or automatic (based on device settings).
// If manual mode is enabled, it uses the theme saved in `TheAppMode`.
// If not, it checks the device's brightness to dynamically set the theme (light or dark).
  ThemeData? toggleLightAndDark(context) {
    ThemeData themeData ; // Default to light theme if not set.
    // Check if the user is in manual mode
    if (SharedPref.getBool(GeneralStrings.isManual)!) {
      themeData = TheAppMode.appMode; // Use the saved theme mode (light or dark).
      // Check if the event's theme is dark or light, and update the dark mode flag accordingly.
      if(  themeData == AppTheme.dark.themeData){
        VariablesManager.isDark = true;
      }else{
        VariablesManager.isDark = false;
      }
      add(ChangeModeThemeEvent(SharedPref.getBool(GeneralStrings.isManual)!));
      // Trigger event to update theme in the app state
      add(ToggleLightAndDarkEvent(themeData));

    } else {
      // Automatically set the theme based on device's current brightness (light/dark mode)
      Brightness brightness = MediaQuery.of(context).platformBrightness;
      brightness == Brightness.dark
          ? (themeData =
              AppTheme.dark.themeData) // Set dark theme if device is dark mode.
          : (themeData =
              AppTheme.light.themeData); // Otherwise, set light theme.

      // For debugging, print the current theme
      if (kDebugMode) {
        print(VariablesManager.isDark ? "dark" : 'light');
      }
      if(  themeData == AppTheme.dark.themeData){
        VariablesManager.isDark = true;
      }else{
        VariablesManager.isDark = false;
      }
      // Trigger event to update theme in the app state
      add(ToggleLightAndDarkEvent(themeData));

    }
    // Return the selected theme (either light, dark, or based on user settings)
    return themeData;
  }

// ======== ToggleLightAndDarkEvent Handler =========
// This method handles the event when the theme is toggled between light and dark modes.
// It updates the app state by setting a flag (VariablesManager.isDark) based on the selected theme.
  void _onToggleLightAndDarkEvent(
      ToggleLightAndDarkEvent event, Emitter<AppStates> emit) {
    // Emit the updated theme state to notify the app to rebuild with the new theme.

    emit(ToggleLightAndDarkState());

  }



  void _onExtractDominantColorEvent(
      ExtractDominantColorEvent event, Emitter<AppStates> emit) {

    emit(ExtractDominantColorState());

  }


// ======== ChangeModeEvent Handler ==========
// This method updates the theme mode (light/dark) in the app preferences
// and stores it in `SharedPref` for persistence across app launches.
  Future<void> _onChangeModeEvent(
      ChangeModeEvent event, Emitter<AppStates> emit) async {
    // Update the app theme mode based on the event.
    TheAppMode.updateMode(event.appMode);

    // Store the selected theme in shared preferences (for persistence)
    switch (event.appMode) {
      case AppTheme.light:
        SharedPref.prefs
            .setString(GeneralStrings.appMode, 'light'); // Save light mode.
        break;
      case AppTheme.dark:
        SharedPref.prefs
            .setString(GeneralStrings.appMode, 'dark'); // Save dark mode.
        break;
      default:
        // Handle unknown theme modes (optional, if required).
        break;
    }

    // Emit the state to notify the app about the updated theme mode.
    emit(ChangeModeState());
  }

// ======== ChangeModeThemeEvent Handler ==========
// This method saves the "manual" setting in SharedPreferences,
// and updates the app theme according to the stored preference (light or dark).
  Future<void> _onChangeModeThemeEvent(
      ChangeModeThemeEvent event, Emitter<AppStates> emit) async {
    // Save the manual theme preference in SharedPreferences
    await SharedPref.saveBool(
        key: GeneralStrings.isManual, value: event.isManual);

    // Update the theme based on the stored preference (light or dark)
    switch (SharedPref.prefs.getString(GeneralStrings.appMode)) {
      case 'light':
        TheAppMode.updateMode(
            AppTheme.light); // Set light theme if saved mode is light.
        break;
      case 'dark':
        TheAppMode.updateMode(
            AppTheme.dark); // Set dark theme if saved mode is dark.
        break;
      default:
        // Handle the default case if the theme mode is unknown (optional).
        break;
    }

    // For debugging, print the current theme being applied.
    if (kDebugMode) {
      print(TheAppMode.appMode);
    }

    // Emit the state to notify the app about the "manual" setting change.
    emit(ChangeModeThemeState(event.isManual));
  }

  // Caches images associated with movies
// This function is used to cache the images of movies by initializing CachedNetworkImageProvider instances
// for each movie's image (both the main and vertical images).
  Future<void> getPhotos(List<MovieResponse> movies) async {
    // Preload images into cache using precacheImage
    // The images are first wrapped in CachedNetworkImageProvider, then they are stored in memory.
    // Preload the images without displaying them to the user (in the background)
    // This ensures the images are cached and ready to be shown without delay.

    final moviesCopy = List<MovieResponse>.from(movies); // Create a copy
    if (VariablesManager.isFirstTimeOpened) {
      for (MovieResponse movie in moviesCopy) {
        await precacheImage(CachedNetworkImageProvider(movie.photo!),
            navigatorKey.currentContext!);
        await precacheImage(CachedNetworkImageProvider(movie.verticalPhoto!),
            navigatorKey.currentContext!);
      }
    }
  }

  // ======== Light Theme Text Styles ========
  // Helper methods to set text styles for various text elements
  static headerStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .headlineLarge
      ?.copyWith(color: VariablesManager.isDark ? Colors.white : Colors.black);

  static titleStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .titleLarge
      ?.copyWith(color: VariablesManager.isDark ? Colors.white : Colors.black);

  static bodyStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .bodyLarge
      ?.copyWith(color: VariablesManager.isDark ? Colors.white : Colors.black);

  static paragraphStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .labelLarge
      ?.copyWith(color: VariablesManager.isDark ? Colors.white : Colors.black);

  static smallParagraphStyle(BuildContext context) => Theme.of(context)
      .textTheme
      .labelSmall
      ?.copyWith(color: VariablesManager.isDark ? Colors.white : Colors.black);
}
