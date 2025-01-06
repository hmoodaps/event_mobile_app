// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
// import 'package:event_mobile_app/app/components/constants/color_manager.dart';
// import 'package:event_mobile_app/app/components/constants/font_manager.dart';
// import 'package:event_mobile_app/app/components/constants/general_strings.dart';
// import 'package:event_mobile_app/app/components/constants/getSize/getSize.dart';
// import 'package:event_mobile_app/app/components/constants/size_manager.dart';
// import 'package:event_mobile_app/data/models/movie_model.dart';
// import 'package:event_mobile_app/domain/local_models/models.dart';
// import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
//
// import '../../../app/components/constants/stack_background_manager.dart';
// import '../../../app/components/constants/variables_manager.dart';
// import '../../bloc_state_managment/states.dart';
// import 'cart_model_view.dart';
//
// class CartRoute extends StatefulWidget {
//   const CartRoute({super.key});
//
//   @override
//   State<CartRoute> createState() => _CartRouteState();
// }
//
// class _CartRouteState extends State<CartRoute> {
//   late CartModelView _model;
//
//   @override
//   void initState() {
//     super.initState();
//     _model = CartModelView(context);
//     _model.start();
//   }
//
//   @override
//   void dispose() {
//     _model.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<EventsBloc, AppStates>(
//       builder: (context, state) =>
//           _buildScaffold(isDark: VariablesManager.isDark, state: state),
//     );
//   }
//
//   Widget _buildScaffold({required bool isDark, required AppStates state}) =>
//       Scaffold(
//         body: stackBackGroundManager(
//             isDark: isDark, otherWidget: _screenWidgets(state)),
//         appBar: AppBar(
//           title: Text(
//             GeneralStrings.cart(context),
//             style: TextStyleManager.header(context),
//           ),
//         ),
//       );
//
//   List<Widget> _screenWidgets(AppStates state) => [
//         SafeArea(
//           child: pageBuilder(state),
//         ),
//       ];
//
//   Widget pageBuilder(AppStates state) {
//     return ConditionalBuilder(
//       builder: (context) {
//         return AnimationLimiter(
//           child: ListView.separated(
//             itemBuilder: (context, index) {
//               return AnimationConfiguration.staggeredGrid(
//                 position: index,
//                 duration: const Duration(milliseconds: 1000),
//                 columnCount: SizeManager.i2,
//                 child: ScaleAnimation(
//                   child: FadeInAnimation(
//                     child: RepaintBoundary(
//                       child: cartItem(VariablesManager.cartMovies[index]),
//                     ),
//                   ),
//                 ),
//               );
//             },
//             itemCount: VariablesManager.cartMovies.length,
//             separatorBuilder: (context, index) => SizedBox(
//               height: GetSize.heightValue(SizeManager.d10, context),
//             ),
//             reverse: true,
//             shrinkWrap: true,
//             padding: EdgeInsets.all(20),
//           ),
//         );
//       },
//       condition: VariablesManager.cartMovies.isNotEmpty,
//       fallback: (context) {
//         if (VariablesManager.currentUserRespon.cart!.isEmpty) {
//           return Center(child: Text(GeneralStrings.noCartItems(context)));
//         } else {
//           return Center(child: CircularProgressIndicator());
//         }
//       },
//     );
//   }
//
//   Widget cartItem(MovieResponse movie) {
//     return GestureDetector(
//       onTap: () {
//         _model.onItemPressed(movie);
//       },
//       child: Card(
//         color: ColorManager.primary,
//         elevation: 0.9,
//         shadowColor: Colors.white,
//         child: Container(
//           padding: EdgeInsets.all(SizeManager.d8),
//           height: SizeManager.screenSize(context).height / 7,
//           decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.start,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               CachedNetworkImage(
//                 imageUrl: movie.photo!,
//                 fit: BoxFit.cover,
//                 errorWidget: (context, url, error) => Icon(Icons.error),
//                 imageBuilder: (context, imageProvider) {
//                   return Container(
//                     height: SizeManager.screenSize(context).height / 7.5,
//                     width: GetSize.widthValue(SizeManager.d100, context),
//                     decoration: BoxDecoration(
//                       image: DecorationImage(
//                         image: imageProvider,
//                         fit: BoxFit.cover,
//                       ),
//                       borderRadius: BorderRadius.circular(SizeManager.d20),
//                     ),
//                   );
//                 },
//               ),
//               SizedBox(
//                 width: GetSize.widthValue(SizeManager.d10, context),
//               ),
//               Expanded(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         Text(
//                           movie.name!.length >= 17
//                               ? "${movie.name!.substring(0, 18)}..."
//                               : movie.name!,
//                           softWrap: true,
//                           overflow: TextOverflow.ellipsis,
//                           style:
//                               TextStyleManager.titleStyle(context)?.copyWith(),
//                         ),
//                         Spacer(),
//                         Align(
//                             alignment: Alignment.topRight,
//                             child: favoriteIcon(
//                                 context,
//                                 movie,
//                                 _model.addFilmToFavEvent,
//                                 _model.removeFilmFromFavEvent)),
//                       ],
//                     ),
//                     SizedBox(
//                       height: GetSize.heightValue(SizeManager.d10, context),
//                     ),
//                     SizedBox(
//                         height: GetSize.heightValue(SizeManager.d15, context),
//                         width: GetSize.widthValue(SizeManager.d200, context),
//                         child: featuresSlider(movie, context)),
//                     Spacer(),
//                     Align(
//                         alignment: Alignment.bottomRight,
//                         child: Row(
//                           children: [
//                             cartIcon(context, movie, _model.addFilmToCartEvent,
//                                 _model.removeFilmFromCartEvent),
//                             Spacer(),
//                             Text(
//                               "${movie.ticketPrice!.toString()} €",
//                               style: TextStyleManager.header(context)
//                                   ?.copyWith(color: ColorManager.green3),
//                             ),
//                           ],
//                         )),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
