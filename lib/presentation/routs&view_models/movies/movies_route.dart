import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_mobile_app/app/dependencies_injection/dependency_injection.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/movies/movies_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:shimmer_effect/shimmer_effect.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/text_form_manager.dart';
import '../../../app/components/constants/variables_manager.dart';

class MoviesRoute extends StatefulWidget {
  const MoviesRoute({super.key});

  @override
  State<MoviesRoute> createState() => _MoviesRouteState();
}

class _MoviesRouteState extends State<MoviesRoute> {
final MoviesModelView _modelView = MoviesModelView() ;
  @override
  void initState() {
    super.initState();
    _modelView.start();
  }


  @override
  Widget build(BuildContext context) {
    EventsBloc bloc = instance<EventsBloc>();

    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => _getScaffold(bloc: bloc),
        listener: (context, state) {});
  }

  Widget _getScaffold({required EventsBloc bloc}) => Scaffold(
        body: stackBackGroundManager(
            otherWidget: screenWidgets(bloc: bloc),
            isDark: VariablesManager.isDark),
      );

  List<Widget> screenWidgets({required EventsBloc bloc}) => [
        SingleChildScrollView(
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
                        controller: _modelView.searchController,
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
                  Text(
                    GeneralStrings.newMovies(context),
                    style:TextStyleManager.titleStyle(context)
                  ),
                  SizedBox(
                    height: SizeManager.d10,
                  ),
                  CarouselSlider.builder(
                    itemCount: VariablesManager.movies.length,
                    itemBuilder: (context, dx, index) => RepaintBoundary(
                      child: newMovies(moviePhotoUrl:VariablesManager.movies[dx].photo! ),
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
                  Text(
                    GeneralStrings.topMovies(context),
                      style:TextStyleManager.titleStyle(context)                  ),
                  SizedBox(
                    height: SizeManager.d10,
                  ),
                  SizedBox(
                    height: SizeManager.d180,
                    width: double.infinity,
                    child: ListView.separated(
                      itemBuilder: (context, index) => RepaintBoundary(
                        child: topMovie(bloc: bloc, moviePhotoUrl: VariablesManager.movies[index].verticalPhoto!),
                      ),
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: VariablesManager.movies.length,
                      separatorBuilder: (BuildContext context, int index) =>
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: SizeManager.i2,
                        mainAxisSpacing: SizeManager.d30,
                        mainAxisExtent: SizeManager.screenSize(context).height / 4,
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
                                child: movieCard(_modelView.shuffledMovies[index]),
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
      ];


  Widget newMovies({required String moviePhotoUrl}) {
    return SizedBox(
      child: CachedNetworkImage(
        imageUrl: moviePhotoUrl,
       // placeholder: (context, url) => CircularProgressIndicator(), // Placeholder while loading
        errorWidget: (context, url, error) => Icon(Icons.error), // Error widget in case of failure
        fit: BoxFit.cover, // Adjust image to cover the container
      ),
    );
  }

  Widget topMovie({required EventsBloc bloc, required String moviePhotoUrl}) {
    return Stack(
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
          imageUrl: moviePhotoUrl,
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
    );
  }

  Widget movieCard(MovieResponse movie) {
    return Column(
      children: [
        Expanded(
          child: AspectRatio(
            aspectRatio: 4 / 3,
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
                  child: CircleAvatar(
                    radius: 15,
                    backgroundColor: ColorManager.privateGrey,
                    child: Align(
                      alignment: Alignment.center,
                      child: IconButton(

                        onPressed: () {},
                        icon: Icon(IconsManager.favorite , size: 20,color: Colors.red,),
                        padding: EdgeInsets.zero,
                      ),
                    ),
                  ),
                ),

                // Align(
                //   alignment: Alignment.bottomRight,
                //   child: RatingBar.builder(
                //     initialRating: movie.imdbRating!,
                //     minRating: 1,
                //     direction: Axis.horizontal,
                //     allowHalfRating: true,
                //     itemCount: 5,
                //     itemSize: 15.0,
                //     itemPadding: EdgeInsets.symmetric(horizontal: 2.0),
                //     itemBuilder: (context, index) => Icon(
                //       Icons.star,
                //       color: Colors.amber,
                //     ),
                //     onRatingUpdate: (rating) {
                //       if (kDebugMode) {
                //         print(rating);
                //       }
                //     },
                //   ),
                // ),

              ],
            ),
          ),
        ),
        Text(movie.name!, style: TextStyleManager.bodyStyle(context)),
        featuresSlider(movie),
        Row(
          children: [
            Text("${movie.ticketPrice.toString()} €", style: TextStyleManager.bodyStyle(context)),
            Spacer(),
            CircleAvatar(
              radius: 15,
              backgroundColor: ColorManager.privateGrey,
              child: Align(
                alignment: Alignment.center,
                child: IconButton(

                  onPressed: () {},
                  icon: Icon(IconsManager.cart , size: 20,color: ColorManager.primarySecond,),
                  padding: EdgeInsets.zero,
                ),
              ),
            ),

          ],
        )
      ],
    );
  }


  Widget featuresSlider(MovieResponse movie) {
    List<Widget> features = [];

    Widget buildTextWithVariable(String label, dynamic value, String suffixLabel) {
      return Row(
        children: [
          Text(
            label,
            style: TextStyleManager.smallParagraphStyle(context),
          ),
          Text(
            ' $value',
            style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              color: VariablesManager.isDark ? Colors.white: ColorManager.primarySecond ,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            ' $suffixLabel',
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
            style: TextStyleManager.smallParagraphStyle(context),
          ),
          Text(
            ' ${oldTicketPrice.toStringAsFixed(2)}',
            style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              decoration: TextDecoration.lineThrough,
              color: Colors.grey,
            ),
          ),
          Text(
            ' ${movie.ticketPrice}',
            style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              color: VariablesManager.isDark ? Colors.white: ColorManager.primarySecond ,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );

    features.add(buildTextWithVariable(GeneralStrings.heightIMDBRate(context), movie.imdbRating, ''));
    features.add(buildTextWithVariable('', movie.availableSeats, GeneralStrings.seatsAvailable(context)));
    features.add(buildTextWithVariable('', movie.seats, GeneralStrings.seats(context)));

    if (movie.availableSeats == movie.seats) {
      features.add(
        Text(
          GeneralStrings.beTheFirstOne(context),
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
              style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
                fontStyle: FontStyle.italic,
                color: Colors.orange,
              ),
            ),
            Text(" ${movie.availableSeats}" , style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.blue,
            ),),            Text(" ${GeneralStrings.ticketsLeft(context)}" , style: TextStyleManager.smallParagraphStyle(context)?.copyWith(
              fontStyle: FontStyle.italic,
              color: Colors.orange,
            ),),
          ],
        ),
      );
    }

    return CarouselSlider(
      items: features,
      options: CarouselOptions(
        autoPlay: true,
        scrollDirection: Axis.vertical,
        height: SizeManager.d14,
        padEnds: true,
        viewportFraction: 1.0,
      ),
    );
  }


}
