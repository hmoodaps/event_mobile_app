import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/data/models/user_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import '../paying_route/paying_route_view.dart';

class CheckOutRoute extends StatefulWidget {
  final BillingInfo billingInfo;
  final MovieResponse movie;

  const CheckOutRoute(
      {super.key, required this.billingInfo, required this.movie});

  @override
  State<CheckOutRoute> createState() => _CheckOutRouteState();
}

class _CheckOutRouteState extends State<CheckOutRoute> {



  List<String> paymentsType = ["card", "Ideal"];
  late String currentPaymentType;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currentPaymentType = paymentsType[0];
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
          title: Text('Check out '),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  spacing: 5,
                  children: [
                    Text("film name :"),
                    Text(
                      widget.movie.name!,
                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: ColorManager.green4),
                    ),
                  ],
                ),
                Row(
                  spacing: 5, // خاصية المسافة بين العناصر
                  children: [
                    Text("seats numbers :"),
                    Text(
                      widget.billingInfo.reservedSeats.join(' , '),
                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: ColorManager.green4),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Text("seats count :"),
                    Text(
                      widget.billingInfo.reservedSeats.length.toString(),
                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: ColorManager.green4),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Text("seat price :"),
                    Text(
                      "${(widget.movie.ticketPrice! * 1.4).toStringAsFixed(2)} €",

                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: ColorManager.green4),
                    ),
                  ],
                ),
                Divider(color: Colors.black),
                Row(
                  spacing: 5,
                  children: [
                    Text("total price :"),
                    Text(
                      '${
                        ((widget.movie.ticketPrice! * 2.4) *
                                widget.billingInfo.reservedSeats.length)
                            .toStringAsFixed(2)
                      } €',
                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: ColorManager.green4),
                    ),
                  ],
                ),
                Row(
                  spacing: 5,
                  children: [
                    Text("total discount :"),
                    Text(
                      "${
                        (((widget.movie.ticketPrice! * 2.4) *
                                    widget.billingInfo.reservedSeats.length) -
                                widget.movie.ticketPrice! *
                                    widget.billingInfo.reservedSeats.length)
                            .toStringAsFixed(2)
                      } €",
                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: ColorManager.green4),
                    ),
                  ],
                ),
                Divider(color: Colors.black),
                Row(
                  spacing: 5,
                  children: [
                    Text("total to Pay : "),
                    Text(
                     '${
                        (widget.movie.ticketPrice! *
                                widget.billingInfo.reservedSeats.length)
                            .toStringAsFixed(2)
                      } €',
                      style: TextStyleManager.titleStyle(context)
                          ?.copyWith(color: ColorManager.green2 , fontSize: 28),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Select your payment method : ',
                  style: TextStyleManager.titleStyle(context),
                ),
                getOptions(),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => PayingRouteView(),));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          ContainerManager.myShadow(shadowColor: Colors.black45),
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
                          GeneralStrings.continueString(context),
                          style: TextStyleManager.bodyStyle(context)?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeightManager.bold),
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

  Widget getOptions() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 150,
          child: getListTileRadio(index),
        );
      },
      itemCount: paymentsType.length,
    );
  }

  Widget getListTileRadio(int index) {
    return ListTile(
      title: Text(paymentsType[index]),
      leading: Radio(
        value: paymentsType[index],
        groupValue: currentPaymentType,
        onChanged: (value) {
          setState(() {
            currentPaymentType = value.toString();
          });
        },
      ),
    );
  }
}
