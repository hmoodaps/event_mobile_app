import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../app/components/constants/color_manager.dart';
import '../../app/components/constants/font_manager.dart';
import '../../app/components/constants/general_strings.dart';
import '../../app/components/constants/getSize/getSize.dart';
import '../../app/components/constants/icons_manager.dart';
import '../../app/components/constants/route_strings_manager.dart';
import '../../app/components/constants/routs_manager.dart';
import '../../app/components/constants/size_manager.dart';
import '../../app/components/constants/variables_manager.dart';
import '../../data/models/movie_model.dart';

class CreateUserRequirements {
  String? dateOfBirth;
  String? mobileNumber;
  String? street;
  String? houseNumber;
  String? additionalInfo;
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
    this.additionalInfo,
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
      'additionalInfo': additionalInfo,
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
      additionalInfo: map['additionalInfo'],
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

bool isItemInFaves({required int filmId}) {
  if (SharedPref.prefs.getString(GeneralStrings.currentUser) != null) {
    return VariablesManager.currentUserRespon.favorites?.contains(filmId) ??
        false;
  } else {
    return SharedPref.prefs
        .getStringList(GeneralStrings.listFaves)!
        .map((item) => int.tryParse(item))
        .where((id) => id != null)
        .contains(filmId);
  }
}

// bool isItemInCart({required int filmId}) {
//   return VariablesManager.currentUserRespon.cart?.contains(filmId) ?? false;
// }

Widget featuresSlider(MovieResponse movie, BuildContext context) {
  List<Widget> features = [];

  Widget buildTextWithVariable(
      String label, dynamic value, String suffixLabel) {
    return Row(
      children: [
        Text(
          label,
          overflow: TextOverflow.ellipsis,
          style: TextStyleManager.smallParagraphStyle(context),
        ),
        Text(
          ' $value',
          overflow: TextOverflow.ellipsis,
          style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
            color: VariablesManager.isDark
                ? Colors.white
                : ColorManager.primarySecond,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          ' $suffixLabel',
          overflow: TextOverflow.ellipsis,
          style: TextStyleManager.smallParagraphStyle(context),
        ),
      ],
    );
  }

  double oldTicketPrice = movie.ticketPrice! * 2.4;

  features.add(
    Row(
      children: [
        Text(
          GeneralStrings.lowPrice(context),
          overflow: TextOverflow.ellipsis,
          style: TextStyleManager.smallParagraphStyle(context),
        ),
        Text(
          ' ${oldTicketPrice.toStringAsFixed(2)}',
          overflow: TextOverflow.ellipsis,
          style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
            decoration: TextDecoration.lineThrough,
            color: Colors.grey,
          ),
        ),
        Text(
          ' ${movie.ticketPrice}',
          overflow: TextOverflow.ellipsis,
          style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
            color: VariablesManager.isDark
                ? Colors.white
                : ColorManager.primarySecond,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
  for (var movieTag in movie.tags!) {
    features
        .add(buildTextWithVariable(movieTag.toString().toUpperCase(), '', ''));
  }
  features.add(buildTextWithVariable(
      GeneralStrings.heightIMDBRate(context), movie.imdbRating, ''));
  features.add(buildTextWithVariable(
      '', movie.availableSeats, GeneralStrings.seatsAvailable(context)));
  features.add(
      buildTextWithVariable('', movie.seats, GeneralStrings.seats(context)));

  if (movie.availableSeats == movie.seats) {
    features.add(
      Text(
        GeneralStrings.beTheFirstOne(context),
        overflow: TextOverflow.ellipsis,
        style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.blue,
        ),
      ),
    );
  } else if (movie.availableSeats == 1) {
    features.add(
      Text(
        GeneralStrings.lastTicketAvailable(context),
        overflow: TextOverflow.ellipsis,
        style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
          fontStyle: FontStyle.italic,
          color: Colors.red,
        ),
      ),
    );
  } else if (movie.availableSeats! <= 5) {
    features.add(
      Row(
        children: [
          Text(
            GeneralStrings.hurry(context),
            overflow: TextOverflow.ellipsis,
            style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.orange,
            ),
          ),
          Text(
            " ${movie.availableSeats}",
            overflow: TextOverflow.ellipsis,
            style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.blue,
            ),
          ),
          Text(
            " ${GeneralStrings.ticketsLeft(context)}",
            overflow: TextOverflow.ellipsis,
            style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.orange,
            ),
          ),
        ],
      ),
    );
  }

  return CarouselSlider(
    items: features,
    options: CarouselOptions(
      autoPlay: true,
      scrollDirection: Axis.vertical,
      height: GetSize.heightValue(SizeManager.d14, context),
      padEnds: true,
      viewportFraction: 1.0,
    ),
  );
}

class NotificationDialog extends StatelessWidget {
  final String title;
  final String message;
  final String button1Text;
  final VoidCallback button1Action;
  final String button2Text;
  final VoidCallback button2Action;
  final String button3Text;
  final VoidCallback button3Action;

  const NotificationDialog({
    super.key,
    required this.title,
    required this.message,
    required this.button1Text,
    required this.button1Action,
    required this.button2Text,
    required this.button2Action,
    required this.button3Text,
    required this.button3Action,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: button1Action,
          child: Text(button1Text),
        ),
        TextButton(
          onPressed: button2Action,
          child: Text(button2Text),
        ),
        TextButton(
          onPressed: button3Action,
          child: Text(button3Text),
        ),
      ],
    );
  }
}

// Widget cartIcon(
//     BuildContext context,
//     MovieResponse movie,
//     void Function(MovieResponse) addToCart,
//     void Function(MovieResponse) removeFromCart) {
//   return CircleAvatar(
//     radius: 15,
//     backgroundColor: isItemInCart(filmId: movie.id!)
//         ? Colors.green
//         : ColorManager.privateGrey,
//     child: Align(
//       alignment: Alignment.center,
//       child: IconButton(
//         onPressed: () {
//           if (FirebaseAuth.instance.currentUser?.uid == null) {
//             showDialog(
//                 context: context,
//                 builder: (context) => NotificationDialog(
//                     title: GeneralStrings.urNotLogin(context),
//                     message: GeneralStrings.uCantAddItemToCart(context),
//                     button1Action: () {
//                       navigateTo(context, RouteStringsManager.loginRoute);
//                     },
//                     button1Text: GeneralStrings.login(
//                       context,
//                     ),
//                     button2Action: () {
//                       navigateTo(context, RouteStringsManager.registerRoute);
//                     },
//                     button2Text: GeneralStrings.register(context),
//                     button3Action: () {
//                       Navigator.pop(context);
//                     },
//                     button3Text: GeneralStrings.cancel(context)));
//           } else {
//             if (!isItemInCart(filmId: movie.id!)) {
//               addToCart(movie);
//             } else {
//               removeFromCart(movie);
//             }
//           }
//         },
//         icon: Icon(
//           IconsManager.cart,
//           size: 20,
//           color: isItemInCart(filmId: movie.id!) ? Colors.red : Colors.black,
//         ),
//         padding: EdgeInsets.zero,
//       ),
//     ),
//   );
// }

Widget favoriteIcon(
    BuildContext context,
    MovieResponse movie,
    void Function(MovieResponse) addToCart,
    void Function(MovieResponse) removeFromCart) {
  return CircleAvatar(
    radius: 15,
    backgroundColor: isItemInFaves(filmId: movie.id!)
        ? Colors.green
        : ColorManager.privateGrey,
    child: Align(
      alignment: Alignment.center,
      child: IconButton(
        onPressed: () {
          if (!isItemInFaves(filmId: movie.id!)) {
            addToCart(movie);
          } else {
            removeFromCart(movie);
          }
        },
        icon: Icon(
          IconsManager.favorite,
          size: 20,
          color: isItemInFaves(filmId: movie.id!) ? Colors.red : Colors.black,
        ),
        padding: EdgeInsets.zero,
      ),
    ),
  );
}

class GradientLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..shader = LinearGradient(
        colors: [
          Colors.black,
          Colors.white70,
          ColorManager.green3,
          Colors.white70,
          Colors.black
        ],
        stops: [0.0, 0.15, 0.5, 0.90, 1.0],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..style = PaintingStyle.fill;

    Path path = Path();

    // رسم خط مدبب من الجانبين
    path.moveTo(0, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, -size.height / 2, size.width, size.height / 2);
    path.lineTo(size.width, size.height / 2);
    path.quadraticBezierTo(
        size.width / 2, size.height * 1.5, 0, size.height / 2);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
// Future<Color> extractDominantColorIsolate(String imageUrl) async {
//   return await compute(_processImageForDominantColor, imageUrl);
// }
//
// Future<Color> _processImageForDominantColor(String imageUrl) {
//   final imageProvider = CachedNetworkImageProvider(imageUrl);
//   final Completer<Color> completer = Completer();
//
//   final ImageStream imageStream = imageProvider.resolve(const ImageConfiguration());
//   imageStream.addListener(
//     ImageStreamListener(
//           (ImageInfo info, bool _) async {
//         final imageSize = Size(
//           info.image.width.toDouble(),
//           info.image.height.toDouble(),
//         );
//
//         final double regionTop = imageSize.height * 0.65;
//         final double regionBottom = imageSize.height * 0.7;
//
//         final region = Rect.fromLTRB(
//           0,
//           regionTop.clamp(0, imageSize.height),
//           imageSize.width,
//           regionBottom.clamp(0, imageSize.height),
//         );
//
//         final paletteGenerator = await PaletteGenerator.fromImage(
//           info.image,
//           region: region, // استخدم فقط المعاملات المتوفرة.
//         );
//
//         final dominantColor = paletteGenerator.dominantColor?.color ?? Colors.black;
//         completer.complete(dominantColor);
//       },
//     ),
//   );
//
//   return completer.future;
// }

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
//                   flutter pub add dev:testheight: _isExpanded
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
    selectedIndex =
        (widget.items.length / 2).round(); // العنصر الافتراضي في المنتصف.
  }

  Widget _buildArcItem(int index) {
    final double offset = (index - selectedIndex).toDouble();
    final double top =
        widget.height / 2 - (90 * (1 - offset.abs())); // تحديد الموقع الرأسي.

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
          height: offset.abs() == 0
              ? GetSize.heightValue(SizeManager.d80, context)
              : GetSize.heightValue(SizeManager.d60, context),
          decoration: BoxDecoration(
            color: offset.abs() == 0
                ? widget.selectedItemColor
                : widget.unselectedItemColor,
            borderRadius: BorderRadius.circular(10),
            border: offset.abs() == 0
                ? Border.all(
                    color: Colors.white,
                    width: GetSize.widthValue(SizeManager.d3, context))
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
      height: GetSize.heightValue(widget.height, context),
      child: Stack(
        alignment: Alignment.center,
        children: [
          for (int i = 0; i < widget.items.length; i++) _buildArcItem(i),
        ],
      ),
    );
  }
}
