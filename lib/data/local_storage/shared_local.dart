import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {
  static late  SharedPreferences prefs;
static Future<void> init ()async{
    prefs = await SharedPreferences.getInstance();
}
static Future<void> saveBool({required String key,required bool value})async{
await  prefs.setBool(key, value);
}

  static bool ? getBool(String key){
return prefs.getBool(key);

}
static Future<void> listOfStrings({required String key,required List<String> value})async{
await  prefs.setStringList(key, value);
}

  static List<String> ? getStringList(String key){
return prefs.getStringList(key);

}


}

// ======== Exception caught by widgets library =======================================================
// The following LateError was thrown building Builder:
// LateInitializationError: Field 'prefs' has not been initialized.
//
// The relevant error-causing widget was:
// MaterialApp MaterialApp:file:///C:/Users/dell/AndroidStudioProjects/event_mobile_app/lib/app/app.dart:30:14
// When the exception was thrown, this was the stack:
// #0      SharedPref.prefs (package:event_mobile_app/data/local_storage/shared_local.dart)
// #1      SharedPref.getBool (package:event_mobile_app/data/local_storage/shared_local.dart:13:8)
// #2      new _SplashRouteState (package:event_mobile_app/presentation/routs&view_models/splash/splash_route.dart:21:18)
// #3      SplashRoute.createState (package:event_mobile_app/presentation/routs&view_models/splash/splash_route.dart:16:39)
// #4      new StatefulElement (package:flutter/src/widgets/framework.dart:5701:25)
// #5      StatefulWidget.createElement (package:flutter/src/widgets/framework.dart:776:38)
// ...     Normal element mounting (228 frames)
// #233    Element.inflateWidget (package:flutter/src/widgets/framework.dart:4468:16)
