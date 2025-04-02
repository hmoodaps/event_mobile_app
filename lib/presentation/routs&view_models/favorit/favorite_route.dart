import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/routs&view_models/more_detail_route/more_detail_view.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import '../../bloc_state_managment/states.dart';
import 'favorit_model_view.dart';

class FavoriteRoute extends StatefulWidget {
  const FavoriteRoute({super.key});

  @override
  State<FavoriteRoute> createState() => _FavoriteRouteState();
}

class _FavoriteRouteState extends State<FavoriteRoute> {
  late final FavoriteModelView _model;

  @override
  void initState() {
    super.initState();
    _model = FavoriteModelView(context);
    _model.start();
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) =>
          _buildScaffold(isDark: VariablesManager.isDark, state: state),
    );
  }

  Widget _buildScaffold({required bool isDark, required AppStates state}) =>
      Scaffold(
        body: stackBackGroundManager(
            isDark: isDark, otherWidget: _screenWidgets(state)),
        appBar: AppBar(
          title: Text(
            GeneralStrings.favorites(context),
            style: TextStyleManager.header(context),
          ),
        ),
      );

  List<Widget> _screenWidgets(AppStates state) => [
        SafeArea(
          child: ConditionalBuilder(
            builder: (context) {
              return AnimationLimiter(
                child: ListView.separated(
                  itemBuilder: (context, index) {
                    if (kDebugMode) {
                      print(VariablesManager.favesMovies[index].id);
                    }
                    return AnimationConfiguration.staggeredGrid(
                      position: index,
                      duration: const Duration(milliseconds: 1000),
                      columnCount: SizeManager.i2,
                      child: ScaleAnimation(
                        child: FadeInAnimation(
                          child: RepaintBoundary(
                            child: favoriteItem(
                                VariablesManager.favesMovies[index]),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: VariablesManager.favesMovies.length,
                  separatorBuilder: (context, index) => SizedBox(
                    height: GetSize.heightValue(SizeManager.d10, context),
                  ),
                  reverse: true,
                  shrinkWrap: true,
                  padding: EdgeInsets.all(20),
                ),
              );
            },
            condition: VariablesManager.favesMovies.isNotEmpty,
            fallback: (context) {
              if (SharedPref.prefs.getString(GeneralStrings.currentUser) ==
                  null) {
                List<String> prefFav =
                    SharedPref.prefs.getStringList(GeneralStrings.listFaves)!;
                if (prefFav.isEmpty) {
                  return Center(
                    child: Text(
                      GeneralStrings.noFaveItems(context),
                      style: TextStyleManager.titleStyle(context),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              } else {
                if (VariablesManager.currentUserResponse.favorites!.isEmpty) {
                  return Center(
                    child: Text(
                      GeneralStrings.noFaveItems(context),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
            },
          ),
        ),
      ];

  Widget favoriteItem(MovieResponse movie) {
    return GestureDetector(
      onTap: () {
        _model.onItemPressed(movie);
      },
      child: Card(
        color: ColorManager.primary,
        elevation: 0.9,
        shadowColor: Colors.white,
        child: Container(
          padding: EdgeInsets.all(SizeManager.d8),
          height: SizeManager.screenSize(context).height / 7,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CachedNetworkImage(
                imageUrl: movie.photo!,
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Icon(Icons.error),
                imageBuilder: (context, imageProvider) {
                  return Container(
                    height: SizeManager.screenSize(context).height / 7.5,
                    width: GetSize.widthValue(SizeManager.d100, context),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(SizeManager.d20),
                    ),
                  );
                },
              ),
              SizedBox(
                width: GetSize.widthValue(SizeManager.d10, context),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            movie.name!,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyleManager.titleStyle(context)
                                ?.copyWith(),
                          ),
                        ),
                        Spacer(),
                        Align(
                            alignment: Alignment.topRight,
                            child: favoriteIcon(
                                context,
                                movie,
                                _model.addFilmToFavEvent,
                                _model.removeFilmFromFavEvent)),
                      ],
                    ),
                    SizedBox(
                      height: GetSize.heightValue(SizeManager.d10, context),
                    ),
                    SizedBox(
                        height: GetSize.heightValue(SizeManager.d15, context),
                        width: GetSize.widthValue(SizeManager.d200, context),
                        child: featuresSlider(movie, context)),
                    Spacer(),
                    Align(
                        alignment: Alignment.bottomRight,
                        child: Row(
                          children: [
                            // cartIcon(context, movie, _model.addFilmToCartEvent,
                            //     _model.removeFilmFromCartEvent),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MoreDetailView(movie: movie),
                                    ));
                              },
                              child: CircleAvatar(
                                radius: 18,
                                child: Icon(IconsManager.cart),
                              ),
                            ),
                            Spacer(),
                            Text(
                              "${_model.getMinPrice(movie)} €",
                              style: TextStyleManager.header(context)
                                  ?.copyWith(color: ColorManager.green3),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
