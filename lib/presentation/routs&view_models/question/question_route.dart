import 'package:event_mobile_app/presentation/bloc_state_managment/states.dart';
import 'package:event_mobile_app/presentation/components/constants/assets_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/color_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/icons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/variables_manager.dart';
import 'package:event_mobile_app/presentation/routs&view_models/question/question_model_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../bloc_state_managment/bloc_manage.dart';
import '../../components/constants/general_strings.dart';

class QuestionRoute extends StatefulWidget {
  const QuestionRoute({super.key});

  @override
  State<QuestionRoute> createState() => _QuestionRouteState();
}

class _QuestionRouteState extends State<QuestionRoute> {
  final _modelView = QuestionModelView();

  @override
  Widget build(BuildContext context) {
    EventsBloc bloc =EventsBloc.get(context);
    return BlocConsumer<EventsBloc  , AppStates>(builder:(context , state)=>getScaffold(bloc: bloc) , listener: (context , state){});
  }
  Widget getScaffold({required EventsBloc bloc})=>Scaffold(
    appBar: AppBar(
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: IconsManager.arrowBack),
    ),
    body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(SizeManager.d20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                StaggeredAnimatedWidget(
                    delay: SizeManager.i200,
                    child: Image.asset(
                      AssetsManager.getStartAsset,
                      color: VariablesManager.isDark?Colors.white : Colors.black,
                      width: SizeManager.screenSize(context).width / 10,
                      height: SizeManager.screenSize(context).width / 10,
                    )),
                SizedBox(
                  height: SizeManager.d8,
                ),
                StaggeredAnimatedWidget(
                  delay: SizeManager.i400,
                  child: Text(
                    GeneralStrings .letsStart,
                    style: TextStyleManager.lightHeader(context),
                  ),
                ),
                Spacer(),
                Align(alignment: Alignment.bottomCenter ,child: SizedBox(
                  height: SizeManager.screenSize(context).height/2,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      StaggeredAnimatedWidget(
                        delay: SizeManager.i600,
                        child: Text(
                          GeneralStrings .question,
                          style: TextStyleManager.lightTitle(context),
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
                              buttonName: GeneralStrings .guest,
                              onTap: () => _modelView.navigateToMain(context: context),
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
                              GeneralStrings .or,
                              style: TextStyleManager.lightTitle(context),
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
                              buttonName: GeneralStrings .register,
                              onTap: () =>
                                  _modelView.navigateToRegister(context: context),
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
                              GeneralStrings .haveAccount,
                              style: TextStyleManager.lightTitle(context),
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
                              buttonName: GeneralStrings .login,
                              onTap: () => _modelView.navigateToLogin(context: context),
                              color: ColorManager.privateBlue)),

                    ],
                  ),
                ),)
              ],
            ),
          ),
        )),
  );
}
