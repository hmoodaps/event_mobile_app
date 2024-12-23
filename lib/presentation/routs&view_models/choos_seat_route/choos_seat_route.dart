import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/choos_seat_route/choos_seat_model_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../data/models/movie_model.dart';
import '../../../domain/local_models/models.dart';

class Seat extends StatefulWidget {
  final MovieResponse movie;

  const Seat({
    super.key,
    required this.movie,
  });

  @override
  State<Seat> createState() => _SeatState();
}

class _SeatState extends State<Seat> {
  late ChooseSeatModelView _model;

  @override
  void initState() {
    super.initState();
    _model = ChooseSeatModelView(movie: widget.movie, context: context);
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
        builder: (context, state) => _getScaffold());
  }

  Widget _getScaffold() => Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () {
                  List<int> selectedSeats = _model.getSelectedSeats();
                  if (selectedSeats.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content:
                            Text(GeneralStrings.uDidnotSelectSeat(context)),
                      ),
                    );
                  }
                  if (kDebugMode) {
                    print('Selected Seats: $selectedSeats');
                  }
                },
                child: Text(
                  GeneralStrings.go(context),
                  style: TextStyleManager.header(context)
                      ?.copyWith(color: ColorManager.green3),
                ))
          ],
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconsManager.arrowBack,
          ),
          title: Text(
            GeneralStrings.chooseSeat(context),
            style:
                TextStyleManager.header(context)?.copyWith(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(SizeManager.d20),
              child: Column(
                children: [
                  SizedBox(
                    height: GetSize.heightValue(SizeManager.d20, context),
                  ),
                  SvgPicture.asset(
                    AssetsManager.screen,
                    colorFilter: ColorFilter.mode(
                        ColorManager.green3, BlendMode.modulate),
                    //     color: ColorManager.green3,
                    height: GetSize.heightValue(SizeManager.d50, context),
                    width: GetSize.widthValue(SizeManager.d70, context),
                  ),
                  SizedBox(
                    height: GetSize.heightValue(SizeManager.d70, context),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 2.5,
                    width: MediaQuery.of(context).size.width,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: _model.seatsLeft.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 5,
                                ),
                                itemBuilder: (context, index) {
                                  bool isReserved = widget.movie.reservedSeats!
                                      .contains(index +
                                          SizeManager
                                              .i1); // check if the seat is reserved
                                  return GestureDetector(
                                    onTap: () {
                                      if (!isReserved) {
                                        setState(() {
                                          _model.seatsLeft[index] =
                                              !_model.seatsLeft[index];
                                        });
                                      }
                                    },
                                    child: Image.asset(
                                      AssetsManager.seat,
                                      color: isReserved
                                          ? Colors.red // Reserved seat is red
                                          : _model.seatsLeft[index]
                                              ? Colors
                                                  .green // Selected seat is green
                                              : Colors
                                                  .white, // Available seat is white
                                    ),
                                  );
                                },
                              ),
                            ),
                            SizedBox(
                              width:
                                  GetSize.widthValue(SizeManager.d30, context),
                            ),
                            Expanded(
                              child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: _model.seatsRight.length,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: SizeManager.i5,
                                ),
                                itemBuilder: (context, index) {
                                  bool isReserved = widget.movie.reservedSeats!
                                      .contains(_model.seatsLeft.length +
                                          index +
                                          SizeManager.i5);
                                  return GestureDetector(
                                    onTap: () {
                                      if (!isReserved) {
                                        setState(() {
                                          _model.seatsRight[index] =
                                              !_model.seatsRight[index];
                                        });
                                      }
                                    },
                                    child: Image.asset(
                                      AssetsManager.seat,
                                      color: isReserved
                                          ? Colors.red // Reserved seat is red
                                          : _model.seatsRight[index]
                                              ? Colors
                                                  .green // Selected seat is green
                                              : Colors
                                                  .white, // Available seat is white
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "^",
                                  style: TextStyle(
                                      color: ColorManager.green3,
                                      fontSize: SizeManager.d24),
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(
                                    height: GetSize.heightValue(
                                        SizeManager.d200, context)),
                                Transform.rotate(
                                  angle: 3.14,
                                  child: Text(
                                    "^",
                                    style: TextStyle(
                                        color: ColorManager.green3,
                                        fontSize: SizeManager.d24),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        Transform.rotate(
                          angle: 1.58,
                          child: CustomPaint(
                            size: Size(
                                GetSize.widthValue(SizeManager.d200, context),
                                GetSize.heightValue(SizeManager.d4, context)),
                            painter: GradientLinePainter(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: GetSize.heightValue(SizeManager.d20, context),
                  ),
                  CustomPaint(
                    size: Size(GetSize.widthValue(SizeManager.d300, context),
                        GetSize.heightValue(SizeManager.d4, context)),
                    painter: GradientLinePainter(),
                  ),
                  SizedBox(
                    height: GetSize.heightValue(SizeManager.d20, context),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        GeneralStrings.available(context),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: GetSize.widthValue(SizeManager.d5, context),
                      ),
                      Image.asset(AssetsManager.seat,
                          height: GetSize.heightValue(SizeManager.d50, context),
                          width: GetSize.widthValue(SizeManager.d30, context),
                          color: Colors.white),
                      Text(
                        GeneralStrings.selected(context),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: GetSize.widthValue(SizeManager.d5, context),
                      ),
                      Image.asset(
                          height: GetSize.heightValue(SizeManager.d50, context),
                          width: GetSize.widthValue(SizeManager.d30, context),
                          AssetsManager.seat,
                          color: ColorManager.green3),
                      Text(
                        GeneralStrings.reserved(context),
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(
                        width: GetSize.widthValue(SizeManager.d5, context),
                      ),
                      Image.asset(
                          height: GetSize.heightValue(SizeManager.d50, context),
                          width: GetSize.widthValue(SizeManager.d30, context),
                          AssetsManager.seat,
                          color: Colors.red),
                    ],
                  ),
                  SizedBox(
                    height: GetSize.heightValue(SizeManager.d30, context),
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            GeneralStrings.seatPrice(context),
                            style: TextStyleManager.header(context),
                          ),
                          Text(
                            "${widget.movie.ticketPrice!} €",
                            style: TextStyleManager.header(context)
                                ?.copyWith(color: ColorManager.green3),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            GeneralStrings.seatsChosen(context),
                            style: TextStyleManager.header(context),
                          ),
                          Text(
                            '${_model.getSelectedSeats().length}',
                            style: TextStyleManager.header(context)
                                ?.copyWith(color: ColorManager.green3),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            GeneralStrings.selectedSeats(context),
                            style: TextStyleManager.header(context),
                          ),
                          // استخدام Wrap لتوزيع النص عبر أسطر متعددة
                          Expanded(
                            child: Wrap(
                              children: [
                                Text(
                                  _model.getSelectedSeats().join(', '),
                                  style: TextStyleManager.header(context)
                                      ?.copyWith(color: ColorManager.green3),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            GeneralStrings.finalPrice(context),
                            style: TextStyleManager.header(context),
                          ),
                          Text(
                            '${_model.getSelectedSeats().length * widget.movie.ticketPrice!}',
                            style: TextStyleManager.header(context)
                                ?.copyWith(color: ColorManager.green3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
