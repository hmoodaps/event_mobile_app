import 'package:flutter/material.dart';

import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/route_strings_manager.dart';

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
      context,
      RouteStringsManager.mainRoute,
          (Route<dynamic> route) => false);
}

bool toNextField(BuildContext context) {
  return FocusScope.of(context).nextFocus();
}

validator(String? value) {
  if (value == null || value.isEmpty) {
    return GeneralStrings.fieldRequired;
  }
  return null;
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
//   //   EventsBloc bloc = instance();
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
