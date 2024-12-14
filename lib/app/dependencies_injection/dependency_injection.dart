import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/handel_dark_and_light_mode/handel_dark_light_mode.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/operators_repo_implementer.dart';
import 'package:event_mobile_app/domain/repository/operators_repository.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';

import '../../data/implementer/repository_implementer/add_user_details_implementer.dart';
import '../../data/implementer/repository_implementer/auth_repo_implementer.dart';
import '../../data/implementer/repository_implementer/init_repo_implementer.dart';
import '../../data/implementer/repository_implementer/login_to_firebase_repo_imp.dart';
import '../../data/implementer/repository_implementer/main_repositories_implementer/repositories_implementer.dart';
import '../../data/implementer/repository_implementer/register_implementer.dart';
import '../../data/local_storage/shared_local.dart';
import '../../data/network_data_handler/remote_requests/dio_requests_handler.dart';
import '../../data/network_data_handler/rest_api/rest_api_dio.dart';
import '../../domain/repository/add_user_details.dart';
import '../../domain/repository/auth_repository.dart';
import '../../domain/repository/init_repository.dart';
import '../../domain/repository/login_to_firebase_repo.dart';
import '../../domain/repository/main_repositories/repositories.dart';
import '../../domain/repository/register_in_firebase_repo.dart';
import '../../presentation/bloc_state_managment/bloc_manage.dart';
import '../../presentation/bloc_state_managment/bloc_observe.dart';
import '../handle_app_language/handle_app_language.dart';
import '../handle_app_theme/handle_app_theme_colors.dart';

/// An instance of GetIt for dependency injection throughout the application.
/// This allows you to access and inject dependencies into various parts of the app.
final instance = GetIt.asNewInstance();

/// Initializes the application modules by registering dependencies with GetIt.
/// This method is asynchronous and should be called during the application startup.
Future<void> initAppModules() async {
  Bloc.observer = AppBlocObserver();
  // Setting the system UI mode to manual and enabling the top overlay (like status bar)
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
    SystemUiOverlay.top // Shows only the top system UI (like the status bar)
  ]);

  // ------ Initialize Shared Preferences ------
  // This section sets up the Shared Preferences instance for local storage.
  await SharedPref.init(); // Asynchronously initializes shared preferences.
  final SharedPref pref = SharedPref(); // Create an instance of SharedPref.
  instance.registerSingleton<SharedPref>(
      pref); // Register SharedPref as a singleton.

  // ------ Initialize Dio for Network Operations ------
  // This section sets up Dio for network requests, which is used across the app for handling HTTP requests.
  final Dio dio = Dio(); // Create an instance of Dio.
  DioHelper.init(); // Initialize DioHelper to manage Dio configurations.
  instance.registerSingleton<Dio>(
      dio); // Register the Dio instance globally for HTTP requests.
  instance.registerLazySingleton<DioClient>(() => DioClient(instance<
      Dio>())); // Register DioClient which will use the Dio instance for network requests.

  // ------ Register repo for Background Tasks ------
  // This section registers the repo to handle background tasks, such as user login and data fetching in background isolates.
// Register ComputedFunctions to manage background computing tasks.
  instance.registerLazySingleton<Repositories>(() => RepositoriesImplementer(
      instance<
          DioClient>())); // Register repo for managing background isolates.

  // ------ Register Repository Implementations ------
  // This section registers all repository implementations that handle interactions with Firebase and other data sources.

  // Register the repository for handling user registration.
  instance.registerLazySingleton<RegisterInFirebaseRepo>(
      () => RegisterImplementer(repo: instance()));

  // Register the repository for handling authentication.
  instance.registerLazySingleton<AuthRepository>(
      () => AuthImplementer(repo: instance()));

  // Register the repository for handling user login.
  instance.registerLazySingleton<LoginToFirebaseRepo>(
      () => LoginToFirebaseImplementer(repo: instance()));

  // Register the repository for handling initialization tasks (like loading user IDs).
  instance.registerLazySingleton<InitRepository>(
      () => InitRepositoryImplementer(repo: instance()));

  // Register the repository for handling user details.
  instance.registerLazySingleton<AddUserDetailsRepo>(
      () => AddUserDetailsImplementer(repo: instance()));

  instance.registerLazySingleton<OperatorsRepository>(
      () => OperatorsRepoImplemeter(instance()));

  // ------ Register EventsBloc for State Management ------
  // This section registers the BLoC to manage the state of events throughout the app.
  instance.registerLazySingleton<EventsBloc>(() =>
      EventsBloc()); // Register EventsBloc to manage event-related states.

  // ------ Register App Theme Management ------
  // This section registers the theme management service to handle dark and light mode functionality.
  AppColorHelper.setInitialTheme();
  HandleAppMode.setInitialmode();
  HandleAppLanguage.setInitialLanguage();
  setPrefs();
}

void setPrefs() {
  if (SharedPref.prefs.getBool(GeneralStrings.isManual) == null) {
    SharedPref.prefs.setBool(GeneralStrings.isManual, false);
  }
  if (SharedPref.prefs.getString(GeneralStrings.appMode) == null) {
    SharedPref.prefs.setString(GeneralStrings.appMode, 'dark');
  }
  if (SharedPref.prefs.getString(GeneralStrings.currentUser) == null &&
      SharedPref.prefs.getStringList(GeneralStrings.listFaves) == null) {
    SharedPref.prefs.setStringList(GeneralStrings.listFaves, []);
  }
}
