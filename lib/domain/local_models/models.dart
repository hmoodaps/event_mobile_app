import 'dart:math';

import 'package:flutter/material.dart';

import '../../app/components/constants/color_manager.dart';
import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/route_strings_manager.dart';
import '../../app/components/constants/variables_manager.dart';

class CreateUserRequirements {
  String? dateOfBirth;
  String? mobileNumber;
  String? street;
  String? houseNumber;
  String? additinalInfo;
  String? postalCode;
  String? city;
  String? password;
  String? email;
  String? fullName;

  CreateUserRequirements({
    this.password,
    this.email,
    this.fullName,
    this.dateOfBirth,
    this.mobileNumber,
    this.street,
    this.houseNumber,
    this.additinalInfo,
    this.postalCode,
    this.city,
  });

  // دالة لتحويل الكائن إلى Map
  Map<String, dynamic> toMap() {
    return {
      'dateOfBirth': dateOfBirth,
      'mobileNumber': mobileNumber,
      'street': street,
      'houseNumber': houseNumber,
      'additinalInfo': additinalInfo,
      'postalCode': postalCode,
      'city': city,
      'password': password,
      'email': email,
      'fullName': fullName,
    };
  }

  // دالة لتحويل Map إلى CreateUserRequirements
  factory CreateUserRequirements.fromMap(Map<String, dynamic> map) {
    return CreateUserRequirements(
      dateOfBirth: map['dateOfBirth'],
      mobileNumber: map['mobileNumber'],
      street: map['street'],
      houseNumber: map['houseNumber'],
      additinalInfo: map['additinalInfo'],
      postalCode: map['postalCode'],
      city: map['city'],
      password: map['password'],
      email: map['email'],
      fullName: map['fullName'],
    );
  }
}

navigateToMainRoute(context) {
  Navigator.pushNamedAndRemoveUntil(
      context, RouteStringsManager.mainRoute, (Route<dynamic> route) => false);
}

bool toNextField(BuildContext context) {
  return FocusScope.of(context).nextFocus();
}

validator(String? value, BuildContext context) {
  if (value == null || value.isEmpty) {
    return GeneralStrings.fieldRequired(context);
  }
  return null;
}

// Widget for ListTile Card
class CustomListTileCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final VoidCallback onTap;
  final Widget? suffix;

  const CustomListTileCard(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.onTap,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shadowColor: VariablesManager.isDark ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.lightBlue,
          ),
          child: ListTile(
            dense: true,
            leading: Icon(leadingIcon, color: Colors.orange),
            title: Text(title),
            onTap: onTap,
            trailing: suffix,
          ),
        ),
      ),
    );
  }
}

// Widget for Expandable Card
class CustomExpandableCard extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final List<Widget> children;
  final Widget? suffix;

  const CustomExpandableCard(
      {super.key,
      required this.leadingIcon,
      required this.title,
      required this.children,
      this.suffix});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 9,
      shadowColor: VariablesManager.isDark ? Colors.white : Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          decoration: BoxDecoration(
            color: ColorManager.lightBlue,
          ),
          child: ExpansionTile(
            dense: true,
            collapsedBackgroundColor: ColorManager.lightBlue,
            childrenPadding: const EdgeInsets.symmetric(horizontal: 40),
            leading: Icon(leadingIcon, color: Colors.orange),
            title: Text(title),
            backgroundColor: ColorManager.privateWhite,
            trailing: suffix,
            children: children,
          ),
        ),
      ),
    );
  }
}

//movie show models
// class MovieCard extends StatefulWidget {
//   final String titleStyle;
//   final String description;
//   final String imageUrl;
//
//   const MovieCard({
//     super.key,
//     required this.titleStyle,
//     required this.description,
//     required this.imageUrl,
//   });
//
//   @override
//   MovieCardState createState() => MovieCardState();
// }
//
// class MovieCardState extends State<MovieCard>
//     with SingleTickerProviderStateMixin {
//   bool _isExpanded = false;
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: GestureDetector(
//         onVerticalDragUpdate: (details) {
//           setState(() {
//             _isExpanded = true;
//           });
//         },
//         child: Stack(
//           children: [
//             StaggeredAnimatedWidget(
//               delay: 200,
//               child: Positioned.fill(
//                 child: SizedBox(
//                   width: double.infinity, // لضمان عرض كامل
//                   height: double.infinity, // لضمان طول كامل
//                   child: Image.asset(
//                     'assets/lion.png',
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: StaggeredAnimatedWidget(
//                 delay: 500,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 500),
//                   height: _isExpanded
//                       ? MediaQuery.of(context).size.height * 0.75
//                       : MediaQuery.of(context).size.height * 0.45,
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                       colors: [
//                         Colors.white.withOpacity(0.009),
//                         Colors.white.withOpacity(0.4),
//                         Colors.white.withOpacity(0.8),
//                         Colors.white,
//                       ],
//                     ),
//                   ),
//                   child: Align(
//                     alignment: Alignment.bottomRight,
//                     child: SingleChildScrollView(
//                       child: Column(
//                         children: [
//                           StaggeredAnimatedWidget(
//                             delay: 750,
//                             child: Padding(
//                               padding: _isExpanded
//                                   ? const EdgeInsets.only(
//                                       bottom: 32, left: 32, right: 32, top: 60)
//                                   : const EdgeInsets.only(
//                                       right: 32, left: 32, bottom: 16, top: 50),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                     children: [
//                                       Text(
//                                         widget.titleStyle,
//                                         maxLines: _isExpanded ? null : 1,
//                                         overflow: _isExpanded
//                                             ? null
//                                             : TextOverflow.ellipsis,
//                                         style: const TextStyle(
//                                           fontSize: 26,
//                                           fontWeight: FontWeight.w900,
//                                           color: Colors.black,
//                                         ),
//                                       ),
//                                       _isExpanded
//                                           ? GestureDetector(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _isExpanded = false;
//                                                 });
//                                               },
//                                               child: const CircleAvatar(
//                                                 radius: 12,
//                                                 backgroundColor: Colors.red,
//                                                 child: Icon(
//                                                   Icons.minimize,
//                                                   color: Colors.black,
//                                                   size: 16,
//                                                 ),
//                                               ),
//                                             )
//                                           : const SizedBox(),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 4),
//                                   Text(
//                                     widget.description,
//                                     maxLines: _isExpanded ? null : 2,
//                                     style: const TextStyle(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 16,
//                                         color: Colors.black),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           StaggeredAnimatedWidget(
//                             delay: 1000,
//                             child: MaterialButton(
//                               onPressed: () {},
//                               child: Container(
//                                 height: 50,
//                                 width: double.infinity,
//                                 decoration: BoxDecoration(
//                                   color: Colors.transparent,
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 child: const Center(child: Text('Book')),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

//   // @override
//   // Widget build(BuildContext context) {
//   //   EventsBloc bloc = EventsBloc.get(context);
//   //
//   //   return BlocConsumer<EventsBloc, AppStates>(builder: (context, state) =>
//   //       getScaffold(isDark: VariablesManager.isDark),
//   //       listener: (context, state) {});
//   // }
//   //
//   // Widget getScaffold({ required bool isDark}) =>
//   //     Scaffold(
//   //       body: stackBackGroundManager(isDark: isDark),
//   //     );
//
//
// late YoutubePlayerController _controller;
//
// // Future<void> fetchActorData(String actorName) async {
// //   final encodedName = Uri.encodeComponent(actorName);
// //   final String url =
// //       'https://en.wikipedia.org/w/api.php?action=query&format=json&titleStyles=$encodedName&prop=extracts|pageimages&exintro=true&explaintext=true&piprop=original';
// //
// //   try {
// //     final response = await http.get(Uri.parse(url));
// //
// //     if (response.statusCode == 200) {
// //       final Map<String, dynamic> data = json.decode(response.body);
// //       ActorModel actor = ActorModel.fromJson(data);
// //
// //       // طباعة التفاصيل
// //       print('Name: ${actor.fullName}');
// //       print('Description: ${actor.description}');
// //       print('Image URL: ${actor.profilePhoto}');
// //       print('Image URL: ${actor.sours}');
// //     } else {
// //       print('Failed to load data. Status code: ${response.statusCode}');
// //     }
// //   } catch (e) {
// //     print('Error: $e');
// //   }
// // }
//   Future<void> fetchMovies() async {
//     final String url = 'http://10.103.29.115:8000/movies/'; //// استخدم عنوان IP الخاص بالخادم
//     print(url);
//     try {
//       final response = await http.get(Uri.parse(url));
//
//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);
//         data.forEach((movie) {
//           print('Movie ID: ${movie['id']}, Name: ${movie['name']}');
//         });
//       } else {
//         print('Failed to load data. Status code: ${response.statusCode}');
//       }
//     } on SocketException catch (e) {
//       print('SocketException: $e');
//     } catch (e) {
//       print('Error: $e');
//     }
//   }
//
//
// @override
// void initState() {
//   super.initState();
//   String videoUrl = "https://www.youtube.com/watch?v=5cx7rvMvAWo";
//   String? videoId = YoutubePlayer.convertUrlToId(videoUrl);
//
//   _controller = YoutubePlayerController(
//     initialVideoId: videoId!,
//     flags: YoutubePlayerFlags(
//       showLiveFullscreenButton: false,
//
//       loop: false,
//       autoPlay: false,
//       mute: false,
//     ),
//   );
// }
//
// @override
// void dispose() {
//   _controller.dispose();
//   super.dispose();
// }
// Container(
//   width: double.infinity,
//   height: 300,
//   child: YoutubePlayer(
//     controller: _controller,
//     showVideoProgressIndicator: true,
//     progressIndicatorColor: Colors.amber,
//     progressColors: ProgressBarColors(
//       playedColor: Colors.amber,
//       handleColor: Colors.amberAccent,
//       backgroundColor: ColorManager.primary,
//       bufferedColor: ColorManager.primary,
//
//     ),
//   ),
// )
// otherWidget:[ Column(
//   children: [
//     // Container(
//     //   width: double.infinity,
//     //   height: 300,
//     //   child: YoutubePlayerBuilder(
//     //     player: YoutubePlayer(
//     //       controller: _controller,
//     //       showVideoProgressIndicator: true,
//     //       progressIndicatorColor: Colors.amber,
//     //       progressColors: ProgressBarColors(
//     //         playedColor: Colors.amber,
//     //         handleColor: Colors.amberAccent,
//     //         backgroundColor: ColorManager.primary,
//     //         bufferedColor: ColorManager.primary,
//     //       ),
//     //     ),
//     //     builder: (context, player) {
//     //       return Column(
//     //         children: [
//     //           player,
//     //           // يمكنك إضافة المزيد من العناصر هنا إذا كنت ترغب
//     //         ],
//     //       );
//     //     },
//     //   ),
//     // ),
//     // MaterialButton(onPressed: (){
//     //   //fetchActorData('Leonardo DiCaprio');
//     //   fetchMovies();},color: Colors.blue,height: 50,),
//   ],
// )],







class ArcItemSelector extends StatefulWidget {
  final List<Widget> items; // قائمة العناصر التي سيتم عرضها.
  final ValueChanged<int> onItemSelected; // دالة يتم استدعاؤها عند تحديد عنصر.
  final double height; // ارتفاع الويدجت.
  final double spacing; // المسافة بين العناصر.
  final Color selectedItemColor; // لون العنصر المحدد.
  final Color unselectedItemColor; // لون العناصر غير المحددة.


  const ArcItemSelector({
    super.key,
    required this.items,
    required this.onItemSelected,
    this.height = 300,
    this.spacing = 10,
    this.selectedItemColor = Colors.red,
    this.unselectedItemColor = Colors.grey,
  });

  @override
  _ArcItemSelectorState createState() => _ArcItemSelectorState();
}

class _ArcItemSelectorState extends State<ArcItemSelector> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = (widget.items.length / 2).round(); // العنصر الافتراضي في المنتصف.
  }

  Widget _buildArcItem(int index) {
    final double offset = (index - selectedIndex).toDouble();
    final double top = widget.height / 2 - (90 * (1 - offset.abs())); // تحديد الموقع الرأسي.

    // ضبط العنصر المختار ليكون في منتصف الشاشة.
    final double screenWidth = MediaQuery.of(context).size.width;
    final double elementWidth = offset.abs() == 0 ? 100 : 90; // عرض العنصر.
    final double left = (screenWidth / 2 - elementWidth / 2) +
        (offset * elementWidth) +
        (offset * widget.spacing); // تحديد الموقع الأفقي.

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      top: top,
      left: left,
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedIndex = index; // تغيير العنصر المحدد.
          });
          widget.onItemSelected(index); // استدعاء الدالة عند التحديد.
        },
        child: Container(
          width: elementWidth,
          height: offset.abs() == 0 ? 80 : 60,
          decoration: BoxDecoration(
            color: offset.abs() == 0
                ? widget.selectedItemColor
                : widget.unselectedItemColor,
            borderRadius: BorderRadius.circular(10),
            border: offset.abs() == 0
                ? Border.all(color: Colors.white, width: 3)
                : null,
          ),
          child: widget.items[index], // استخدام العنصر كودجت.
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < widget.items.length; i++) _buildArcItem(i),
        ],
      ),
    );
  }
}



