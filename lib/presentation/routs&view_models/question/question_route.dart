import 'package:event_mobile_app/presentation/routs&view_models/question/question_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/buttons_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/icons_manager.dart';
import '../../../app/components/constants/size_manager.dart';
import '../../../app/components/constants/variables_manager.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/states.dart';

class QuestionRoute extends StatefulWidget {
  const QuestionRoute({super.key});

  @override
  State<QuestionRoute> createState() => _QuestionRouteState();
}

class _QuestionRouteState extends State<QuestionRoute> {
  final _modelView = QuestionModelView();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EventsBloc, AppStates>(
        builder: (context, state) => getScaffold(),
        listener: (context, state) {});
  }

  Widget getScaffold() => Scaffold(
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(SizeManager.d20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StaggeredAnimatedWidget(
                    delay: SizeManager.i200,
                    child: Image.asset(
                      AssetsManager.getStartAsset,
                      color:
                          VariablesManager.isDark ? Colors.white : Colors.black,
                      width: SizeManager.screenSize(context).width / 10,
                      height: SizeManager.screenSize(context).width / 10,
                    )),
                SizedBox(
                  height: SizeManager.d8,
                ),
                StaggeredAnimatedWidget(
                  delay: SizeManager.i400,
                  child: Text(
                    GeneralStrings.letsStart(context),
                    style: TextStyleManager.header(context),
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: SizeManager.screenSize(context).height / 2,
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StaggeredAnimatedWidget(
                          delay: SizeManager.i600,
                          child: Text(
                            GeneralStrings.question(context),
                            style: TextStyleManager.titleStyle(context),
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.d24,
                        ),
                        StaggeredAnimatedWidget(
                            delay: SizeManager.i800,
                            child: ButtonManager.myButton(
                                suffixIcon: IconsManager.home,
                                context: context,
                                buttonName: GeneralStrings.guest(context),
                                onTap: () =>
                                    _modelView.navigateToMain(context: context),
                                color: ColorManager.primarySecond)),
                        SizedBox(
                          height: SizeManager.d12,
                        ),
                        StaggeredAnimatedWidget(
                          delay: SizeManager.i1000,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: ColorManager.primary,
                                ),
                              ),
                              SizedBox(
                                width: SizeManager.d2,
                              ),
                              Text(
                                GeneralStrings.or(context),
                                style: TextStyleManager.titleStyle(context),
                              ),
                              SizedBox(
                                width: SizeManager.d2,
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: ColorManager.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.d12,
                        ),
                        StaggeredAnimatedWidget(
                            delay: SizeManager.i1200,
                            child: ButtonManager.myButton(
                                suffixIcon: IconsManager.register,
                                context: context,
                                buttonName: GeneralStrings.register(context),
                                onTap: () => _modelView.navigateToRegister(
                                    context: context),
                                color: ColorManager.privateYalow)),
                        SizedBox(
                          height: SizeManager.d12,
                        ),
                        StaggeredAnimatedWidget(
                          delay: SizeManager.i1400,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: ColorManager.primary,
                                ),
                              ),
                              SizedBox(
                                width: SizeManager.d2,
                              ),
                              Text(
                                GeneralStrings.haveAccount(context),
                                style: TextStyleManager.titleStyle(context),
                              ),
                              SizedBox(
                                width: SizeManager.d2,
                              ),
                              Expanded(
                                child: Container(
                                  height: 1,
                                  color: ColorManager.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: SizeManager.d12,
                        ),
                        StaggeredAnimatedWidget(
                            delay: SizeManager.i1600,
                            child: ButtonManager.myButton(
                                suffixIcon: IconsManager.login,
                                context: context,
                                buttonName: GeneralStrings.login(context),
                                onTap: () => _modelView.navigateToLogin(
                                    context: context),
                                color: ColorManager.privateBlue)),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        )),
      );
}
