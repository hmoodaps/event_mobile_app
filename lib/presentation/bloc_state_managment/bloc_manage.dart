import 'package:cached_network_image/cached_network_image.dart';
import 'package:dartz/dartz.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';

import '../../app/components/constants/color_manager.dart';
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
  final AuthRepository auth = instance();

  // ======== Login Handler ==========
  // Object for managing login operations in Firebase
  final LoginToFirebaseRepo login = instance();

  // ======== Register Handler ==========
  // Object for handling user registration operations
  final RegisterInFirebaseRepo register = instance();

  // ======== Repository Handler ==========
  // Main injected_repository object for data management and access across the app
  final InitRepository repository = instance();

  // ======== Add user Handler ==========
  // Main injected_repository object for data management and access across the app
  final AddUserDetailsRepo addUserDetailsRepo = instance();


  EventsBloc() : super(InitialState()) {
    // Registering event handlers to listen and respond to various events
    on<StartCreateUserEvent>(_onCreateUserEvent);
    on<CreatingUserResultEvent>(_onCreatingUserResultEvent);
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
    on<AddUserToFirebaseEvent>(_onAddUserToFirebaseEvent);
    on<SignInWithGoogleUserExistEvent>(_onSignInWithGoogleUserExistEvent);

  }

//====================Add User Details Handler=============================
  _onAddUserDetailsEvent(AddUserDetailsEvent event , Emitter<AppStates> emit)async{
    emit(AddUsersDetailsState());
    await addUserDetailsRepo.addUserDetails(req: event.req).then((result){
      add(AddUserDetailsResultEvent(result));
    });
  }

  _onAddUserDetailsResultEvent(AddUserDetailsResultEvent event , Emitter<AppStates> emit)async{
    event.result.fold((error){
      add(AddUserDetailsErrorEvent(error.firebaseException!.message.toString()));
    }, (success){
      add(AddUserDetailsSuccessEvent());
    });
  }

  Future<void> _onAddUserDetailsErrorEvent(
      AddUserDetailsErrorEvent event, Emitter<AppStates> emit) async {
    emit(AddUserDetailsErrorState(event.error.toString()));
  }

  Future<void> _onAddUserDetailsSuccessEvent(
      AddUserDetailsSuccessEvent event, Emitter<AppStates> emit) async {
    emit(AddUserDetailsSuccessState());
  }

  //create instance from Event bloc if we need new instance and cant use it from DI

  static EventsBloc get(context) => BlocProvider.of<EventsBloc>(context);
//====================Log OUT=============================


  Future<void>_onLogoutEvent(LogoutEvent event , Emitter<AppStates> emit)async{
    await login.logout().then((_){emit(LogoutState());});
  }
  // ======== StartFetchMoviesEvent Handler ==========
  // Initiates fetching of movies, emits loading state, then fetches movies
  // from the injected_repository and triggers FetchMoviesResultEvent with the result
  Future<void> _onStartFetchMoviesEvent(
      StartFetchMoviesEvent event, Emitter<AppStates> emit) async {
    emit(StartFetchMoviesState());
    await repository.fetchMovies().then((result) {
      add(FetchMoviesResultEvent(result));
    });
  }

  // ======== FetchMoviesResultEvent Handler ==========
  // Processes the result of fetching movies, handling success and failure
  Future<void> _onFetchMoviesResultEvent(
      FetchMoviesResultEvent event, Emitter<AppStates> emit) async {
    event.result.fold(
          (fail) {
            add(MoviesLoadedErrorEvent(fail.toString()));
      },
          (movies) {
        if(VariablesManager.movies.isNotEmpty){VariablesManager.movies.clear();}
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
    emit(MoviesLoadedErrorState(event.fail.toString()));
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
      Either<FailureClass, List<String>> result = await repository.initFirebase();
      add(FetchFirebaseResultEvent(result));
    }

    Future<void> _onStartFetchFirebaseEventResult(
        FetchFirebaseResultEvent event, Emitter<AppStates> emit) async {
      event.result.fold(
            (fail) {
              add(FetchFirebaseErrorEvent(fail.error));
        },
            (success) {
          if(VariablesManager.userIds.isNotEmpty){VariablesManager.userIds.clear();}
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
    emit(FetchFirebaseErrorState(event.fail.toString()));
  }

  Future<void> _onFetchFirebaseSuccessEvent(
      FetchFirebaseSuccessEvent event, Emitter<AppStates> emit) async {
    emit(FetchFirebaseSuccessState());
  }

    // ======== CreateUserEvent Handler ==========
    // Starts user creation by calling createUserAtFirebase and triggers
    // CreatingUserResultEvent with the result for further processing
    Future<void> _onCreateUserEvent(
        StartCreateUserEvent event, Emitter<AppStates> emit) async {
      emit(StartUserCreateState());
      Either<FirebaseFailureClass, UserCredential> result =
      await register.createUserAtFirebase(req: event.req);
      if (kDebugMode) {
        print(result.toString());
      }
      add(CreatingUserResultEvent(event.req, result));
    }

    // ======== CreatingUserResultEvent Handler ==========
    // Processes user creation result, handling success by moving to add user
    // to Firebase, or failure by showing error state
    Future<void> _onCreatingUserResultEvent(
        CreatingUserResultEvent event, Emitter<AppStates> emit) async {
      event.result.fold(
            (fail) {
              add(UserCreatedErrorEvent(fail));


        },
            (success) {
          if(success.user != null ){
            SharedPref.prefs.setString(GeneralStrings.currentUser, success.user!.uid);
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
    );  }

  Future<void> _onUserCreatedSuccessEvent(
      UserCreatedSuccessEvent event, Emitter<AppStates> emit) async {
    register.addUserToFirebase(req: CreateUserRequirements(fullName: event.user.displayName , email: event.user.email ,)).then((_){
      add(AddUserToFirebaseEvent());
    });

  }
  Future<void> _onAddUserToFirebaseEvent(
      AddUserToFirebaseEvent event, Emitter<AppStates> emit
      )async{
    emit(UserCreatedSuccessState());

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
              add(LoginErrorEvent(fail));

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
    );  }

  Future<void> _onLoginSuccessEvent(
      LoginSuccessEvent event, Emitter<AppStates> emit) async {
    emit(LoginSuccessState());
  }
    // ======== SignInWithGoogleEvent Handler ==========
    // Initiates Google sign=in, emits loading state, performs sign=in, and triggers
    // SignInWithGoogleResultEvent with the result for further handling
    Future<void> _onSignInWithGoogleEvent(
        SignInWithGoogleEvent event, Emitter<AppStates> emit) async {
      emit(StartSignInWithGoogleState());
      Either<FailureClass,  User > result = await auth.signInWithGoogle();
      add(SignInWithGoogleResultEvent(result));
    }

    // ======== SignInWithGoogleResultEvent Handler ==========
    // Processes result of Google sign=in, checking if the user exists or not,
    // and emits respective states based on the outcome
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
    VariablesManager.userIds.contains(event.user.uid) ? add(SignInWithGoogleUserExistEvent()) : add(UserCreatedSuccessEvent(event.user));
  }

  Future<void> _onSignInWithGoogleUserExistEvent(
      SignInWithGoogleUserExistEvent event, Emitter<AppStates> emit) async {
emit(SignInWithGoogleUserExistState());
  }

  Future<void> _onChangeColorModeEvent(
      ChangeColorModeEvent event, Emitter<AppStates> emit) async {
    AppColorHelper.changeColorTheme(event);
    emit(ChangeColorTheme());
  }


    // ======== add user info Handler ==========
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
      event.themeData ==AppTheme.dark.themeData
          ? VariablesManager.isDark = true
          : VariablesManager.isDark = false ;
      emit(ToggleLightAndDarkState());
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

    // Caches images associated with movies
// This function is used to cache the images of movies by initializing CachedNetworkImageProvider instances
// for each movie's image (both the main and vertical images).
    Future<void> getPhotos(List<MovieResponse> movies) async {
      // Preload images into cache using precacheImage
      // The images are first wrapped in CachedNetworkImageProvider, then they are stored in memory.
      // Preload the images without displaying them to the user (in the background)
      // This ensures the images are cached and ready to be shown without delay.

      final moviesCopy = List<MovieResponse>.from(movies); // Create a copy
          if(VariablesManager.isFirstTimeOpened){
      for (MovieResponse movie in moviesCopy) {
        await precacheImage(CachedNetworkImageProvider(movie.photo!),
            navigatorKey.currentContext!);
        await precacheImage(CachedNetworkImageProvider(movie.verticalPhoto!),
            navigatorKey.currentContext!);
      }
    }
  }
  }
