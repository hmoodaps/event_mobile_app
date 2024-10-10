import 'dart:async';
import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:event_mobile_app/presentation/components/constants/route_strings_manager.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:staggered_animated_widget/staggered_animated_widget.dart';

import '../../../data/local_storage/shared_local.dart';
import '../../components/constants/assets_manager.dart';
import '../../components/constants/color_manager.dart';
import '../../components/constants/font_manager.dart';
import '../../components/constants/general_strings.dart';
import '../../components/constants/routs_manager.dart';
import '../../components/constants/size_manager.dart';

class OnboardingModelView extends BaseViewModel
    with OnboardingModelViewInputs, OnboardingModelViewOutput {
  final StreamController<bool> _lastPageStreamController = StreamController<bool>();
  late BuildContext? context;
  late List<Widget> pages;

  @override
  void start() {
    pages = OnboardingModels.onboardingList(context);
  }

  @override
  void dispose() {
    _lastPageStreamController.close();
  }

  @override
  Sink<bool> get lastPageSink => _lastPageStreamController.sink;

  @override
  Stream<bool> get lastPageStream => _lastPageStreamController.stream;


  @override
  void checkIndex(int index) {
   bool isLast =  index == pages.length - 1;
    lastPageSink.add(isLast);
  }

  @override
  void onContinuePressed() {
   SharedPref.saveBool(key: GeneralStrings.isFirstTimeOpened, value: false);
   navigateTo(context!, RouteStringsManager.questionRoute);

  }

}

mixin OnboardingModelViewInputs {
  Sink<bool> get lastPageSink;
  void checkIndex(int index);
  void onContinuePressed();
}

mixin OnboardingModelViewOutput {
  Stream<bool> get lastPageStream;
}
//on boarding models
class OnboardingModels {
  static List<Widget> onboardingList(context) {
    List<Widget> onboardingWidgetsList = [
      onboardingPageBuilder(SizeManager.i300),
      onboardingPageBuilder(SizeManager.i600),
      onboardingPageBuilder(SizeManager.i900),

    ];
    return onboardingWidgetsList;
  }

  static Widget onboardingPageBuilder( int delay){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(child: StaggeredAnimatedWidget(delay: delay, child: Image.asset(AssetsManager.cinemaAsset)),),
        SizedBox(height: SizeManager.d100,),
        Center(child: StaggeredAnimatedWidget(delay: delay, child: Text(GeneralStrings .welcome , style: TextStyleManager.lightHeader,),),),
        Center(child: StaggeredAnimatedWidget(delay: delay, child: Text(GeneralStrings .startInvesting , style: TextStyleManager.lightTitle,)),),
        SizedBox(height: SizeManager.d20,),
        StaggeredAnimatedWidget(delay: delay,child: Align(alignment: Alignment.center , child: Text(GeneralStrings .otherFees),)),
        StaggeredAnimatedWidget(delay: delay,          child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(alignment: Alignment.center , child: Text(GeneralStrings .viewOur),),
            Align(alignment: Alignment.center , child: GestureDetector(onTap: (){},child:  Text(GeneralStrings .fee , style: TextStyle(color: ColorManager.primarySecond),)),),
            Align(alignment: Alignment.center , child: Text(GeneralStrings .learnMore),),
          ],
        ),
        ),
        StaggeredAnimatedWidget(delay: delay,child: Align(alignment: Alignment.center , child: Text(GeneralStrings .allInvesting),)),


      ],);
  }
  static Widget customPageIndicator(
      {required PageController controller, required int count}) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: CustomizableEffect(
        activeDotDecoration: DotDecoration(
          width: SizeManager.d12,
          height: SizeManager.d12,
          color: ColorManager.primarySecond,
          borderRadius: BorderRadius.circular(SizeManager.d24),
        ),
        dotDecoration: DotDecoration(
          width: SizeManager.d20,
          height: SizeManager.d16,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.elliptical(SizeManager.d20, SizeManager.d20),
            topRight: Radius.circular(SizeManager.d20),
          ),
          verticalOffset: SizeManager.d16,
          color: Colors.blue,
        ),
      ),
    );
  }
}