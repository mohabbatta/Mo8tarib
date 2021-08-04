import 'package:flutter/material.dart';
import 'package:flutter_gifimage/flutter_gifimage.dart';
import 'package:mo8tarib/app/Screen/on_boarding/Widgets/on_boarding_widget.dart';
import 'package:mo8tarib/app/Screen/sign_in/onboarding_indicator.dart';
import 'package:mo8tarib/constants/color_constants.dart';
import 'package:mo8tarib/constants/image_constants.dart';
import 'package:mo8tarib/constants/string_constants.dart';
import 'package:mo8tarib/helper/localization.dart';
import 'package:mo8tarib/helper/shared_helper.dart';
import 'package:mo8tarib/main.dart';
import 'package:mo8tarib/services/app_language.dart';

class StartedPage extends StatefulWidget {
  const StartedPage({Key key}) : super(key: key);

  @override
  _StartedPageState createState() => _StartedPageState();
}

class _StartedPageState extends State<StartedPage>
    with TickerProviderStateMixin {
  PageController _pageController;
  int currentIndex = 0;
  GifController controller1;
  GifController controller2;
  GifController controller3;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    controller1 = GifController(vsync: this, duration: Duration(seconds: 1));
    controller1.animateTo(24);
    controller2 = GifController(vsync: this, duration: Duration(seconds: 1));
    controller3 = GifController(vsync: this, duration: Duration(seconds: 1));
  }

  @override
  void dispose() {
    _pageController.dispose();
    controller1.dispose();
    controller2.dispose();
    controller3.dispose();
    super.dispose();
  }

  onChangedFunction(int index) {
    setState(() {
      currentIndex = index;
    });
    if (index == 0) {
      controller1.animateTo(24);
    } else if (index == 1) {
      controller2.animateTo(24);
    } else if (index == 2) {
      controller3.animateTo(24);
    }
  }

  goHome() async {
    AppLanguage appLanguage = AppLanguage();
    await appLanguage.fetchLocale();
    SharedHelper.putBool(key: SharedAPi.onBoarding, value: true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => MyApp(
          appLanguage: appLanguage,
        ),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    var localization = AppLocalizations.of(context);
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              color: ColorConstants.white,
              child: PageView(
                controller: _pageController,
                onPageChanged: onChangedFunction,
                children: <Widget>[
                  onBoardingScreen(
                    context: context,
                    controller: controller1,
                    imageName: ImageConstants.onBoarding1,
                    mainText: localization.translate(
                      StringConstantsConstants.leaseAndRentInAnEasyWay,
                    ),
                  ),
                  onBoardingScreen(
                    context: context,
                    controller: controller2,
                    imageName: ImageConstants.onBoarding2,
                    mainText: localization.translate(
                      StringConstantsConstants
                          .findARoommateMatchingYourPreference,
                    ),
                  ),
                  onBoardingScreen(
                    context: context,
                    controller: controller3,
                    imageName: ImageConstants.onBoarding3,
                    mainText: localization.translate(StringConstantsConstants
                        .vacationResidenceIsNotAProblemNow),
                  ),
                ],
              ),
            ),
          ),
          Container(
            color: ColorConstants.white,
            height: size.width * 0.15,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    goHome();
                  },
                  child: Text(
                    localization.translate(StringConstantsConstants.cancel),
                    style: TextStyle(
                        color: ColorConstants.boardingTitle, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Indicator(
                        positionIndex: 0,
                        currentIndex: currentIndex,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Indicator(
                        positionIndex: 1,
                        currentIndex: currentIndex,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Indicator(
                        positionIndex: 2,
                        currentIndex: currentIndex,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (currentIndex < 2) {
                      _pageController.animateToPage(
                        currentIndex + 1,
                        duration: Duration(milliseconds: 200),
                        curve: Curves.bounceInOut,
                      );
                    } else {
                      goHome();
                    }
                  },
                  child: Container(
                    height: 50,
                    child: Center(
                      child: Text(
                        currentIndex == 2
                            ? localization
                                .translate(StringConstantsConstants.start)
                            : localization
                                .translate(StringConstantsConstants.next),
                        style: TextStyle(
                            color: ColorConstants.timeLineShippingColor,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
