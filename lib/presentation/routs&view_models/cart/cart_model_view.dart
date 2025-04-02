// import 'package:event_mobile_app/core/models/movie_model.dart';
// import 'package:event_mobile_app/presentation/base/base_view_model.dart';
// import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
// import 'package:event_mobile_app/presentation/routs&view_models/movie/movie_route.dart';
// import 'package:flutter/material.dart';
//
// import '../../bloc_state_managment/events.dart';
//
// class CartModelView extends BaseViewModel {
//   BuildContext context;
//
//   CartModelView(this.context);
//
//   late EventsBloc _bloc;
//
//   @override
//   void dispose() {}
//
//   @override
//   void start() {
//     _bloc = EventsBloc.get(context);
//     _bloc.add(GetCartItemsEvent());
//     _bloc.add(GetCurrentUserResponseEvent());
//   }
//
//   void addFilmToCartEvent(MovieResponse movie) {
//     _bloc.add(AddFilmToCartEvent(movie));
//   }
//
//   void removeFilmFromCartEvent(MovieResponse movie) {
//     _bloc.add(RemoveFilmFromCartEvent(movie));
//   }
//
//   onItemPressed(MovieResponse movie) {
//     Navigator.push(
//       context,
//       MaterialPageRoute(
//         builder: (context) => MovieRoute(movie: movie),
//       ),
//     );
//   }
//
//   void addFilmToFavEvent(MovieResponse movie) {
//     _bloc.add(AddFilmToFavEvent(movie));
//   }
//
//   void removeFilmFromFavEvent(MovieResponse movie) {
//     _bloc.add(RemoveFilmFromFavEvent(movie));
//   }
// }
