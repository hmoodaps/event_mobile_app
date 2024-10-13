import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';

import 'color_manager.dart';

Widget stackBackGroundManager({List<Widget> ? otherWidget}) =>
    Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors:VariablesManager.isDark ?  [
                    Colors.black.withOpacity(0.96),
                    ColorManager.green1,
                    ColorManager.green2,
                    ColorManager.green3,
                    ColorManager.green4,
                  ] :[
                    ColorManager.privateGrey,
                    ColorManager.primary
                  ]
              ),
          ),
        ),...otherWidget??[SizedBox(),]
      ],
    );