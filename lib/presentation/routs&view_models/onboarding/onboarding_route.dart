import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../app/components/constants/assets_manager.dart';
import '../../../app/components/constants/color_manager.dart';
import '../../../app/components/constants/font_manager.dart';
import '../../../app/components/constants/general_strings.dart';
import '../../../app/components/constants/getSize/getSize.dart';
import '../../../app/components/constants/size_manager.dart';
import 'onboarding_model_view.dart';

class OnboardingRoute extends StatefulWidget {
  const OnboardingRoute({super.key});

  @override
  State<OnboardingRoute> createState() => _OnboardingRouteState();
}

class _OnboardingRouteState extends State<OnboardingRoute> {
  late final OnboardingModelView _model;
  final PageController _pageController = PageController();

  @override
  initState() {
    super.initState();
    _model = OnboardingModelView(context);
    _model.start();
  }

  List<Widget> _onboardingList() {
    List<Widget> onboardingWidgetsList = [
      _onboardingPageBuilder(SizeManager.i300, context),
      _onboardingPageBuilder(SizeManager.i600, context),
      _onboardingPageBuilder(SizeManager.i900, context),
    ];
    return onboardingWidgetsList;
  }

  Widget _onboardingPageBuilder(int delay, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: StaggeredAnimatedWidget(
              delay: delay, child: Image.asset(AssetsManager.cinemaAsset)),
        ),
        SizedBox(
          height: GetSize.heightValue(SizeManager.d100, context),
        ),
        Center(
          child: StaggeredAnimatedWidget(
            delay: delay,
            child: Text(
              GeneralStrings.welcome(context),
              style: TextStyleManager.header(context),
            ),
          ),
        ),
        Center(
          child: StaggeredAnimatedWidget(
              delay: delay,
              child: Text(
                GeneralStrings.startInvesting(context),
                style: TextStyleManager.titleStyle(context),
              )),
        ),
        SizedBox(
          height: GetSize.heightValue(SizeManager.d20, context),
        ),
        StaggeredAnimatedWidget(
            delay: delay,
            child: Align(
              alignment: Alignment.center,
              child: Text(
                GeneralStrings.otherFees(context),
                style: TextStyleManager.bodyStyle(context),
              ),
            )),
        StaggeredAnimatedWidget(
          delay: delay,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(GeneralStrings.viewOur(context),
                    style: TextStyleManager.bodyStyle(context)),
              ),
              Align(
                alignment: Alignment.center,
                child: GestureDetector(
                    onTap: () {},
                    child: Text(
                      GeneralStrings.fee(context),
                      style: TextStyle(color: ColorManager.primarySecond),
                    )),
              ),
              Align(
                alignment: Alignment.center,
                child: Text(GeneralStrings.learnMore(context),
                    style: TextStyleManager.bodyStyle(context)),
              ),
            ],
          ),
        ),
        StaggeredAnimatedWidget(
            delay: delay,
            child: Align(
              alignment: Alignment.center,
              child: Text(GeneralStrings.allInvesting(context),
                  style: TextStyleManager.bodyStyle(context)),
            )),
      ],
    );
  }

  Widget _customPageIndicator(
      {required PageController controller, required int count}) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: CustomizableEffect(
        activeDotDecoration: DotDecoration(
          width: GetSize.widthValue(SizeManager.d12, context),
          height: GetSize.heightValue(SizeManager.d12, context),
          color: ColorManager.primarySecond,
          borderRadius: BorderRadius.circular(SizeManager.d24),
        ),
        dotDecoration: DotDecoration(
          width: GetSize.widthValue(SizeManager.d20, context),
          height: GetSize.heightValue(SizeManager.d16, context),
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.elliptical(SizeManager.d20, SizeManager.d20),
            topRight: Radius.circular(SizeManager.d20),
          ),
          verticalOffset: SizeManager.d16,
          color: Colors.blue,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _model.pages = _onboardingList();

    return StreamBuilder<bool>(
      stream: _model.lastPageStream,
      builder: (context, snapshot) {
        return _getOnboarding(snapshot.data ?? false);
      },
    );
  }

  Widget _getOnboarding(bool isLast) => Scaffold(
        body: Padding(
          padding: EdgeInsets.all(SizeManager.d20),
          child: Stack(
            children: [
              Center(
                child: PageView(
                  controller: _pageController,
                  onPageChanged: (index) => _model.checkIndex(index),
                  children: [..._model.pages],
                ),
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(
                          bottom: SizeManager.screenSize(context).height / 5),
                      child: _customPageIndicator(
                          controller: _pageController,
                          count: _model.pages.length),
                    ),
                  ),
                  Visibility(
                    visible: isLast,
                    child: StaggeredAnimatedWidget(
                      delay: 1200,
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom:
                                  SizeManager.screenSize(context).height / 10),
                          child: TextButton(
                            onPressed: _model.onContinuePressed,
                            child: Text(GeneralStrings.continueString(context),
                                style: TextStyleManager.titleStyle(context)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SafeArea(
                      child: Align(
                    alignment: Alignment.topLeft,
                    child: TextButton(
                        onPressed: () {
                          _pageController.animateToPage(_model.pages.length - 1,
                              duration: Duration(milliseconds: 400),
                              curve: Curves.linear);
                        },
                        child: Text(
                          'Skip',
                          style: TextStyleManager.titleStyle(context),
                        )),
                  ))
                ],
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }
}
