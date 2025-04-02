import 'dart:async';
import 'dart:developer';

import 'package:event_mobile_app/app/components/constants/variables_manager.dart';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/handle_app_language/handle_app_language.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import '../../../domain/models/show_time_response/show_time_response.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';
import '../../bloc_state_managment/states.dart';
import '../choos_seat_route/choos_seat_route.dart';

class MoreDetailModelView extends BaseViewModel {
  final BuildContext context;
  final MovieResponse movie;
  late MovieResponse nextMovie;
  ShowTimesResponse? selectedShowTimeIndex;

  MoreDetailModelView({required this.movie, required this.context});

  late int initValue = 0;

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
    blocStreamSubscription.pause();
    blocStreamSubscription.cancel();
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
    nextMovie = MovieResponse();
    _startListen();
    initValue = findMidpoint(VariablesManager.actors.length);
    listWheelController = FixedExtentScrollController(initialItem: initValue);
    String? videoId =
        YoutubePlayerController.convertUrlToId(movie.sponsor_video!);
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
  }

  getIcons() {
    List<Widget> listIcons = [
      Icon(Icons.info),
      Image.asset(
        AssetsManager.actor,
        width: GetSize.widthValue(SizeManager.d30, context),
        height: GetSize.heightValue(SizeManager.d30, context),
      ),
      Icon(Icons.access_time),
    ];
    return listIcons;
  }

  getIconsName() {
    List<String> listString = [
      GeneralStrings.about(context),
      GeneralStrings.actors(context),
      "Show Times",
    ];

    return listString;
  }

  int selectedIndex = 0;

  int carouselViewSelectedIndex = 0;

  bool isExpanded(int index) {
    return selectedIndex == index;
  }

  resourcesTap(int selectedActor) async {
    try {
      await launchUrl(Uri.parse(
          "https://en.wikipedia.org/?curid=${VariablesManager.actors[selectedActor].pageId}"));
    } catch (e) {
      print(e);
    }
  }

  pauseVid() async {
    await youtubePlayerController.pauseVideo();
  }

  getMovie() {
    _bloc.add(GetMovieEvent(movieId: movie.id!));
  }

  _startListen() {
    blocStreamSubscription = _bloc.stream.listen(
          (state) {
        if (state is GetMovieState) {
          print("Movie Response: ${state.movieResponse}");
          print("Show times list: ${state.movieResponse.show_times}");

          if (state.movieResponse.show_times != null && state.movieResponse.show_times!.isNotEmpty) {
            if (selectedShowTimeIndex == null) {
              print("selectedShowTimeIndex is null, using last show_time");

              // استخدم pushReplacement بدلاً من push لضمان إلغاء الاشتراك
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Seat(
                    movie: state.movieResponse,
                    selectedShowTime: state.movieResponse.show_times!.last,
                  ),
                ),
              );
            } else {
              print("selectedShowTimeIndex is $selectedShowTimeIndex");

              // استخدم pushReplacement بدلاً من push لضمان إلغاء الاشتراك
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Seat(
                    movie: state.movieResponse,
                    selectedShowTime: selectedShowTimeIndex!,
                  ),
                ),
              );
            }
          } else {
            print("Error: show_times is null or empty!ddddd");
          }
        }
      },
    );
  }
}
