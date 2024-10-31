import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:icon_broken/icon_broken.dart';

class IconsManager {
  static const IconData home = IconBroken.Home;
  static const IconData login = IconBroken.Login;

  static const IconData register = IconBroken.AddUser;
  static const IconData person = IconBroken.User;
  static const IconData eye = IconBroken.Password;
  static const IconData hide = IconBroken.Hide;
  static const IconData key = IconBroken.Password;
  static const IconData email = IconBroken.Message;
  static const IconData profile = IconBroken.Profile;
  static const IconData favorite = IconBroken.Heart;
  static const IconData search = IconBroken.Search;
  static const IconData cart = IconBroken.Bag_2;

  static const Icon arrowBack = Icon(
    IconBroken.Arrow___Left_2,
    size: SizeManager.d24,
  );
}
