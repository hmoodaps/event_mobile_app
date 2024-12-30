import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mobile_app/app/components/constants/getSize/getSize.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/text_form_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../data/models/movie_model.dart';
import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';
import '../movie/movie_route.dart';
import 'movies_model_view.dart';

class MoviesRoute extends StatefulWidget {
  const MoviesRoute({super.key});

  @override
  State<MoviesRoute> createState() => _MoviesRouteState();
}

class _MoviesRouteState extends State<MoviesRoute> {
  late final MoviesModelView _model;

  @override
  void initState() {
    super.initState();
    _model = MoviesModelView(context);
    _model.start();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => _getScaffold(),
    );
  }

  Widget _getScaffold() => Scaffold(
        body: LiquidPullToRefresh(
          backgroundColor: ColorManager.primary,
          height: MediaQuery.sizeOf(context).height / 5,
          springAnimationDurationInMilliseconds: SizeManager.i1400,
          color: ColorManager.primarySecond,
          showChildOpacityTransition: true,
          onRefresh: () => _model.getMovies(),
          child: stackBackGroundManager(
              otherWidget: _screenWidgets(), isDark: VariablesManager.isDark),
        ),
      );

  List<Widget> _screenWidgets() => [
        Platform.isIOS
            ? NestedScrollView(
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  CupertinoSliverNavigationBar(
                    largeTitle: Text('Explore'),
                    backgroundColor: Colors.transparent,
                    border: null,
                    padding: EdgeInsetsDirectional.zero,
                    trailing: CupertinoButton(
                      onPressed: () {},
                      padding: EdgeInsets.all(0),
                      child: Icon(
                        IconsManager.search,
                        size: 24,
                        color: VariablesManager.isDark
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )
                ],
                body: screenBuilder(),
              )
            : screenBuilder(),
      ];

  Widget screenBuilder() {
    return LayoutBuilder(
      builder: (context, constraints) => Visibility(
        visible: VariablesManager.movies.isNotEmpty,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: GetSize.heightValue(SizeManager.d12, context),
              children: [
                Visibility(
                  visible: !Platform.isIOS,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(SizeManager.d18),
                      child: SizedBox(
                        width: double.infinity,
                        height: GetSize.heightValue(SizeManager.d50, context),
                        child: searchFormField(
                          context: context,
                          controller: _model.searchController,
                          suffix: Icon(
                            IconsManager.search,
                          ),
                          labelText: GeneralStrings.search(context),
                          filled: true,
                          fillColor: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeManager.d18),
                  child: Row(
                    children: [
                      Text(GeneralStrings.newMovies(context),
                          style: TextStyleManager.titleStyle(context)),
                      Spacer(),
                      Row(
                        children: [
                          Switch.adaptive(
                            value: _model.isAuto,
                            onChanged: (value) => setState(() {
                              _model.isAuto = value;
                              if (value) {
                                _model.startAutoPlay();
                              } else {
                                _model.stopAutoPlay();
                              }
                            }),
                          ),
                          Text("Auto Play",
                              style: TextStyleManager.titleStyle(context)),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 3.2,
                  child: CarouselView.weighted(
                    onTap: (index) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MovieRoute(
                            movie: VariablesManager.movies[index],
                          ),
                        ),
                      );
                    },
                    flexWeights: [10, 2, 1],
                    controller: _model.carouselController,
                    elevation: 6,
                    enableSplash: true,
                    shrinkExtent: 200,
                    itemSnapping: true,
                    backgroundColor: Colors.transparent,
                    children: List.generate(
                      VariablesManager.movies.length,
                      (index) =>
                          _newMovies(movie: VariablesManager.movies[index]),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: SizeManager.d18),
                  child: Text(GeneralStrings.topMovies(context),
                      style: TextStyleManager.titleStyle(context)),
                ),
                Padding(
                  padding: EdgeInsets.only(left: SizeManager.d18),
                  child: SizedBox(
                    height: GetSize.heightValue(SizeManager.d180, context),
                    width: double.infinity,
                    child: ListView.separated(
                      itemBuilder: (context, index) => RepaintBoundary(
                        child: _topMovie(movie: VariablesManager.movies[index]),
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: VariablesManager.movies.length,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(width: SizeManager.d14),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(SizeManager.d18),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        GeneralStrings.allMovies(context),
                        style: TextStyleManager.titleStyle(context),
                      ),
                      SizedBox(
                        height: GetSize.heightValue(SizeManager.d10, context),
                      ),
                      AnimationLimiter(
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: VariablesManager.movies.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: SizeManager.i2,
                            mainAxisSpacing: SizeManager.d30,
                            mainAxisExtent:
                                SizeManager.screenSize(context).height /
                                    SizeManager.d4,
                            crossAxisSpacing: SizeManager.d30,
                          ),
                          itemBuilder: (context, index) {
                            return AnimationConfiguration.staggeredGrid(
                              position: index,
                              duration: const Duration(milliseconds: 375),
                              columnCount: SizeManager.i2,
                              child: ScaleAnimation(
                                child: FadeInAnimation(
                                  child: RepaintBoundary(
                                    child: _movieCard(
                                        movie: _model.shuffledMovies[index]),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _newMovies({required MovieResponse movie}) {
    return RepaintBoundary(
      child: SizedBox(
        child: CachedNetworkImage(
          imageUrl: movie.photo!,
          errorWidget: (context, url, error) => Icon(Icons.error),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _topMovie({required MovieResponse movie}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieRoute(
                      movie: movie,
                    )));
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          ShimmerEffect(
            baseColor: VariablesManager.isDark ? Colors.white : Colors.black,
            highlightColor: VariablesManager.isDark
                ? Color(0xFFFFD700)
                : ColorManager.primarySecond,
            child: Container(
              height: GetSize.heightValue(SizeManager.d160, context),
              width: GetSize.widthValue(SizeManager.d110, context),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(SizeManager.d20),
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl: movie.verticalPhoto!,
            height: GetSize.heightValue(SizeManager.d150, context),
            width: GetSize.widthValue(SizeManager.d100, context),
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Icon(Icons.error),
            imageBuilder: (context, imageProvider) {
              return Container(
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
        ],
      ),
    );
  }

  Widget _movieCard({required MovieResponse movie}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieRoute(
                      movie: movie,
                    )));
      },
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              aspectRatio: SizeManager.d4 / 3,
              child: Stack(
                children: [
                  CachedNetworkImage(
                    imageUrl: movie.photo!,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => Icon(Icons.error),
                    imageBuilder: (context, imageProvider) {
                      return Container(
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
                  Align(
                      alignment: Alignment.topRight,
                      child: favoriteIcon(
                          context,
                          movie,
                          _model.addFilmToFavEvent,
                          _model.removeFilmFromFavEvent)),
                ],
              ),
            ),
          ),
          Text(movie.name!, style: TextStyleManager.bodyStyle(context)),
          featuresSlider(movie, context),
          Row(
            children: [
              Text("${movie.ticketPrice.toString()} €",
                  style: TextStyleManager.bodyStyle(context)),
              Spacer(),
              cartIcon(context, movie, _model.addFilmToCartEvent,
                  _model.removeFilmFromCartEvent),
            ],
          )
        ],
      ),
    );
  }
}
