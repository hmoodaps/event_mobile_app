import 'package:flutter/cupertino.dart';

import '../../../app/components/constants/icons_manager.dart';
import '../../base/base_view_model.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import '../favorit/favorite_route.dart';
import '../movies/movies_route.dart';
import '../profile/profile_route.dart';
import '../search/search_route.dart';

class MainRouteModelView extends BaseViewModel with MainRouteFunctions {
  late BuildContext context;
  int newIndex = 0;

  late final EventsBloc _bloc;

  @override
  void dispose() {}

  @override
  void start() {
    _bloc = EventsBloc.get(context);
  }

  onTap(int index) {
    newIndex = index;
    _bloc.add(ChangeNavigationBarIndexEvent());
  }

  Widget onNavigationBarIconPress() {
    switch (newIndex) {
      case 0:
        return MoviesRoute();
      case 1:
        return FavoriteRoute();
      case 2:
        return SearchRoute();
      case 3:
        return ProfileRoute();
      default:
        return MoviesRoute();
    }
  }

  List<Widget> bottomNavigationBarItems = [
    //home
    Icon(
      IconsManager.home,
      color: CupertinoColors.black,
    ),
    //favorite
    Icon(IconsManager.favorite, color: CupertinoColors.black),
    //search
    Icon(IconsManager.cart, color: CupertinoColors.black),

    //profile
    Icon(IconsManager.profile, color: CupertinoColors.black),
  ];
}

mixin MainRouteFunctions {}
