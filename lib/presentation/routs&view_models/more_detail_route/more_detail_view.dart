import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:event_mobile_app/app/components/constants/color_manager.dart';
import 'package:event_mobile_app/app/components/constants/font_manager.dart';
import 'package:event_mobile_app/app/components/constants/getSize/getSize.dart';
import 'package:event_mobile_app/app/components/constants/icons_manager.dart';
import 'package:event_mobile_app/app/components/constants/size_manager.dart';
import 'package:event_mobile_app/data/models/movie_model.dart';
import 'package:event_mobile_app/presentation/routs&view_models/choos_seat_route/choos_seat_model_view.dart';
import 'package:event_mobile_app/presentation/routs&view_models/choos_seat_route/choos_seat_route.dart';
import 'package:event_mobile_app/presentation/routs&view_models/more_detail_route/more_detail_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/general_strings.dart';
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
        backgroundColor: ColorManager.primary,
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(bottom: 20.0),
            child: Row(
              spacing: GetSize.widthValue(SizeManager.d10, context),
              children: [
                Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [
                            Colors.white,
                            ColorManager.green4,
                            ColorManager.green3,
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: [0.00001, 0.5, 1]),
                      boxShadow: [
                        ContainerManager.myShadow(shadowColor: Colors.black45),
                      ],
                      shape: BoxShape.circle,
                      color: Colors.red),
                  height: GetSize.heightValue(SizeManager.d50, context),
                  width: GetSize.widthValue(SizeManager.d50, context),
                  child: Icon(
                    IconsManager.cart,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => Seat(movie: widget.movie, ),));
                    },
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
            spacing: GetSize.widthValue(SizeManager.d15, context),
            children: List.generate(
              2,
              (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    _model.selectedIndex = index;
                  });
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _model.isExpanded(index) ? 100 : 40,
                  height: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: _model.selectedIndex == index
                        ? ColorManager.primary
                        : Colors.transparent,
                  ),
                  child: !_model.isExpanded(index)
                      ? Center(child: _model.getIcons()[index])
                      : Align(
                          alignment: Alignment.center,
                          child: Row(
                            verticalDirection: VerticalDirection.up,
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 4,
                              ),
                              _model.getIcons()[index],
                              SizedBox(
                                width: 4,
                              ),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: true,
                                  _model.getIconsName()[index],
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
              ),
            ),
          ),
          Divider(),
          AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: _model.selectedIndex == 1 ? _getActors() : _aboutWidget(),
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
                                _model.actors[index].imageSource,
                              ),
                              radius: 50,
                            ),
                          ),
                          SizedBox(width: 8),
                        ],
                      ),
                    );
                  },
                  childCount: _model.actors.length,
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
                text: _model.actors[selectedActor].title,
                style: TextStyleManager.header(context)
                    ?.copyWith(color: Colors.black)),
          ])),
          Text(
            _model.actors[selectedActor].extract,
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
}
