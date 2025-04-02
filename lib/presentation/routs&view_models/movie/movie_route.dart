import 'package:cached_network_image/cached_network_image.dart';
import 'package:event_mobile_app/app/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/general_strings.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/bloc_manage'
    '.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/routs&view_models/movie/movie_'
    'model_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/getSize/getSize.dart';
import '../../../domain/local_models/models.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import '../more_detail_route/more_detail_view.dart';

class MovieRoute extends StatefulWidget {
  final MovieResponse movie;

  const MovieRoute({super.key, required this.movie});

  @override
  State<MovieRoute> createState() => _MovieRouteState();
}

class _MovieRouteState extends State<MovieRoute> {
  late MovieModelView _model;

  @override
  void initState() {
    super.initState();
    _model = MovieModelView(movie: widget.movie, context: context);
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
                imageUrl: widget.movie.vertical_photo!,
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
                      _model.dominantColor,
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
                    SizedBox(
                        height: GetSize.heightValue(SizeManager.d70, context)),
                    Center(
                      child: StaggeredAnimatedWidget(
                        delay: SizeManager.i900,
                        child: Text(
                          widget.movie.name!,
                          style: TextStyleManager.header(context)!
                              .copyWith(color: _model.textColor),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: GetSize.heightValue(SizeManager.d10, context)),
                    Padding(
                      padding: EdgeInsets.all(SizeManager.d20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: StaggeredAnimatedWidget(
                          delay: SizeManager.i900,
                          child: Text(
                            widget.movie.short_description!,
                            style: TextStyleManager.bodyStyle(context)!
                                .copyWith(color: _model.textColor),
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
          StaggeredAnimatedWidget(
            delay: 1000,
            child: GestureDetector(
              onTap: () {
                if (!isItemInFaves(filmId: widget.movie.id!)) {
                  _model.addFilmToFavEvent(widget.movie);
                } else {
                  _model.removeFilmFromFavEvent(widget.movie);
                }
              },
              child: Padding(
                padding: EdgeInsets.all(SizeManager.d20),
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    backgroundColor: isItemInFaves(
                      filmId: widget.movie.id!,
                    )
                        ? Colors.green
                        : ColorManager.privateGrey,
                    child: Center(
                      child: Icon(IconsManager.favorite,
                          color: isItemInFaves(filmId: widget.movie.id!)
                              ? Colors.red
                              : Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MoreDetailView(movie: widget.movie),
                ),
              );
            },
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(SizeManager.d20),
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      ContainerManager.myShadow(shadowColor: Colors.black45),
                    ],
                    borderRadius: BorderRadius.circular(SizeManager.d20),
                    gradient: LinearGradient(
                      colors: [
                        Colors.white,
                        ColorManager.green4,
                        ColorManager.green3,
                      ],
                      stops: [0.00001, 0.5, 1],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  height: GetSize.heightValue(SizeManager.d50, context),
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      GeneralStrings.moreDetails(context),
                      style: TextStyleManager.bodyStyle(context)?.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeightManager.bold),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
