import 'dart:async';

import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../app/handle_app_language/handle_app_language.dart';
import '../../../domain/model_objects/actor_model.dart';

import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';

class MoreDetailModelView extends BaseViewModel {
  final BuildContext context;
  final MovieResponse movie;
  MoreDetailModelView({required this.movie, required this.context});
  late int initValue = 0 ;
   List<ActorModel> actors = [];
  late YoutubePlayerController youtubePlayerController;
  late EventsBloc _bloc;
  late final StreamSubscription blocStreamSubscription;
  late FixedExtentScrollController listWheelController ;
  int findMidpoint(int number) {
    double mid = number / 2;
    int roundedMid = mid.round();
    return roundedMid;
  }
  @override
  void dispose() {
    youtubePlayerController.close();
    blocStreamSubscription.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    _startListen();
    listWheelController =
        FixedExtentScrollController(initialItem: initValue);
    String? videoId =
        YoutubePlayerController.convertUrlToId(movie.sponsorVideo!);
    youtubePlayerController = YoutubePlayerController.fromVideoId(
      videoId: videoId!,
      autoPlay: true,
      params: YoutubePlayerParams(
        showControls: false,
        loop: true,
        showFullscreenButton: false,
        playsInline: true,
        showVideoAnnotations: false,
        mute: false,
        captionLanguage: TheAppLanguage.appLanguage,
        enableCaption: true,
        enableKeyboard: false,
        interfaceLanguage: TheAppLanguage.appLanguage,
        strictRelatedVideos: true,
      ),
    );
    fetchActorsData(
      movie.actors!.map((e) => e.toString()).toList(),
    );
  }

  void fetchActorsData(List<String> actors)  {
    _bloc.add(FetchActorsDataEvent(actors : actors ));

  }

  _startListen() {
    blocStreamSubscription = _bloc.stream.listen((state) {
      if(state is FetchActorsSuccessState){
        actors.clear();
        actors.addAll(state.actors);
       initValue =  findMidpoint(state.actors.length);
      }
    });
  }
}
