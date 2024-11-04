import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
abstract class InternetChecker {
  Stream<InternetConnectionStatus> get connectionStream;

  void startListening();
  void dispose();
}
class InternetCheckerImplementer implements InternetChecker {
  static final InternetCheckerImplementer _instance = InternetCheckerImplementer._internal();

  factory InternetCheckerImplementer() => _instance;

  InternetCheckerImplementer._internal();

  late final StreamSubscription<InternetConnectionStatus> _connectionSubscription;
  final StreamController<InternetConnectionStatus> _controller = StreamController.broadcast();

  @override
  Stream<InternetConnectionStatus> get connectionStream => _controller.stream;

  @override
  void startListening() {
    _connectionSubscription = InternetConnectionChecker().onStatusChange.listen((status) {
      _controller.add(status);
    });
  }

  @override
  void dispose() {
    _connectionSubscription.cancel();
    _controller.close();
  }
}
