import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:selector_wheel/selector_wheel/models/selector_wheel_value.dart';
import 'package:selector_wheel/selector_wheel/selector_wheel.dart';

import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/states.dart';

class FavoriteRoute extends StatefulWidget {
  const FavoriteRoute({super.key});

  @override
  State<FavoriteRoute> createState() => _FavoriteRouteState();
}

class _FavoriteRouteState extends State<FavoriteRoute> {
  final List<int> days = List.generate(31, (index) => index + 1);  // 1 to 31
  final List<int> months = List.generate(12, (index) => index + 1); // 1 to 12
  final List<int> years = List.generate(DateTime.now().year - 1930 - 16, (index) => 1930 + index);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
      builder: (context, state) => _buildScaffold(isDark: VariablesManager.isDark),
      listener: (context, state) {},
    );
  }

  Widget _buildScaffold({required bool isDark}) => Scaffold(
    body: stackBackGroundManager(isDark: isDark, otherWidget: _screenWidgets()),
  );

  List<Widget> _screenWidgets() => [
    Center(
      child: IconButton(
        onPressed: () {
          showBottomSheet(
            context: context,
            backgroundColor: Colors.green,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height / 2.7,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(alignment: Alignment.topRight, child: Text('Done' , style: TextStyleManager.bodyStyle(context)?.copyWith(color: Colors.blue),),),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // عجلة اختيار الأيام
                          Container(
                            color : Colors.green,
                            child: SelectorWheel(
                              childCount: days.length,
                              highlightHeight: 40.0,
                              highlightWidth: 60.0,
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: days[index].toString(),
                                  value: days[index],
                                  index: index,
                                );
                              },
                              onValueChanged: (value) {
                                print("Selected Day: ${value.value}");
                              },
                            ),
                          ),
                          // عجلة اختيار الأشهر
                          Container(
                            color : Colors.green,

                            child: SelectorWheel(
                              childCount: months.length,
                              highlightHeight: 40.0,
                              highlightWidth: 60.0,
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: months[index].toString(),
                                  value: months[index],
                                  index: index,
                                );
                              },
                              onValueChanged: (value) {
                                print("Selected Month: ${value.value}");
                              },
                            ),
                          ),
                          // عجلة اختيار السنوات
                          Container(
                            color : Colors.green,
                            child: SelectorWheel(
                              childCount: years.length,
                              highlightHeight: 40.0,
                              highlightWidth: 80.0,
                              convertIndexToValue: (int index) {
                                return SelectorWheelValue(
                                  label: years[index].toString(),
                                  value: years[index],
                                  index: index,
                                );
                              },
                              onValueChanged: (value) {
                                print("Selected Year: ${value.value}");
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        icon: Icon(IconsManager.calender),
      ),
    ),
  ];
}
