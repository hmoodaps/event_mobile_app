import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);

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
                        controller: controller,
                        suffix: Icon(
                          IconsManager.search,
                        ),
                        labelText: GeneralStrings.search,
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeManager.d20,
                  ),
                  Text(
                    GeneralStrings.newMovies,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: SizeManager.d10,
                  ),
                  CarouselSlider.builder(
                      itemCount: 10,
                      itemBuilder: (context, dx, index) =>
                          newMovies(bloc: bloc),
                      options: CarouselOptions(
                        scrollDirection: Axis.horizontal,
                        height: SizeManager.screenSize(context).height / 3,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                      )),
                  SizedBox(
                    height: SizeManager.d10,
                  ),
                  Text(
                    GeneralStrings.topMovies,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  SizedBox(
                    height: SizeManager.d10,
                  ),
                  SizedBox(
                    height: SizeManager.d180,
                    width: double.infinity,
                    child: ListView.separated(
                      itemBuilder: (context, index) => topMovie(bloc: bloc , moviePhotoUrl: VariablesManager.movies[index].photo),
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
                    GeneralStrings.allMovies,
                    style: TextStyleManager.lightTitle(context),
                  ),
                  SizedBox(
                    height: SizeManager.d10,
                  ),
                  GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: VariablesManager.movies.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: SizeManager.i2,
                      mainAxisSpacing: SizeManager.d30,
                      mainAxisExtent: SizeManager.d200,
                      crossAxisSpacing: SizeManager.d30,
                    ),
                    itemBuilder: (context, index) => movieCard(VariablesManager.movies[index].verticalPhoto),
                  ),
                ],
              ),
            ),
          ),
        ),
      ];

  Widget newMovies({required EventsBloc bloc}) {
    return SizedBox(
      child:
          Image.network('https://filmestonia.eu/wp-content/uploads/tenet.jpg'),
    );
  }

  Widget topMovie({required EventsBloc bloc ,required String moviePhotoUrl}) {
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
                borderRadius: BorderRadius.circular(SizeManager.d20)),
          ),
        ),
        Container(
          height: SizeManager.d150,
          width: SizeManager.d100,
          decoration: BoxDecoration(
            image: DecorationImage(
                image: NetworkImage(
                    moviePhotoUrl),
                fit: BoxFit.cover),
            color: Colors.white,
            borderRadius: BorderRadius.circular(SizeManager.d20),
          ),
        ),
      ],
    );
  }

  Widget movieCard(String moviePhotoUrl) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(moviePhotoUrl),
              fit: BoxFit.cover),
          color: Colors.white,
          borderRadius: BorderRadius.circular(SizeManager.d20),
        ),
      ),
    );
  }

}
