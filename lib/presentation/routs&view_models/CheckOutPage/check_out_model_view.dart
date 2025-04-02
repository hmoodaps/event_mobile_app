import 'dart:async';
import 'dart:developer';

import 'package:event_mobile_app/app/components/constants/dio_and_mapper_constants.dart';
import 'package:event_mobile_app/app/components/constants/notification_handler.dart';
import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/data/mapper/mapper.dart';
import 'package:event_mobile_app/data/network_data_handler/remote_requests/dio_requests_handler.dart';
import 'package:event_mobile_app/domain/models/billing_info/billing_info.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../domain/local_models/models.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import '../../../domain/models/show_time_response/show_time_response.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';

class CheckOutModelView extends BaseViewModel {
  BuildContext context;
  late EventsBloc _bloc;
  final MovieResponse movie;
  final ShowTimesResponse showTimesResponse;
  final List<int> reservedSeats;
  late final StreamSubscription _blocStreamSubscription;
  Response<dynamic>? _paymentResponse;
  double _amount = 0;
  String reservationCode = '';
  String refNum = '';

  double get amount => _amount;

  set amount(double value) {
    if (value < 0) throw ArgumentError("Amount cannot be negative");
    _amount = value;
  }

  CheckOutModelView({
    required this.movie,
    required this.showTimesResponse,
    required this.reservedSeats,
    required this.context,
  });

  @override
  void dispose() {
    _blocStreamSubscription.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    _startListen();
  }

  void _startListen() {
    _blocStreamSubscription = _bloc.stream.listen((state) async {
      if (state is GetMovieState) {
        ShowTimesResponse? currentShowTime = state.movieResponse.show_times?.firstWhere(
              (showTime) => showTime.id == showTimesResponse.id,
          orElse: () => ShowTimesResponse(reserved_seats: []),
        );

        bool hasConflict = reservedSeats.any((seat) =>
            (currentShowTime?.reserved_seats ?? []).contains(seat));

        if (hasConflict) {
          errorNotification(
              context: context,
              description: "Someone else chose these seats. Please select different seats.");
          Navigator.pop(context);
        } else {
          _bloc.add(GenerateBillRefNumEvent());
          _bloc.add(MakePaymentEvent(
              amount: amount, clientEmail: VariablesManager.currentUserResponse.email));
        }
      }
      if(state is GenerateBillRefNumState){
        this.refNum = state.refNum;
      }

      if (state is MakePaymentSuccessState) {

        this._paymentResponse = state.response;
        log("MakePaymentSuccessState ${_paymentResponse!.data.toString()}");

        _makeReservation();
      }

      if (state is MakeReservationState) {
        if (state.error != null) {
          log("Reservation error: ${state.error}");
        } else {
          BillingInfo billingInfo = BillingInfo(

            referenceNumber: refNum,
            charging_id: _paymentResponse?.data["id"],
              guestId: VariablesManager.currentUserResponse.id!,
              reserved_seats: reservedSeats,
              reservations_code: state.reservationCode!,
              showTimesResponseDate: showTimesResponse.date,
              showTimesResponseHall: showTimesResponse.hall,
              showTimesResponseId: showTimesResponse.id,
              showTimesResponseTime: showTimesResponse.time,
              ticket_price: showTimesResponse.ticket_price,
              duration: movie.duration,
              movieId: movie.id,
              movieName: movie.name,
              photo: movie.photo,
              tags: movie.tags,
            verticalPhoto: movie.vertical_photo,
            totalBill: calculateTotalToPay(),
            priceWithoutOffer: calculateTotalPrice(),
            reservationDate: DateTime.now(),
            paymentType: _paymentResponse?.data["payment_method_details"]?["type"],
            receiptUrl: _paymentResponse?.data["receipt_url"],
            refunded: _paymentResponse?.data["refunded"]
          );
          this.reservationCode = state.reservationCode!;
          log("Reservation successful!");
          _bloc.add(AddBillsToFirebaseEvent(bill: billingInfo.toDomain()));
          _bloc.add(StartFetchMoviesEvent());
        }
      }

      if(state is AddBillsToFirebaseState){
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => SimpleMovieTicket(
                seatPrice:calculateTotalToPay() ,
                movieName: movie.name!,
                showDate: showTimesResponse.date!,
                showTime: showTimesResponse.time!,
                hall: showTimesResponse.hall!,
                reservedSeats: reservedSeats,
                reservationCode: reservationCode,
                verticalPhoto:movie.vertical_photo! ,
                photo:movie.photo! ,

              ),
            ));

      }
    });
  }

  Future<void> onPayButtonPressed({required double amount}) async {
    _makeReservation();
  //   showDialog(
  //     context: context,
  //     barrierDismissible: true,
  //     builder: (context) => AlertDialog(
  //       content: Row(
  //         children: [
  //           CircularProgressIndicator(),
  //           SizedBox(width: 20),
  //           Text("Processing Payment..."),
  //         ],
  //       ),
  //     ),
  //   );
  //   // this.amount = amount;
  //   // getMovie();
  // final  response = await DioHelper.dio?.post(
  //     AppConstants.createPayment,
  //     options: Options(headers:{"Authorization":""} ),
  //     data:{
  //       "amount": amount,
  //       "description": "fsfs"
  //     }
  //   );
  // launchUrl(Uri.parse(response?.data["_links"]["checkout"]["href"]));
  }

  void _makeReservation() {
    log("Starting reservation process...");
    _bloc.add(MakeReservationEvent(
      guest_id: VariablesManager.currentUser!,
      movie_id: movie.id!,
      seat_numbers: reservedSeats,
      showtime_id: showTimesResponse.id!,
    ));
  }

  double calculateSeatPrice() => showTimesResponse.ticket_price! * 1.4;

  double calculateTotalPrice() => calculateSeatPrice() * reservedSeats.length;

  double calculateTotalDiscount() =>
      calculateTotalPrice() - (showTimesResponse.ticket_price! * reservedSeats.length);

  double calculateTotalToPay() => showTimesResponse.ticket_price! * reservedSeats.length;

  void getMovie() {
    _bloc.add(GetMovieEvent(movieId: movie.id!));
  }
}
