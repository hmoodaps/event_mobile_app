import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/take_user_Details/take_user_details_model_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/text_form_manager.dart';
import '../../../domain/local_models/models.dart';

class TakeUserDetailsRoute extends StatefulWidget {
  const TakeUserDetailsRoute({super.key});

  @override
  State<TakeUserDetailsRoute> createState() => _TakeUserDetailsRouteState();
}

class _TakeUserDetailsRouteState extends State<TakeUserDetailsRoute> {
  final TakeUserDetailsModelView _modelView = TakeUserDetailsModelView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
      builder: (context, state) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: Form(
                  key: _modelView.formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: SizeManager.d70,),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i200,
                        child: Text(
                          GeneralStrings.fewData(context),
                          style: TextStyleManager.header(context)?.copyWith(fontSize: SizeManager.d30),
                        ),
                      ),
                      SizedBox(
                        height: SizeManager.d50,
                      ),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i200,
                        child: Text(
                          GeneralStrings.someInfo(context),
                          style: TextStyleManager.paragraphStyle(context),
                        ),
                      ),
                      SizedBox(height: SizeManager.d20),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i400,
                        child: textFormField(
                          readOnly: true,
                          controller: _modelView.dateOfBirth,
                          labelText: GeneralStrings.dateOfBirth(context),
                          prefix: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(IconsManager.email ),
                          ),
                          suffix: IconButton(
                            onPressed: _onDateIconPressed,
                            icon: Icon(IconsManager.calender),
                          ),
                          onFieldSubmitted: (p0) => toNextField,
                          validator: (p0) => validator(p0),
                          context: context,
                        ),
                      ),
                      SizedBox(height: SizeManager.d14,),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i600,
                        child: textFormField(
                          controller: _modelView.mobileNumber,
                          labelText: GeneralStrings.mobileNumber(context),
                          prefix: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(IconsManager.phone ),
                          ),
                          onFieldSubmitted: (p0) => toNextField,
                          validator: (p0) => validator(p0),
                          context: context,
                        ),
                      ),
                      SizedBox(height: SizeManager.d14,),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i600,
                        child: textFormField(
                          controller: _modelView.street,
                          labelText: GeneralStrings.street(context),
                          prefix: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(IconsManager.street ),
                          ),
                          onFieldSubmitted: (p0) => toNextField,
                          validator: (p0) => validator(p0),
                          context: context,
                        ),
                      ),
                      SizedBox(height: SizeManager.d14,),
                      SizedBox(
                        width: double.infinity,
                        child: StaggeredAnimatedWidget(
                          delay: SizeManager.i600,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: textFormField(
                                  controller: _modelView.houseNumber,
                                  labelText: GeneralStrings.houseNumber(context),
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Icon(IconsManager.home),
                                  ),
                                  onFieldSubmitted: (p0) => toNextField,
                                  validator: (p0) => validator(p0),
                                  context: context,
                                ),
                              ),
                              SizedBox(width: 10),
                              Expanded(
                                child: textFormField(
                                  controller: _modelView.additinalInfo,
                                  prefix: Padding(
                                    padding: const EdgeInsets.all(0.0),
                                    child: Icon(IconsManager.info),
                                  ),
                                  labelText: GeneralStrings.additinalInfo(context),
                                  onFieldSubmitted: (p0) => toNextField,
                                  validator: (p0) => validator(p0),
                                  context: context,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: SizeManager.d14,),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i600,
                        child: textFormField(
                          controller: _modelView.postalCode,
                          labelText: GeneralStrings.postalCode(context),
                          prefix: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(IconsManager.postcode ),
                          ),
                          onFieldSubmitted: (p0) => toNextField,
                          validator: (p0) => validator(p0),
                          context: context,
                        ),
                      ),
                      SizedBox(height: SizeManager.d14,),
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i600,
                        child: textFormField(
                          controller: _modelView.city,
                          labelText: GeneralStrings.city(context),
                          prefix: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Icon(IconsManager.city ),
                          ),
                          onFieldSubmitted: (p0) => toNextField,
                          validator: (p0) => validator(p0),
                          context: context,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  _onDateIconPressed() {
    return showBottomSheet(
      backgroundColor: Colors.white,
      enableDrag: false,
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height / 3,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              GestureDetector(
                onTap: (){
                  setState(() {
                    _modelView.dateOfBirth.text = '${_modelView.selectedDay}/${_modelView.selectedMonth}/${_modelView.selectedYear}';
                    Navigator.pop(context);

                  });
                  if (kDebugMode) {
                    print("month${_modelView.selectedMonth}");
                    print("year${_modelView.selectedYear}");
                    print("dau${_modelView.selectedDay}");
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Align(alignment: Alignment.topRight , child: Text('Done' , style: TextStyleManager.titleStyle(context)?.copyWith(color: Colors.blue),)),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width/8),
                  _buildSelectorWheel(
                    values: _modelView.days,
                    selectedValue: _modelView.selectedDay,
                    onValueChanged: (value) {
                      setState(() {
                        _modelView.selectedDay = value;
                      });
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/8),
                  _buildSelectorWheel(
                    values: _modelView.months,
                    selectedValue: _modelView.selectedMonth,
                    onValueChanged: (value) {
                      setState(() {
                        _modelView.selectedMonth = value;
                      });
                    },
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width/8),
                  _buildSelectorWheel(
                    values: _modelView.years,
                    selectedValue: _modelView.selectedYear,
                    onValueChanged: (value) {
                      setState(() {
                        _modelView.selectedYear = value;
                      });
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  _buildSelectorWheel({
    required List<int> values,
    required int selectedValue,
    required Function(int) onValueChanged,
  }) {
    return Theme(
        // Overriding the colors of the selector wheel
        data: ThemeData(
        colorScheme: Theme.of(context).colorScheme.copyWith(
      surface: Colors.white,
      onSurface: Colors.black,
      secondaryContainer: Colors.purple,
    ),
    ),
    child: SizedBox(
    width: MediaQuery.of(context).size.width/6,
    height: 180.0,
    child: SelectorWheel(
    childCount: values.length,
    childHeight: 48.0,
    highlightBorderRadius: BorderRadius.circular(32.0),
    highlightHeight: 48.0,
    highlightWidth: 100.0,
    fadeOutHeightFraction: 0.33,
        convertIndexToValue: (int index) {
          return SelectorWheelValue(
            label: values[index].toString(),
            value: values[index],
            index: index,
          );
        },

      selectedItemIndex: selectedValue,
        onValueChanged: (value) {
          onValueChanged(value.value);
        },
      ),
    ),);
  }
}
