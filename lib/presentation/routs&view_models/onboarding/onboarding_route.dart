import 'package:event_mobile_app/presentation/components/constants/font_manager.dart';
import 'package:event_mobile_app/presentation/components/constants/size_manager.dart';
import 'package:flutter/material.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../components/constants/general_strings.dart';
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
  void initState() {
    super.initState();
    _model = OnboardingModelView();
    // لا تقم باستخدام السياق هنا
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _model.context = context; // تعيين السياق هنا
    _model.start();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _model.lastPageStream,
      builder: (context, snapshot) {
        return _getOnboarding(snapshot.data ?? false);
      },
    );
  }

  Widget _getOnboarding(bool isLast) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(SizeManager.d20),
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
                      child: OnboardingModels.customPageIndicator(
                          controller: _pageController,
                          count: _model.pages.length),
                    ),
                  ),
                  isLast
                      ? StaggeredAnimatedWidget(
                          delay: 1200,
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      SizeManager.screenSize(context).height /
                                          10),
                              child: TextButton(
                                onPressed: _model.onContinuePressed,
                                child: Text(GeneralStrings.continueString,
                                    style:
                                        TextStyleManager.lightTitle(context)),
                              ),
                            ),
                          ),
                        )
                      : SizedBox(),
                  SafeArea(child: Align(alignment: Alignment.topLeft,child: TextButton(onPressed: (){_pageController.animateToPage(_model.pages.length-1, duration: Duration(milliseconds: 400), curve: Curves.linear);}, child: Text('Skip' , style: TextStyleManager.lightTitle(context),)),))
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
