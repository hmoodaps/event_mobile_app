import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:shimmer_effect/shimmer_effect.dart';

import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/route_strings_manager.dart';
import '../../../app/components/constants/routs_manager.dart';
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
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => _getScaffold(),
    );
  }

  Widget _getScaffold() => Scaffold(
        body: stackBackGroundManager(
            otherWidget: _screenWidgets(), isDark: VariablesManager.isDark),
      );

  List<Widget> _screenWidgets() => [
        LayoutBuilder(
          builder: (context, constraints) => LiquidPullToRefresh(
            backgroundColor: ColorManager.primary,
            height: constraints.maxHeight / 5,
            springAnimationDurationInMilliseconds: SizeManager.i1400,
            color: ColorManager.primarySecond,
            showChildOpacityTransition: true,
            onRefresh: () => _model.getMovies(),
            child: Visibility(
              visible: VariablesManager.movies.isNotEmpty,
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.all(SizeManager.d18),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: SizedBox(
                            width: double.infinity,
                            height: SizeManager.d50,
                            child: searchFormField(
                              context: context,
                              controller: _model.searchController,
                              suffix: Icon(
                                IconsManager.search,
                              ),
                              labelText: GeneralStrings.search(context),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.2),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.d20,
                        ),
                        Text(GeneralStrings.newMovies(context),
                            style: TextStyleManager.titleStyle(context)),
                        SizedBox(
                          height: SizeManager.d10,
                        ),
                        CarouselSlider.builder(
                          itemCount: VariablesManager.movies.length,
                          itemBuilder: (context, dx, index) => RepaintBoundary(
                            child: _newMovies(
                                dx: dx, movies: VariablesManager.movies),
                          ),
                          options: CarouselOptions(
                            scrollDirection: Axis.horizontal,
                            height: SizeManager.screenSize(context).height / 3,
                            padEnds: true,
                            viewportFraction: 1.0,
                            autoPlay: true,
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.d10,
                        ),
                        Text(GeneralStrings.topMovies(context),
                            style: TextStyleManager.titleStyle(context)),
                        SizedBox(
                          height: SizeManager.d10,
                        ),
                        SizedBox(
                          height: SizeManager.d180,
                          width: double.infinity,
                          child: ListView.separated(
                            itemBuilder: (context, index) => RepaintBoundary(
                              child: _topMovie(
                                  dx: index, movies: VariablesManager.movies),
                            ),
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: VariablesManager.movies.length,
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(width: SizeManager.d14),
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.d10,
                        ),
                        Text(
                          GeneralStrings.allMovies(context),
                          style: TextStyleManager.titleStyle(context),
                        ),
                        SizedBox(
                          height: SizeManager.d10,
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
                  ),
                ),
              ),
            ),
          ),
        ),
      ];


  Widget _newMovies({required int dx, required List<MovieResponse> movies}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieRoute(
                      movie: movies[dx],
                    )));
      },
      child: SizedBox(
        child: CachedNetworkImage(
          imageUrl: movies[dx].photo!,
          // placeholder: (context, url) => CircularProgressIndicator(), // Placeholder while loading
          errorWidget: (context, url, error) => Icon(Icons.error),
          // Error widget in case of failure
          fit: BoxFit.cover, // Adjust image to cover the container
        ),
      ),
    );
  }

  Widget _topMovie({required int dx, required List<MovieResponse> movies}) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MovieRoute(
                      movie: movies[dx],
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
              height: SizeManager.d160,
              width: SizeManager.d110,
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(SizeManager.d20),
              ),
            ),
          ),
          CachedNetworkImage(
            imageUrl: movies[dx].verticalPhoto!,
            height: SizeManager.d150,
            width: SizeManager.d100,
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
                    child: favoriteIcon(context, movie, _model.addFilmToFavEvent, _model.removeFilmFromFavEvent)
                  ),
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
              cartIcon(context, movie, _model.addFilmToCartEvent, _model.removeFilmFromCartEvent),
            ],
          )
        ],
      ),
    );
  }
}
