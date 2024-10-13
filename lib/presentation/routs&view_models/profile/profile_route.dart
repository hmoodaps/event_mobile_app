import 'dart:convert';
import 'package:event_mobile_app/presentation/components/constants/color_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import '../../../domain/models/actor_model.dart';
import '../../components/constants/stack_background_manager.dart';

class ProfileRoute extends StatefulWidget {
  const ProfileRoute({super.key});

  @override
  State<ProfileRoute> createState() => _ProfileRouteState();
}

class _ProfileRouteState extends State<ProfileRoute> {
  late YoutubePlayerController _controller;

  Future<void> fetchActorData(String actorName) async {
    final encodedName = Uri.encodeComponent(actorName);
    final String url =
        'https://en.wikipedia.org/w/api.php?action=query&format=json&titles=$encodedName&prop=extracts|pageimages&exintro=true&explaintext=true&piprop=original';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        ActorModel actor = ActorModel.fromJson(data);

        // طباعة التفاصيل
        print('Name: ${actor.fullName}');
        print('Description: ${actor.description}');
        print('Image URL: ${actor.profilePhoto}');
        print('Image URL: ${actor.sours}');
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }


  @override
  void initState() {
    super.initState();
    String videoUrl = "https://www.youtube.com/watch?v=5cx7rvMvAWo";
    String? videoId = YoutubePlayer.convertUrlToId(videoUrl);

    _controller = YoutubePlayerController(
      initialVideoId: videoId!,
      flags: YoutubePlayerFlags(
        showLiveFullscreenButton: false,

        loop: false,
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: stackBackGroundManager(
        otherWidget:[ Column(
          children: [
            Container(
              width: double.infinity,
              height: 300,
              child: YoutubePlayerBuilder(
                player: YoutubePlayer(
                  controller: _controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                    backgroundColor: ColorManager.primary,
                    bufferedColor: ColorManager.primary,
                  ),
                ),
                builder: (context, player) {
                  return Column(
                    children: [
                      player,
                      // يمكنك إضافة المزيد من العناصر هنا إذا كنت ترغب
                    ],
                  );
                },
              ),
            ),
          ],
        )],
      ),
    );
  }

  // List<Widget> screenWidgets() => [
  //   Container(
  //     width: double.infinity,
  //     height: 300,
  //     child: YoutubePlayer(
  //       controller: _controller,
  //       showVideoProgressIndicator: true,
  //       progressIndicatorColor: Colors.amber,
  //       progressColors: ProgressBarColors(
  //         playedColor: Colors.amber,
  //         handleColor: Colors.amberAccent,
  //         backgroundColor: ColorManager.primary,
  //         bufferedColor: ColorManager.primary,
  //
  //       ),
  //     ),
  //   )
  // ];
}
