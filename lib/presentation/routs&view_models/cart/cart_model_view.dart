import 'dart:async';

import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/movie/movie_route.dart';
import 'package:flutter/material.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../data/local_storage/shared_local.dart';
import '../../bloc_state_managment/events.dart';

class CartModelView extends BaseViewModel {
  BuildContext context;

  CartModelView(this.context);

  late EventsBloc _bloc;
  late bool isLoaded = false;

  late final StreamSubscription blocStreamSubscription;

  @override
  void dispose() {
    blocStreamSubscription.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    startListen();
    if (VariablesManager.currentUser != null) {
      getCartItems();
    }
    _bloc.add(GetFavesItemsEvent());
  }

  startListen() {
    blocStreamSubscription = _bloc.stream.listen((state) async {
      if (state is GetFavesItemsState &&
          (SharedPref.prefs.getString(GeneralStrings.currentUser) == null
              ? SharedPref.prefs
                  .getStringList(GeneralStrings.listFaves)!
                  .isNotEmpty
              : VariablesManager.currentUserRespon.favorites!.isNotEmpty)) {
        isLoaded = true;
        _bloc.add(GetFavesItemsStateSuccessEvent());
      }
    });
  }

  getCartItems() {
    _bloc.add(GetCurrentUserResponseEvent());
  }

  void addFilmToCartEvent(MovieResponse movie) {
    _bloc.add(AddFilmToCartEvent(movie));
  }

  void removeFilmFromCartEvent(MovieResponse movie) {
    _bloc.add(RemoveFilmFromCartEvent(movie));
  }

  onItemPressed(MovieResponse movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MovieRoute(movie: movie),
      ),
    );
  }


  void addFilmToFavEvent(MovieResponse movie) {
    _bloc.add(AddFilmToFavEvent(movie));
  }

  void removeFilmFromFavEvent(MovieResponse movie) {
    _bloc.add(RemoveFilmFromFavEvent(movie));
  }
}
