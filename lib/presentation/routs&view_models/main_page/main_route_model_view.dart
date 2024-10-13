import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/events.dart';
import 'package:event_mobile_app/presentation/components/constants/icons_manager.dart';
import 'package:event_mobile_app/presentation/routs&view_models/favorit/favorite_route.dart';
import 'package:event_mobile_app/presentation/routs&view_models/profile/profile_route.dart';
import 'package:event_mobile_app/presentation/routs&view_models/search/search_route.dart';
import 'package:flutter/cupertino.dart';

import '../movies/movies_route.dart';

class MainRouteModelView extends BaseViewModel with MainRouteFunctions{
  late BuildContext context;
  int newIndex = 0 ;
  late final EventsBloc _bloc;
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
  }

  onTap(int index){
    newIndex = index ;
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
    Icon(IconsManager.home , color:  CupertinoColors.black,),
    //favorite
    Icon(IconsManager.favorite, color:  CupertinoColors.black),
    //search
    Icon(IconsManager.cart, color:  CupertinoColors.black),

    //profile
    Icon(IconsManager.profile, color:  CupertinoColors.black),

  ];

}
mixin MainRouteFunctions{

}