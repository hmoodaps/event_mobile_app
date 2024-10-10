import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mobile_app/presentation/components/constants/assets_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/color_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/routs_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:flutter/material.dart';

import '../../../data/local_storage/shared_local.dart';
import '../../../domain/local_models/models.dart';
import '../../components/constants/general_strings.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({super.key});

  @override
  State<SplashRoute> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  final bool _isFirstTimeOpened =
      SharedPref.getBool(GeneralStrings .isFirstTimeOpened) ?? true;
  final bool _isGuest = SharedPref.getBool(GeneralStrings .isGuest) ?? false;

  Timer? _delay;

  _startDelay() {
    _delay = Timer(Duration(seconds: SizeManager.i4), _endSplash);
  }

  _endSplash() {
    navigateTo(
        context,
        _isFirstTimeOpened
            ? RouteStringsManager .onboardingRoute
            : _isGuest
                ? RouteStringsManager .mainRoute
                : RouteStringsManager .questionRoute);
    dispose();
  }
  _initFirebase()async{
    userIds.clear();
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(GeneralStrings.users).get();
    for (var doc in snapshot.docs) {
      userIds.add(doc.id);
    }

  }
  @override
  void initState() {

    super.initState();
    _initFirebase();
    _startDelay();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _delay?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primarySecond,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              AssetsManager.cinemaAsset,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
