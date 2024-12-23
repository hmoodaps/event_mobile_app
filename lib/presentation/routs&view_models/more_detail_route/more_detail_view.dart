import 'dart:convert';
import 'dart:io';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/model_objects/actor_model.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';
import 'package:http/http.dart' as http;
class MoreDetailView extends StatefulWidget {
  const MoreDetailView({super.key});

  @override
  State<MoreDetailView> createState() => _MoreDetailViewState();
}

class _MoreDetailViewState extends State<MoreDetailView> {

  @override
  Widget build(BuildContext context) {
    EventsBloc bloc = EventsBloc.get(context);

    return BlocConsumer<EventsBloc, AppStates>(builder: (context, state) =>
        getScaffold(isDark: VariablesManager.isDark),
        listener: (context, state) {});
  }

  Widget getScaffold({ required bool isDark}) =>
      Scaffold(
        body: stackBackGroundManager(isDark: isDark),
      );


late YoutubePlayerController _controller;

Future<void> fetchActorData(String actorName) async {
  final encodedName = Uri.encodeComponent(actorName);
  final String url =
      'https://en.wikipedia.org/w/api.php?action=query&format=json&titleStyles=$encodedName&prop=extracts|pageimages&exintro=true&explaintext=true&piprop=original';

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
  Future<void> fetchMovies() async {
    final String url = 'http://10.103.29.115:8000/movies/'; //// استخدم عنوان IP الخاص بالخادم
    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        data.forEach((movie) {
          print('Movie ID: ${movie['id']}, Name: ${movie['name']}');
        });
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      print('SocketException: $e');
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

otherWidget()=>[ Column(
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
    MaterialButton(onPressed: (){
      //fetchActorData('Leonardo DiCaprio');
      fetchMovies();},color: Colors.blue,height: 50,),
  ],
)];

}


