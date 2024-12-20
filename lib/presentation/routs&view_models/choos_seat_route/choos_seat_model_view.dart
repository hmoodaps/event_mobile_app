import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/cupertino.dart';

class ChooseSeatModelView extends BaseViewModel {
  MovieResponse movie;
  BuildContext context;
  late EventsBloc bloc;

  ChooseSeatModelView({required this.movie, required this.context});

  late List<bool> seatsLeft;
  late List<bool> seatsRight;

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
    // TODO: implement dispose
  }

  @override
  void start() {
    print(movie.seats);
    bloc = EventsBloc.get(context);

    int totalSeats = movie.seats ?? 0;
    int halfSeats = (totalSeats / 2).ceil();

    seatsLeft =
        List.generate(halfSeats, (_) => false); // Initially no seats selected
    seatsRight = List.generate(
        totalSeats - halfSeats, (_) => false); // Same for the right section
  }
}
