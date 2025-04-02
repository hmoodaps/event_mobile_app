import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/getSize/getSize.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/notification_handler.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/data/local_storage/shared_local.dart';
import 'package:event_mobile_app/domain/local_models/models.dart';
import 'package:event_mobile_app/presentation/routs&view_models/more_detail_route/more_detail_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/stack_background_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../../domain/models/movie_model/movie_model.dart';
import '../../../domain/models/show_time_response/show_time_response.dart';
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

  int? selectedIndex = null;

  @override
  void initState() {
    super.initState();
    _model = MoreDetailModelView(movie: widget.movie, context: context);
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
      builder: (context, state) => getScaffold(isDark: VariablesManager.isDark),
    );
  }

  Widget getScaffold({required bool isDark}) => Scaffold(
        backgroundColor: ColorManager.primary,
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              spacing: GetSize.widthValue(SizeManager.d10, context),
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      if(SharedPref.prefs.getString(GeneralStrings.currentUser) ==null ||SharedPref.prefs.getString(GeneralStrings.currentUser) =="" ){
                        errorNotification(context: context, description: "you have to log in first");
                      }else{
                        if (_model.selectedIndex != 2) {
                          setState(() {
                            _model.selectedIndex = 2;
                          });
                        } else {
                          _model.pauseVid();
                          _model.getMovie();
                        }

                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          ContainerManager.myShadow(
                              shadowColor: Colors.black45),
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
                          GeneralStrings.bookNow(context),
                          style: TextStyleManager.bodyStyle(context)?.copyWith(
                              color: Colors.black,
                              fontWeight: FontWeightManager.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        appBar: AppBar(
          title: Text(
            widget.movie.name!,
            style: TextStyleManager.header(context),
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconsManager.arrowBack,
          ),
        ),
        body:
            stackBackGroundManager(isDark: isDark, otherWidget: otherWidget()),
      );

  otherWidget() => [
        ConditionalBuilder(
          condition: VariablesManager.actors.isNotEmpty,
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
    return SingleChildScrollView(
      child: Column(
        children: [
          YoutubePlayer(
            controller: _model.youtubePlayerController,
            aspectRatio: 16 / 9,
            enableFullScreenOnVerticalDrag: true,
          ),
          SizedBox(
            height: GetSize.heightValue(SizeManager.d24, context),
          ),
          Row(
            children: List.generate(
              3,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _model.selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: 40,
                  padding: EdgeInsets.symmetric(
                      horizontal: _model.isExpanded(index) ? 20 : 10),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _model.selectedIndex == index
                        ? ColorManager.primary
                        : Colors.transparent,
                  ),
                  child: IntrinsicWidth(
                    // هنا يتم ضبط العرض بناءً على المحتوى
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _model.getIcons()[index],
                        if (_model.isExpanded(index)) ...[
                          SizedBox(width: 6),
                          Text(
                            _model.getIconsName()[index],
                            style: TextStyle(fontSize: 16),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 750),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: _model.selectedIndex == 1
                ? _getActors()
                : _model.selectedIndex == 2
                    ? _showTimes()
                    : _aboutWidget(),
          )
        ],
      ),
    );
  }

  _getActors() {
    int selectedActor = 0;
    return StatefulBuilder(
      builder: (context, setState) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: GetSize.heightValue(SizeManager.d10, context),
        children: [
          SizedBox(
            height: GetSize.heightValue(SizeManager.d120, context),
            width: double.infinity,
            child: RotatedBox(
              quarterTurns: 1,
              child: ListWheelScrollView.useDelegate(
                controller: _model.listWheelController,
                diameterRatio: 2,
                childDelegate: ListWheelChildBuilderDelegate(
                  builder: (context, index) {
                    return RotatedBox(
                      quarterTurns: 3,
                      child: Row(
                        children: [
                          Expanded(
                            child: CircleAvatar(
                              foregroundColor: Colors.transparent,
                              backgroundImage: CachedNetworkImageProvider(
                                VariablesManager.actors[index].imageSource,
                              ),
                              radius: 50,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    );
                  },
                  childCount: VariablesManager.actors.length,
                ),
                onSelectedItemChanged: (value) {
                  setState(() {
                    selectedActor = value;
                  });
                },
                itemExtent: 75,
              ),
            ),
          ),
          RichText(
              text: TextSpan(children: [
            TextSpan(
              text: GeneralStrings.douKnowWhoIs(context),
              style: TextStyleManager.titleStyle(context),
            ),
            TextSpan(
                text: VariablesManager.actors[selectedActor].title,
                style: TextStyleManager.header(context)
                    ?.copyWith(color: Colors.black)),
          ])),
          Text(
            VariablesManager.actors[selectedActor].extract,
            softWrap: true,
            maxLines: 10,
            overflow: TextOverflow.ellipsis,
            style: TextStyleManager.paragraphStyle(context),
          ),
          SizedBox(
            height: SizeManager.d10,
          ),
          GestureDetector(
              onTap: () {
                _model.resourcesTap(selectedActor);
              },
              child: Text(
                GeneralStrings.resources(context),
                style: TextStyleManager.smallParagraphStyle(context)
                    ?.copyWith(color: ColorManager.privateYalow),
              )),
          SizedBox(
            height: SizeManager.d50,
          )
        ],
      ),
    );
  }

  _aboutWidget() {
    return Text(
      _model.movie.description!,
      style: TextStyleManager.bodyStyle(context),
    );
  }

  _showTimes() {
    return Column(
      children: [
        SizedBox(
          height: 15,
        ),
        Text(
          "When you like to watch ${widget.movie.name} : ",
          style: TextStyleManager.titleStyle(context),
        ),
        ArcItemSelector(
          items: _buildShowTimeItems(widget.movie.show_times!),
          onItemSelected: (index) {
            print(index);
            final selectedShowTime = widget.movie.show_times![index];
            setState(() {
              selectedIndex = index;
              _model.selectedShowTimeIndex = selectedShowTime;
            });
          },
        ),
      ],
    );
  }

  List<Widget> _buildShowTimeItems(List<ShowTimesResponse> showTimes) {
    return showTimes.map((showTime) {
      return FittedBox(
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1, red: 0, green: 0, blue: 0),
                blurRadius: 4,
                spreadRadius: 2,
              )
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(showTime.date ?? "",
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text(showTime.time ?? "",
                  style: const TextStyle(fontSize: 12, color: Colors.black54)),
              const SizedBox(height: 4),
              Text("${GeneralStrings.hall(context)} ${showTime.hall}",
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.red)),
            ],
          ),
        ),
      );
    }).toList();
  }
}
