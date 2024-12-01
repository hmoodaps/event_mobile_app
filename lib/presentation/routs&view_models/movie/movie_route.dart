
import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mobile_app/app/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/movie/movie_model_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

class MovieRoute extends StatefulWidget {
  final MovieResponse movie;

  const MovieRoute({super.key, required this.movie});

  @override
  State<MovieRoute> createState() => _MovieRouteState();
}

class _MovieRouteState extends State<MovieRoute> {
late MovieModelView _movieModelView ;

  @override
  void initState() {
    super.initState();
    _movieModelView = MovieModelView(movie: widget.movie, context: context);
    _movieModelView.start();
  }

  @override
  void dispose() {
    _movieModelView.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => _getScaffold(),
    );
  }

  /// Constructs the main scaffold for the movie details screen.
  Widget _getScaffold() {
    return Scaffold(
      body: Stack(
        children: [
          StaggeredAnimatedWidget(
            delay: SizeManager.i300,
            child: SizedBox(
              height: SizeManager.screenSize(context).height * (75 / 100),
              child: CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: widget.movie.verticalPhoto!,
              ),
            ),
          ),
          StaggeredAnimatedWidget(
            delay: SizeManager.i300,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.transparent,
                      _movieModelView.dominantColor,
                    ],
                    begin: AlignmentDirectional.topCenter,
                    end: AlignmentDirectional.bottomCenter,
                    stops: [0.1, 0.09, 0.4],
                  ),
                ),
                height: SizeManager.screenSize(context).height * (45 / 100),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: SizeManager.d70),
                    Center(
                      child: StaggeredAnimatedWidget(
                        delay: SizeManager.i900,
                        child: Text(
                          widget.movie.name!,
                          style: TextStyleManager.header(context)!
                              .copyWith(color: _movieModelView.textColor),
                        ),
                      ),
                    ),
                    SizedBox(height: SizeManager.d10),
                    Padding(
                      padding: EdgeInsets.all(SizeManager.d20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: StaggeredAnimatedWidget(
                          delay: SizeManager.i900,
                          child: Text(
                            widget.movie.shortDescription!,
                            style: TextStyleManager.bodyStyle(context)!
                                .copyWith(color: _movieModelView.textColor),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          StaggeredAnimatedWidget(
            delay: 1000,
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Padding(
                padding: EdgeInsets.all(SizeManager.d20),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CircleAvatar(
                    backgroundColor: ColorManager.primary,
                    child: Center(
                      child: Icon(CupertinoIcons.reply_thick_solid,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(SizeManager.d20),
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        ContainerManager.myShadow(shadowColor: _movieModelView.textColor)
                      ],
                    ),
                    child: CircleAvatar(
                      backgroundColor: ColorManager.primary,
                      radius: SizeManager.d30,
                      child: Center(
                          child:
                              Icon(IconsManager.cart, size: SizeManager.d30)),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: SizeManager.d20),
                    child: ButtonManager.myButton(
                      context: context,
                      height: SizeManager.d50,
                      buttonName: 'More Details',
                      shadowColor: _movieModelView.textColor,
                      textColor: Colors.black,
                      onTap: () {},
                      color: ColorManager.primary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
