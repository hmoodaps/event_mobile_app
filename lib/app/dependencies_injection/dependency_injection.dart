import 'package:dio/dio.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/data/network_data_handler/internet_checker/internet_checker.dart';
import 'package:event_mobile_app/data/network_data_handler/remote_requests/dio_requests_handler.dart';
import 'package:event_mobile_app/data/network_data_handler/rest_api/rest_api_dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../data/implementer/repository_implementer/repo_implementer.dart';
import '../../domain/repository/repository.dart';
import '../../presentation/bloc_state_managment/bloc_manage.dart';

/// An instance of GetIt for dependency injection throughout the application.
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
Future<void> initAppModules(BuildContext context) async {
  // Initialize shared preferences for local storage.
  await SharedPref.init();
  final SharedPref pref = SharedPref();
  instance.registerLazySingleton<SharedPref>(() => pref);

  // Register the EventsBloc for state management in the application.
  instance.registerLazySingleton<EventsBloc>(() => EventsBloc());

  // Register the InternetChecker implementation to monitor network status.
  final InternetConnectionChecker internetConnectionChecker =
      InternetConnectionChecker();
  instance.registerLazySingleton<InternetChecker>(
      () => InternetCheckerImp(internetConnectionChecker));

  // Initialize the Dio HTTP client and register it for use in network requests.
  DioHelper.init();
  instance.registerLazySingleton<DioHelper>(
      () => DioHelper(internetChecker: instance<InternetChecker>()));

  // Create and register the Dio client for making HTTP requests.
  // Dio Client injection
  // This Dio client is configured to use Retrofit, a popular HTTP client library
  // that simplifies REST API calls in Dart and Flutter applications. Retrofit
  // provides a type-safe way to define API endpoints using annotations, making
  // the code more readable and maintainable.

  // The previous Dio instance initialized in the code is a standard Dio client,
  // which is a general-purpose HTTP client for making network requests. By having
  // both a standard Dio instance and a Retrofit-based Dio client, the application
  // demonstrates its flexibility in handling network requests.

  // This approach allows the application to utilize different strategies for
  // making RESTful API calls, catering to specific needs or preferences.
  // For instance, Retrofit can provide automatic JSON serialization/deserialization
  // and better error handling, while the standard Dio can be used for simpler
  // requests or when a more hands-on approach is required.

  // Overall, this dual approach showcases the ability to handle various types
  // of network interactions within the same application, allowing for a more
  // versatile architecture.

  final Dio dio = Dio();
  instance.registerLazySingleton<Dio>(() => dio);
  instance.registerLazySingleton<DioClient>(() => DioClient(instance<Dio>()));

  // Register the Repository implementation, which uses the Dio client for data operations.
  instance.registerLazySingleton<Repository>(
      () => RepositoryImplementer(instance<DioClient>()));

  //
}
