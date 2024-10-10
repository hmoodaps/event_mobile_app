import 'dart:math';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import '../../components/constants/size_manager.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({super.key});

  @override
  State<MainRoute> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  final List<int> apiData = List.generate(20, (index) => index);
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    // خلط البيانات بشكل عشوائي

    return Scaffold(
      appBar: AppBar(title: Text('Random Size Grid Example')),
      body: Column(children: [
      //  CarouselSlider(carouselController: ,items: [], options: CarouselOptions(), ),
      ],),
      // GridView.builder(
      //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      //     crossAxisCount: 2, // عدد الأعمدة
      //     childAspectRatio: 1, // نسبة العرض إلى الارتفاع
      //   ),
      //   itemCount: apiData.length,
      //   itemBuilder: (context, index) {
      //     // تحديد قياسات عشوائية للمربع
      //     double width = random.nextDouble() * 100 + 50; // عرض بين 50 و150
      //     double height = random.nextDouble() * 100 + 50; // ارتفاع بين 50 و150
      //
      //     return Container(
      //       width: width,
      //       height: height,
      //       margin: EdgeInsets.all(8.0),
      //       color: Colors.blue,
      //       child: Center(
      //         child: Text(
      //           '${apiData[index]}',
      //           style: TextStyle(color: Colors.white, fontSize: 24),
      //         ),
      //       ),
      //     );
      //   },
      // ),
    );
  }

}

