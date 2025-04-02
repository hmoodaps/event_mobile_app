import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/handle_app_language/handle_app_language.dart';
import 'package:event_mobile_app/domain/models/show_time_response/show_time_response.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/ticket.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:staggered_animated_widget/animation_direction.dart';
import 'package:staggered_animated_widget/staggered_animated_column.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import 'check_out_model_view.dart';

class CheckOutRoute extends StatefulWidget {
  final MovieResponse movie;
  final ShowTimesResponse showTimesResponse;
  final List<int> reservedSeats;

  const CheckOutRoute(
      {super.key,
      required this.movie,
      required this.showTimesResponse,
      required this.reservedSeats});

  @override
  State<CheckOutRoute> createState() => _CheckOutRouteState();
}

class _CheckOutRouteState extends State<CheckOutRoute> {
  late CheckOutModelView _checkOutModelView;

  @override
  void initState() {
    super.initState();
    _checkOutModelView = CheckOutModelView(
        context: context,
        movie: widget.movie,
        reservedSeats: widget.reservedSeats,
        showTimesResponse: widget.showTimesResponse);
    _checkOutModelView.start();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => _getScaffold(),
    );
  }

  Widget _getScaffold() => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconsManager.arrowBack),
          title: Text(GeneralStrings.checkOut(context),
              style: TextStyleManager.titleStyle(context)),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                StaggeredAnimatedColumn(
                    delayIncrement: SizeManager.i300,
                    direction: TheAppLanguage.appLanguage == "ar"
                        ? AnimationDirection.fromRight
                        : AnimationDirection.fromLeft,
                    spacing: SizeManager.d12,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ///movie name
                      /// show date
                      /// show time
                      /// hall
                      /// chosen seats
                      /// seat price
                      /// total price
                      /// total discount
                      /// total to pay
                      //================movie name==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.filmName(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${widget.movie.name}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      //================show date==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.date(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${widget.showTimesResponse.date}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      //================show time==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.time(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${widget.showTimesResponse.time}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      //================hall==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.hall(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${widget.showTimesResponse.hall}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      //================chosen seats==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.seatsChosen(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${widget.reservedSeats.join(', ')}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      //================seat price==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.seatPrice(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${_checkOutModelView.calculateSeatPrice().toStringAsFixed(2)}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      //================total price==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.totalPrice(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${_checkOutModelView.calculateTotalPrice().toStringAsFixed(2)}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      //================total discount==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.totalDiscount(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${_checkOutModelView.calculateTotalDiscount().toStringAsFixed(2)}",
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(color: ColorManager.green4),
                          ),
                        ],
                      ),
                      //================total discount==================
                      Row(
                        spacing: 5,
                        children: [
                          Text(GeneralStrings.totalToPay(context),
                              style: TextStyleManager.bodyStyle(context)),
                          Text(
                            "${_checkOutModelView.calculateTotalToPay().toStringAsFixed(2)}",
                            style: TextStyleManager.header(context)?.copyWith(
                                color: ColorManager.green4, fontSize: 35),
                          ),
                        ],
                      ),
                    ]),
                Spacer(),
                StaggeredAnimatedWidget(
                  delay: SizeManager.i3000,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: GestureDetector(
                      onTap: () async {
                        _checkOutModelView.onPayButtonPressed(amount: _checkOutModelView.calculateTotalToPay());
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            ContainerManager.myShadow(
                                shadowColor: Colors.black45),
                          ],
                          borderRadius: BorderRadius.circular(SizeManager.d20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.white,
                              ColorManager.green4,
                              ColorManager.green3,
                            ],
                            stops: [0.00001, 0.5, 1],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        height: GetSize.heightValue(SizeManager.d50, context),
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            "${GeneralStrings.pay(context)} ",
                            style: TextStyleManager.bodyStyle(context)
                                ?.copyWith(
                                    color: Colors.black,
                                    fontWeight: FontWeightManager.bold),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}





