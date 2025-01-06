import 'dart:async';

import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/handle_app_language/handle_app_language.dart';
import '../../../domain/model_objects/actor_model.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';

class MoreDetailModelView extends BaseViewModel {
  final BuildContext context;
  final MovieResponse movie;

  MoreDetailModelView({required this.movie, required this.context});

  late int initValue = 0;

  List<ActorModel> actors = [];
  late YoutubePlayerController youtubePlayerController;
  late EventsBloc _bloc;
  late final StreamSubscription blocStreamSubscription;
  late FixedExtentScrollController listWheelController;

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
    listWheelController = FixedExtentScrollController(initialItem: initValue);
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
  getIcons() {
    List<Widget> listIcons = [
      Icon(Icons.info),
      Image.asset(
        AssetsManager.actor,
        width: GetSize.widthValue(SizeManager.d30, context),
        height: GetSize.heightValue(SizeManager.d30, context),
      ),
    ];
    return listIcons;
  }

  getIconsName() {
    List<String> listString = [
      GeneralStrings.about(context),
      GeneralStrings.actors(context)
    ];

    return listString;
  }

  int selectedIndex = 0;

  int carouselViewSelectedIndex = 0;

  bool isExpanded(int index) {
    return selectedIndex == index;
  }

  _startListen() {
    blocStreamSubscription = _bloc.stream.listen((state) {
      if (state is FetchActorsSuccessState) {
        actors.clear();
        actors.addAll(state.actors);
        initValue = findMidpoint(state.actors.length);
      }
    });
  }
  void fetchActorsData(List<String> actors) {
  _bloc.add(FetchActorsDataEvent(actors: actors));
  }

  resourcesTap(int selectedActor) async {
    try {
      await launchUrl(Uri.parse(
          "https://en.wikipedia.org/?curid=${actors[selectedActor].pageId}"));
    } catch (e) {
      print(e);
    }
  }
}