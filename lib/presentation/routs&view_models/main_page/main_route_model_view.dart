import 'package:flutter/cupertino.dart';

import '../../../app/components/constants/icons_manager.dart';
import '../../base/base_view_model.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import '../favorit/favorite_route.dart';
import '../movies/movies_route.dart';
import '../profile/profile_route.dart';

class MainRouteModelView extends BaseViewModel {
  late BuildContext context;
  int newIndex = 0;

  MainRouteModelView(this.context);

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
      // case 2:
      //   return _ForCartIsLoginOrNot();
      case 2:
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
    // //search
    // Icon(IconsManager.cart, color: CupertinoColors.black),

    //profile
    Icon(IconsManager.profile, color: CupertinoColors.black),
  ];
}

// class _ForCartIsLoginOrNot extends StatelessWidget {
//   const _ForCartIsLoginOrNot();
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EventsBloc, AppStates>(builder: (context, state) {
//       if (VariablesManager.firebaseAuthInstance.currentUser == null) {
//         return Scaffold(
//           body: stackBackGroundManager(
//               otherWidget: _screenWidgets(context),
//               isDark: VariablesManager.isDark),
//         );
//       } else {
//         return CartRoute();
//       }
//     });
//   }
//
//   _screenWidgets(BuildContext context) {
//     return <Widget>[
//       Padding(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               GeneralStrings.notLoggedIn(context),
//               style: TextStyleManager.titleStyle(context),
//             ),
//             SizedBox(
//               height: GetSize.heightValue(SizeManager.d10, context),
//             ),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () =>
//                       navigateTo(context, RouteStringsManager.registerRoute),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: ColorManager.green4,
//                         borderRadius: BorderRadius.circular(30)),
//                     height: GetSize.heightValue(SizeManager.d60, context),
//                     width: GetSize.widthValue(SizeManager.d120, context),
//                     child: Center(
//                       child: Text(GeneralStrings.login(context)),
//                     ),
//                   ),
//                 ),
//                 Spacer(),
//                 GestureDetector(
//                   onTap: () =>
//                       navigateTo(context, RouteStringsManager.loginRoute),
//                   child: Container(
//                     decoration: BoxDecoration(
//                         color: ColorManager.green4,
//                         borderRadius: BorderRadius.circular(30)),
//                     height: GetSize.heightValue(SizeManager.d60, context),
//                     width: GetSize.widthValue(SizeManager.d120, context),
//                     child: Center(
//                       child: Text(GeneralStrings.register(context)),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//       ),
//     ];
//   }
// }
