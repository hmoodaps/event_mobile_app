import 'package:event_mobile_app/domain/models/show_time_response/show_time_response.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/models/movie_model/movie_model.dart';
import '../../bloc_state_managment/events.dart';

class ChooseSeatModelView extends BaseViewModel {
  MovieResponse movie;
  ShowTimesResponse selectedShowTime;

  BuildContext context;
  late EventsBloc _bloc;


  ChooseSeatModelView(
      {required this.movie,
      required this.context,
      required this.selectedShowTime});

  late List<bool> seatsLeft;
  late List<bool> seatsRight;
  getMovie(){
    _bloc.add(GetMovieEvent(movieId:movie.id!));
  }
  List<int> getSelectedSeats() {
    List<int> selectedSeats = [];
    for (int i = 0; i < seatsLeft.length; i++) {
      if (seatsLeft[i]) {
        selectedSeats.add(i + 1); // Adding the seat number (starting from 1)
      }
    }

    for (int i = 0; i < seatsRight.length; i++) {
      if (seatsRight[i]) {
        selectedSeats.add(seatsLeft.length +
            i +
            1); // Adding the seat number for right section
      }
    }

    return selectedSeats;
  }

  @override
  void dispose() {

  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);

    int totalSeats = selectedShowTime.total_seats ?? 0;
    int halfSeats = (totalSeats / 2).ceil();

    seatsLeft =
        List.generate(halfSeats, (_) => false); // Initially no seats selected
    seatsRight = List.generate(
        totalSeats - halfSeats, (_) => false); // Same for the right section
  }
}
