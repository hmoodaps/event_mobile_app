import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/theme_manager.dart';
import 'package:event_mobile_app/app/dependencies_injection/dependency_injection.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/auth_repo_implementer.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/login_to_firebase_repo_imp.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/register_implementer.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/repo_implementer.dart';
import 'package:event_mobile_app/domain/isolate/isolate_helper.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import '../../app/components/constants/variables_manager.dart';
import '../../app/components/firebase_error_handler/firebase_error_handler.dart';
import '../../data/implementer/failure_class/failure_class.dart';
import '../../data/models/movie_model.dart';
import '../../main.dart';

class EventsBloc extends Bloc<AppEvents, AppStates> {
  // ======== Auth Handler ==========
  // Object for handling authentication=related operations
  final AuthImplementer auth = AuthImplementer();

  // ======== Login Handler ==========
  // Object for managing login operations in Firebase
  final LoginToFirebaseImplementer login = LoginToFirebaseImplementer();

  // ======== Register Handler ==========
  // Object for handling user registration operations
  final RegisterImplementer register = RegisterImplementer();

  // ======== Repository Handler ==========
  // Main repository object for data management and access across the app
  final RepositoryImplementer repository =
      RepositoryImplementer(isolateHelper: instance<IsolateHelper>());

  EventsBloc() : super(InitialState()) {
    // Registering event handlers to listen and respond to various events
    on<StartCreateUserEvent>(_onCreateUserEvent);
    on<CreatingUserResultEvent>(_onCreatingUserResultEvent);
    on<AddUserToFirebaseEvent>(_onAddUserToFirebaseEvent);
    on<AddUserToFirebaseResultEvent>(_onAddUserToFirebaseResultEvent);
    on<LoginEvent>(_onLoginEvent);
    on<LoginResultEvent>(_onLoginResultEvent);
    on<SignInWithGoogleEvent>(_onSignInWithGoogleEvent);
    on<SignInWithGoogleResultEvent>(_onSignInWithGoogleResultEvent);
    on<ChangeNavigationBarIndexEvent>(_onChangeNavigationBarIndexEvent);
    on<StartFetchFirebaseEvent>(_onStartFetchFirebaseEvent);
    on<FetchFirebaseResultEvent>(_onStartFetchFirebaseEventResult);
    on<StartFetchMoviesEvent>(_onStartFetchMoviesEvent);
    on<FetchMoviesResultEvent>(_onFetchMoviesResultEvent);
    on<ToggleLightAndDarkEvent>(_onToggleLightAndDarkEvent);
    on<InternetStatusChangeEvent>(_onInternetStatusChangeEvent);
    on<MoviesLoadedEvent>(_onMoviesLoadedEvent);
  }

  // ======== StartFetchMoviesEvent Handler ==========
  // Initiates fetching of movies, emits loading state, then fetches movies
  // from the repository and triggers FetchMoviesResultEvent with the result
  Future<void> _onStartFetchMoviesEvent(
      StartFetchMoviesEvent event, Emitter<AppStates> emit) async {
    await repository.fetchMovies().then((result) {
      add(FetchMoviesResultEvent(result));
    });
    emit(StartFetchMoviesState());
  }

  // ======== FetchMoviesResultEvent Handler ==========
  // Processes the result of fetching movies, handling success and failure
  Future<void> _onFetchMoviesResultEvent(
      FetchMoviesResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        emit(InitFetchMoviesErrorState(fail.toString()));
      },
      (movies) {
        VariablesManager.movies.addAll(movies);
        getPhotos(VariablesManager.movies).then((value){
          print("done!");
          add(MoviesLoadedEvent());
        });
      },
    );
  }

  // ======== FetchMoviesResultEvent Handler ==========
  // Processes the result of fetching movies, handling success and failure
  Future<void> _onMoviesLoadedEvent(
      MoviesLoadedEvent event, Emitter<AppStates> emit) async {
    emit(MoviesLoadedState());
  }


  // ======== StartFetchFirebaseEvent Handler ==========
  // Starts Firebase initialization and adds the FetchFirebaseResultEvent
  // with the outcome of the repository's initFirebase call
  Future<void> _onStartFetchFirebaseEvent(
      StartFetchFirebaseEvent event, Emitter<AppStates> emit) async {
    emit(StartFetchFirebaseState());
    Either<FailureClass, List<String>> result = await repository.initFirebase();
    add(FetchFirebaseResultEvent(result));
  }

  // ======== FetchFirebaseResultEvent Handler ==========
  // Processes the result of Firebase initialization, emitting states for success and failure
  Future<void> _onStartFetchFirebaseEventResult(
      FetchFirebaseResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        emit(InitFetchFirebaseErrorState(fail.error));
      },
      (success) {
        emit(InitFetchFirebaseState());
      },
    );
  }

  // ======== CreateUserEvent Handler ==========
  // Starts user creation by calling createUserAtFirebase and triggers
  // CreatingUserResultEvent with the result for further processing
  Future<void> _onCreateUserEvent(
      StartCreateUserEvent event, Emitter<AppStates> emit) async {
    emit(StartCreateUserState());
    Either<FirebaseFailureClass, UserCredential> result =
        await register.createUserAtFirebase(req: event.req);
    add(CreatingUserResultEvent(event.req, result));
  }

  // ======== CreatingUserResultEvent Handler ==========
  // Processes user creation result, handling success by moving to add user
  // to Firebase, or failure by showing error state
  Future<void> _onCreatingUserResultEvent(
      CreatingUserResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        firebaseAuthErrorsHandler(
          emit: emit,
          failure: fail,
          state: (String error) => CreateUserStateError(error),
        );
      },
      (success) {
        add(AddUserToFirebaseEvent(event.req));
      },
    );
  }

  // ======== AddUserToFirebaseEvent Handler ==========
  // Starts the process of adding a user to Firebase by calling addUserToFirebase
  // and triggering AddUserToFirebaseResultEvent with the result
  Future<void> _onAddUserToFirebaseEvent(
      AddUserToFirebaseEvent event, Emitter<AppStates> emit) async {
    emit(AddUserToFirebaseState());
    Either<FirebaseFailureClass, void> result =
        await register.addUserToFirebase(req: event.req);
    add(AddUserToFirebaseResultEvent(result));
  }

  // ======== AddUserToFirebaseResultEvent Handler ==========
  // Handles result of adding user to Firebase, emits success state if successful,
  // or shows an error state upon failure
  Future<void> _onAddUserToFirebaseResultEvent(
      AddUserToFirebaseResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        firebaseAuthErrorsHandler(
          emit: emit,
          failure: fail,
          state: (String error) => AddUserToFirebaseStateError(error),
        );
      },
      (success) {
        emit(AddUserToFirebaseStateSuccess());
      },
    );
  }

  // ======== LoginEvent Handler ==========
  // Initiates login process, emits loading state, performs login, and triggers
  // LoginResultEvent with result to proceed with login outcome handling
  Future<void> _onLoginEvent(LoginEvent event, Emitter<AppStates> emit) async {
    emit(LoginState());
    Either<FirebaseFailureClass, String> result =
        await login.loginToFirebase(req: event.req);
    add(LoginResultEvent(result));
  }

  // ======== LoginResultEvent Handler ==========
  // Handles result of login, emitting success state or showing error state upon failure
  Future<void> _onLoginResultEvent(
      LoginResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        firebaseAuthErrorsHandler(
          emit: emit,
          failure: fail,
          state: (String error) => LoginErrorState(error),
        );
      },
      (success) {
        emit(LoginSuccessState());
      },
    );
  }

  // ======== SignInWithGoogleEvent Handler ==========
  // Initiates Google sign=in, emits loading state, performs sign=in, and triggers
  // SignInWithGoogleResultEvent with the result for further handling
  Future<void> _onSignInWithGoogleEvent(
      SignInWithGoogleEvent event, Emitter<AppStates> emit) async {
    emit(SignInWithGoogleState());
    Either<FailureClass, Either<bool, bool>> result =
        await auth.signInWithGoogle();
    add(SignInWithGoogleResultEvent(result));
  }

  // ======== SignInWithGoogleResultEvent Handler ==========
  // Processes result of Google sign=in, checking if the user exists or not,
  // and emits respective states based on the outcome
  Future<void> _onSignInWithGoogleResultEvent(
      SignInWithGoogleResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
      (fail) {
        emit(SignInWithGoogleStateError(fail.toString()));
      },
      (success) {
        success.fold(
          (isSignedIn) {
            emit(SignInWithGoogleUserExist());
          },
          (isSignedOut) {
            emit(SignInWithGoogleUserNotExist());
          },
        );
      },
    );
  }

  // ======== InternetStatusChangeEvent Handler ==========
  // Listens to internet connectivity status changes and emits either ConnectedState
  // or DisconnectedState based on the current connectivity status
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

  // ======== ChangeNavigationBarIndexEvent Handler ==========
  // Updates the current navigation bar index and emits the related state
  Future<void> _onChangeNavigationBarIndexEvent(
      ChangeNavigationBarIndexEvent event, Emitter<AppStates> emit) async {
    emit(ChangeNavigationBarIndexState());
  }

  // ======== ToggleLightAndDarkEvent Handler ==========
  // Switches between light and dark themes, updates the theme state accordingly,
  // and checks device theme mode to adjust the theme dynamically
  void _onToggleLightAndDarkEvent(
      ToggleLightAndDarkEvent event, Emitter<AppStates> emit) {
    emit(ToggleLightAndDarkState());
  }

  //================ Toggle between light and dark mode ========================
  // Updates theme data based on system brightness and triggers ToggleLightAndDarkEvent
  ThemeData themeData = lightThemeData();

  ThemeData? toggleLightAndDark(context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    brightness == Brightness.dark
        ? (themeData = darkThemeData(), VariablesManager.isDark = true)
        : (themeData = lightThemeData(), VariablesManager.isDark = false);
    if (kDebugMode) {
      print(VariablesManager.isDark ? "dark" : 'light');
    }
    add(ToggleLightAndDarkEvent());
    return themeData;
  }

  //create instance from Event bloc if we need new instance and cant use it from DI

  static EventsBloc get(context) => BlocProvider.of<EventsBloc>(context);

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


  // Caches images associated with movies
// This function is used to cache the images of movies by initializing CachedNetworkImageProvider instances
// for each movie's image (both the main and vertical images).
  Future<void> getPhotos(List<MovieResponse> movies) async {
    for (MovieResponse movie in movies) {
      // Preload images into cache using precacheImage
      // The images are first wrapped in CachedNetworkImageProvider, then they are stored in memory.
      // Preload the images without displaying them to the user (in the background)
      // This ensures the images are cached and ready to be shown without delay.
      await precacheImage(CachedNetworkImageProvider(movie.photo!), navigatorKey.currentContext!);
     // await precacheImage(CachedNetworkImageProvider(movie.verticalPhoto!), navigatorKey.currentContext!);
    }
  }
}
