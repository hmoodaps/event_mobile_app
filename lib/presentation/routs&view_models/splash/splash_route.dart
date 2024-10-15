import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_mobile_app/presentation/components/constants/assets_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/color_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/route_strings_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/routs_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';

import '../../../data/local_storage/shared_local.dart';
import '../../components/constants/general_strings.dart';

class SplashRoute extends StatefulWidget {
  const SplashRoute({super.key});

  @override
  State<SplashRoute> createState() => _SplashRouteState();
}

class _SplashRouteState extends State<SplashRoute> {
  final bool _isFirstTimeOpened =
      SharedPref.getBool(GeneralStrings.isFirstTimeOpened) ?? true;
  final bool _isGuest = SharedPref.getBool(GeneralStrings.isGuest) ?? false;

  Future<void> _initFirebase() async {
    VariablesManager.userIds.clear();
    QuerySnapshot snapshot = await FirebaseFirestore.instance.collection(
        GeneralStrings.users).get();
    for (var doc in snapshot.docs) {
      VariablesManager.userIds.add(doc.id);
    }
  }

  Future<void> _startDelay() async {
    await Future.delayed(Duration(seconds: SizeManager.i4), _endSplash);
    //TODO :: active this after finish every thing
    // await _initFirebase();
    //  List<MovieModel> movies = await DioHelper.fetchMovies();
    //  VariablesManager.movies = movies;
  }

  void _endSplash() {
    _isGuest == false
        ? Navigator.pushNamedAndRemoveUntil(
      context,
      _isFirstTimeOpened
          ? RouteStringsManager.onboardingRoute
          : RouteStringsManager.questionRoute, (route) => false,)
        : Navigator.pushNamedAndRemoveUntil(
        context, RouteStringsManager.mainRoute, (route) => false);
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
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
