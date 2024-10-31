import 'dart:async';
import 'package:internet_connection_checker/internet_connection_checker.dart';

abstract class InternetChecker {
  Future<bool> get isConnect;
  Stream<InternetConnectionStatus> get onStatusChange;
}

class InternetCheckerImp implements InternetChecker {
  final InternetConnectionChecker _checker;

  InternetCheckerImp(this._checker);

  @override
  Future<bool> get isConnect => _checker.hasConnection;

  @override
  Stream<InternetConnectionStatus> get onStatusChange => _checker.onStatusChange;
}

// Global subscription to listen for internet connection changes
late StreamSubscription<InternetConnectionStatus> connectionSubscription;

void startListeningToInternet() {
  final checker = InternetCheckerImp(InternetConnectionChecker());

  connectionSubscription = checker.onStatusChange.listen((status) {
    if (status == InternetConnectionStatus.disconnected) {
      _showNoInternetDialog();
    }
  });
}

void _showNoInternetDialog() {
  // TODO: Handle no internet connection by showing a dialog, redirecting, etc.
}

