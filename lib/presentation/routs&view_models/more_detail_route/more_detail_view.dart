import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/getSize/getSize.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/app/handle_app_language/handle_app_language.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/routs&view_models/more_detail_route/more_detail_model_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/model_objects/actor_model.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';
class MoreDetailView extends StatefulWidget {
  final MovieResponse movie ;
  const MoreDetailView({super.key , required this.movie});

  @override
  State<MoreDetailView> createState() => _MoreDetailViewState();
}

class _MoreDetailViewState extends State<MoreDetailView> {
late MoreDetailModelView _model ;
  @override
  void initState()  {
    super.initState();
    _model = MoreDetailModelView(movie: widget.movie, context: context);
    _model.start();
  }


  @override
  void dispose() {
    super.dispose();
    _model.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<EventsBloc, AppStates>(builder: (context, state) =>
        getScaffold(isDark: VariablesManager.isDark),
  );
  }

  Widget getScaffold({ required bool isDark}) =>
      Scaffold(
        appBar: AppBar(leading: IconButton(onPressed: (){Navigator.pop(context);}, icon: IconsManager.arrowBack),),
        body: stackBackGroundManager(isDark: isDark , otherWidget: otherWidget()),
      );


otherWidget()=>[ ConditionalBuilder(condition: _model.actors.isNotEmpty, builder: (context) => Padding(
  padding:  EdgeInsets.all(SizeManager.d18),
  child: Column(
    children: [
      YoutubePlayer(
        controller: _model.youtubePlayerController,
        aspectRatio: 16 / 9,
        enableFullScreenOnVerticalDrag: true,
      ),
      Text(widget.movie.name!,style: TextStyleManager.header(context),),
      SizedBox(
        height: GetSize.heightValue(SizeManager.d120, context),
        width: double.infinity,
        child: RotatedBox(
          quarterTurns: 1,
          child: ListWheelScrollView.useDelegate(
            controller: _model.listWheelController, // 2. ربط controller مع ListWheelScrollView
            diameterRatio: 2,
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                return RotatedBox(
                  quarterTurns: 3,
                  child: CircleAvatar(
                    backgroundImage:CachedNetworkImageProvider(_model.actors[index].imageSource),
                    radius: 75,
                  ),
                );
              },
              childCount: _model.actors.length, // عدد العناصر
            ),
            onSelectedItemChanged: (value) => print(value),
            itemExtent: 100, // حجم العنصر
          ),
        ),
      ),

    ],
  ),
), fallback: (context) => Center(child: CircularProgressIndicator(),),)];

}


