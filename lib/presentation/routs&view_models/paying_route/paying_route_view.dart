import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/text_form_manager.dart';
import '../../../domain/local_models/models.dart';
import '../CheckOutPage/card.dart';

class PayingRouteView extends StatefulWidget {
  const PayingRouteView({super.key});

  @override
  State<PayingRouteView> createState() => _PayingRouteViewState();
}

class _PayingRouteViewState extends State<PayingRouteView> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController endDateController = TextEditingController();
  TextEditingController nameOnTheCardController = TextEditingController();
  late String cardNumber = '';
  String endDate = '';
  String cardHolder = '';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => _getScaffold(),
    );
  }

  _getScaffold() => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconsManager.arrowBack),
        ),
        body:SingleChildScrollView(
          child: Form(
            key: formKey,
            child: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(SizeManager.d14),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    spacing: 20,
                    children: [
                      StaggeredAnimatedWidget(delay: SizeManager.i200 , child: myCreditCard(cardKey ,cardNumber: cardNumber )),
                      SizedBox(height: 20,),
                      StaggeredAnimatedWidget(

                          delay: SizeManager.i400,
                          child: textFormField(
                            maxLength : 16 ,

                            context: context,
                            controller: cardNumberController,
                            hintText: "XXXX XXXX XXXX XXXX XXXX",
                            labelText: "Card Number",
                            prefix: Icon(IconsManager.profile),
                            onFieldSubmitted: (p0) => toNextField,
                            validator: (p0) => validator(p0, context),
                            onChanged: (p0) => setState(() {
                              cardNumber = p0 ;
                            }),
                          ),),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i800,
                          child: textFormField(
                              context: context,
                              controller: endDateController,
                              hintText: "MM/YY",
                              labelText: "End Date",
                              prefix: Icon(IconsManager.key),
                              onFieldSubmitted: (p0) => toNextField,
                              validator: (p0) => validator(p0, context),
                              suffix: Icon(IconsManager.hide),),),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i600,
                          child: textFormField(
                            context: context,
                            controller: cvvController,
                            hintText: GeneralStrings.ahmadEmail,
                            labelText: GeneralStrings.email(context),
                            prefix: Icon(IconsManager.email),
                            onFieldSubmitted: (p0) => toNextField,
                            validator: (p0) => validator(p0, context),
                          )),
                      StaggeredAnimatedWidget(
                          delay: SizeManager.i800,
                          child: textFormField(
                              context: context,
                              controller: nameOnTheCardController,
                              hintText: "Ahmed Alnahhal",
                              labelText: "Card Holder",
                              prefix: Icon(IconsManager.key),
                              onFieldSubmitted: (p0) => toNextField,
                              validator: (p0) => validator(p0, context),
                              suffix: Icon(IconsManager.hide),),),


                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

  );
}
