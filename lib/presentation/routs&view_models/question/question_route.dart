import 'package:event_mobile_app/presentation/components/constants/assets_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/buttons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/color_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/icons_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:event_mobile_app/presentation/routs&view_models/question/question_model_view.dart';
import 'package:flutter/material.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: IconsManager.arrowBack),
      ),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            StaggeredAnimatedWidget(
                delay: SizeManager.i200,
                child: Image.asset(
                  AssetsManager.getStartAsset,
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
                style: TextStyleManager.lightHeader,
              ),
            ),
            SizedBox(
              height: SizeManager.screenSize(context).height / 7,
            ),
            StaggeredAnimatedWidget(
              delay: SizeManager.i600,
              child: Text(
                GeneralStrings .question,
                style: TextStyleManager.lightTitle,
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
                      color: ColorManager.darkPrimary,
                    ),
                  ),
                  SizedBox(
                    width: SizeManager.d2,
                  ),
                  Text(
                    GeneralStrings .or,
                    style: TextStyleManager.lightTitle,
                  ),
                  SizedBox(
                    width: SizeManager.d2,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: ColorManager.darkPrimary,
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
                      color: ColorManager.darkPrimary,
                    ),
                  ),
                  SizedBox(
                    width: SizeManager.d2,
                  ),
                  Text(
                    GeneralStrings .haveAccount,
                    style: TextStyleManager.lightTitle,
                  ),
                  SizedBox(
                    width: SizeManager.d2,
                  ),
                  Expanded(
                    child: Container(
                      height: 1,
                      color: ColorManager.darkPrimary,
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
      )),
    );
  }
}
