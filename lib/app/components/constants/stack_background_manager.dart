import 'package:flutter/material.dart';

import 'color_manager.dart';

Widget stackBackGroundManager(
        {List<Widget>? otherWidget, required bool isDark}) =>
    Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: isDark
                    ? [
                  Colors.black.withValues(alpha: 0.96,),
                        ColorManager.green1,
                        ColorManager.green2,
                        ColorManager.green3,
                        ColorManager.green4,
                      ]
                    : [ColorManager.green5, Colors.white]),
          ),
        ),
        ...otherWidget ??
            [
              SizedBox(),
            ]
      ],
    );
