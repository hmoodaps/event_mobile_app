import 'package:dio/dio.dart';
import 'package:event_mobile_app/data/implementer/isolate_helper_implementer/isolate_helper_implementer.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/auth_repo_implementer.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/login_to_firebase_repo_imp.dart';
import 'package:event_mobile_app/data/implementer/repository_implementer/register_implementer.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/data/network_data_handler/remote_requests/dio_requests_handler.dart';
import 'package:event_mobile_app/data/network_data_handler/rest_api/rest_api_dio.dart';
import 'package:event_mobile_app/domain/isolate/isolate_helper.dart';
import 'package:event_mobile_app/domain/repository/auth_repository.dart';
import 'package:event_mobile_app/domain/repository/login_to_firebase_repo.dart';
import 'package:event_mobile_app/domain/repository/register_in_firebase_repo.dart';
import 'package:get_it/get_it.dart';

import '../../data/implementer/repository_implementer/repo_implementer.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/bloc_state_managment/bloc_manage.dart';

/// An instance of GetIt for dependency injection throughout the application.
/// This allows you to access and inject dependencies into various parts of the app.
final instance = GetIt.asNewInstance();

/// Initializes the application modules by registering dependencies with GetIt.
/// This method is asynchronous and should be called during the application startup.
///
/// The following modules are registered:
/// - **Shared Preferences**: Handles local data storage.
/// - **EventsBloc**: Manages the state of events within the application using the BLoC pattern.
/// - **Internet Checker**: Monitors internet connectivity status.
/// - **Dio**: A powerful HTTP client for making network requests.
/// - **Dio Client**: A wrapper around Dio for RESTful API interactions.
/// - **Repository**: Implements the data repository pattern for data management.
///
/// Each dependency is registered as a lazy singleton to ensure that
/// they are instantiated only when first accessed, promoting efficient resource use.
Future<void> initAppModules() async {
  // 1. Initialize Shared Preferences and Dio
  await SharedPref.init(); // Asynchronously initializes shared preferences.
  final SharedPref pref = SharedPref(); // Create an instance of SharedPref.
  instance.registerSingleton<SharedPref>(
      pref); // Register SharedPref as a singleton.

  DioHelper.init(); // Initialize DioHelper for managing Dio settings.
  instance.registerSingleton<DioHelper>(
      DioHelper()); // Register DioHelper as a singleton.

  final Dio dio = Dio(); // Instantiate a new Dio client.
  instance.registerSingleton<Dio>(dio); // Register the Dio instance.
  instance.registerLazySingleton<DioClient>(() =>
      DioClient(instance<Dio>())); // Register DioClient using the Dio instance.
  // 3. Register AuthRepository, LoginToFirebaseRepo, and RegisterInFirebaseRepo
  instance.registerLazySingleton<AuthRepository>(() =>
      AuthImplementer()); // Register AuthRepository for handling authentication.
  instance.registerLazySingleton<LoginToFirebaseRepo>(() =>
      LoginToFirebaseImplementer()); // Register LoginToFirebaseRepo for login tasks.
  instance.registerLazySingleton<RegisterInFirebaseRepo>(() =>
      RegisterImplementer()); // Register RegisterInFirebaseRepo for registration tasks.

  // 2. Register InternetChecker and IsolateHelper to avoid circular dependencies.
  // instance.registerLazySingleton<InternetChecker>(() =>
  //     InternetCheckerImplementer()); // Register InternetChecker for connectivity checks.
  instance.registerLazySingleton<IsolateHelper>(() => IsolateHelperImplementer(
      instance<
          DioClient>())); // Register the isolate helper for background tasks.

  // 4. Register Repository to handle data operations and ensure other dependencies are registered first.
  instance.registerLazySingleton<Repository>(() => RepositoryImplementer(
        isolateHelper: instance<
            IsolateHelper>(), // Inject IsolateHelper for managing background tasks.
      ));

// 5. Register EventsBloc to manage the events' state within the application.
  instance.registerSingleton<EventsBloc>(
    EventsBloc(),
  ); // Ensure a single instance of EventsBloc.
}
