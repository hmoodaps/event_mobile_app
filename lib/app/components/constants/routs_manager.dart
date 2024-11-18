import 'package:event_mobile_app/app/components/constants/route_strings_manager.dart';
import 'package:flutter/material.dart';

import '../../../presentation/routs&view_models/cart/cart_route.dart';
import '../../../presentation/routs&view_models/edit_reservation/edit_reservation_route.dart';
import '../../../presentation/routs&view_models/favorit/favorite_route.dart';
import '../../../presentation/routs&view_models/forget_password/forget_password_route.dart';
import '../../../presentation/routs&view_models/login/login_route.dart';
import '../../../presentation/routs&view_models/main_page/main_route.dart';
import '../../../presentation/routs&view_models/movie/movie_route.dart';
import '../../../presentation/routs&view_models/onboarding/onboarding_route.dart';
import '../../../presentation/routs&view_models/past_films/past_films_route.dart';
import '../../../presentation/routs&view_models/profile/profile_route.dart';
import '../../../presentation/routs&view_models/question/question_route.dart';
import '../../../presentation/routs&view_models/regeister/register_route.dart';
import '../../../presentation/routs&view_models/reservation/reservation_route.dart';
import '../../../presentation/routs&view_models/search/search_route.dart';
import '../../../presentation/routs&view_models/splash/splash_route.dart';
import '../../../presentation/routs&view_models/take_user_Details/take_user_details_route.dart';

class Routes {
  static final Map<String, WidgetBuilder> routeBuilders = {
    RouteStringsManager.splashRoute: (context) => const SplashRoute(),
    RouteStringsManager.onboardingRoute: (context) => const OnboardingRoute(),
    RouteStringsManager.loginRoute: (context) => const LoginRoute(),
    RouteStringsManager.questionRoute: (context) => const QuestionRoute(),
    RouteStringsManager.registerRoute: (context) => const RegisterRoute(),
    RouteStringsManager.forgetPasswordRoute: (context) =>
        const ForgetPasswordRoute(),
    RouteStringsManager.mainRoute: (context) => const MainRoute(),
    RouteStringsManager.editReservationRoute: (context) =>
        const EditReservationRoute(),
    RouteStringsManager.reservationRoute: (context) => const ReservationRoute(),
    RouteStringsManager.movieRoute: (context) => const MovieRoute(),
    RouteStringsManager.cartRoute: (context) => const CartRoute(),
    RouteStringsManager.favoriteRoute: (context) => const FavoriteRoute(),
    RouteStringsManager.pastFilmsRoute: (context) => const PastFilmsRoute(),
    RouteStringsManager.profileRoute: (context) => const ProfileRoute(),
    RouteStringsManager.searchRoute: (context) => const SearchRoute(),
    RouteStringsManager.takeUserDetailsRoute: (context) =>
        const TakeUserDetailsRoute(),
  };

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final builder = routeBuilders[settings.name];
    if (builder != null) {
      return MaterialPageRoute(
        builder: builder,
        settings: settings,
      );
    }
    // Handle unknown routes
    return MaterialPageRoute(
      builder: (context) => const SplashRoute(),
      settings: settings,
    );
  }
}

// navigation to routes >>
void navigateTo(BuildContext context, String route) {
  final builder = Routes.routeBuilders[route];
  if (builder != null) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            builder(context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
        },
      ),
    );
  } else {
    // Handle unknown routes
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SplashRoute(),
      ),
    );
  }
}
