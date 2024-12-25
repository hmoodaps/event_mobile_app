import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/getSize/getSize.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/routs&view_models/more_detail_route/more_detail_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';

class MoreDetailView extends StatefulWidget {
  final MovieResponse movie;

  const MoreDetailView({super.key, required this.movie});

  @override
  State<MoreDetailView> createState() => _MoreDetailViewState();
}

class _MoreDetailViewState extends State<MoreDetailView> {
  late MoreDetailModelView _model;
  // لتحديد العنصر المختار حاليًا
  int selectedIndex = 0;

  // دالة لتحديث الحالة عند الضغط على النص
  void onTextTap(int index) {
    setState(() {
      selectedIndex = index;
    });
  }
  @override
  void initState() {
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
    return BlocBuilder<EventsBloc, AppStates>(
      builder: (context, state) => getScaffold(isDark: VariablesManager.isDark),
    );
  }

  Widget getScaffold({required bool isDark}) => Scaffold(
        appBar: AppBar(
          title: Text(
            widget.movie.name!,
            style: TextStyleManager.header(context),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: IconsManager.arrowBack),
        ),
        body:
            stackBackGroundManager(isDark: isDark, otherWidget: otherWidget()),
      );

  otherWidget() => [
        ConditionalBuilder(
          condition: _model.actors.isNotEmpty,
          builder: (context) => Padding(
            padding: EdgeInsets.all(SizeManager.d18),
            child: pageBuilder(),
          ),
          fallback: (context) => Center(
            child: CircularProgressIndicator(),
          ),
        )
      ];

  Widget pageBuilder() {
    return Column(
      children: [
        YoutubePlayer(
          controller: _model.youtubePlayerController,
          aspectRatio: 16 / 9,
          enableFullScreenOnVerticalDrag: true,
        ),
        SizedBox(
          height: GetSize.heightValue(SizeManager.d10, context),
        ),
        Row(
          spacing: GetSize.widthValue(SizeManager.d15, context),
          children: [
            Container(
              padding: EdgeInsets.all(6),
              decoration: BoxDecoration(color: ColorManager.privateGrey , borderRadius: BorderRadius.circular(20) , border: Border.all(color: ColorManager.green3)),
              child: Text(
                'about',
                style: TextStyleManager.bodyStyle(context),
              ),
            ),
            Text('actors', style: TextStyleManager.bodyStyle(context)),
            Text('rating', style: TextStyleManager.bodyStyle(context)),
          ],
        ),
        Divider(),
      ],
    );
  }

  Widget getActors() {
    return SizedBox(
      height: GetSize.heightValue(SizeManager.d120, context),
      width: double.infinity,
      child: RotatedBox(
        quarterTurns: 1,
        child: ListWheelScrollView.useDelegate(
          controller: _model.listWheelController,
          // 2. ربط controller مع ListWheelScrollView
          diameterRatio: 2,
          childDelegate: ListWheelChildBuilderDelegate(
            builder: (context, index) {
              return RotatedBox(
                quarterTurns: 3,
                child: CircleAvatar(
                  foregroundColor: Colors.transparent,
                  backgroundImage: CachedNetworkImageProvider(
                    _model.actors[index].imageSource,
                  ),
                  radius: 50,
                ),
              );
            },
            childCount: _model.actors.length, // عدد العناصر
          ),
          onSelectedItemChanged: (value) => print(value),
          itemExtent: 75, // حجم العنصر
        ),
      ),
    );
  }
}
