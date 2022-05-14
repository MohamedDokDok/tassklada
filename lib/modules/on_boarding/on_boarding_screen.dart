import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../cubit/cubit.dart';
import '../../cubit/states.dart';
import '../../home_layout/home_layout.dart';
import '../../shared/component.dart';
import '../../shared/local_storage_shared_pref/cache_helper.dart';
import '../../shared/style/color.dart';
import '../../widget/on_boarding.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  PageController onBoardingController = PageController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 6,
                    child: PageView.builder(
                      itemBuilder: (context, index) => OnBoardingView(
                          model: AppCubit.get(context).onBoardingItem[index]),
                      onPageChanged: (int index) {
                        AppCubit.get(context).checkIsLastPageView(index: index);
                      },
                      physics: const BouncingScrollPhysics(),
                      itemCount: AppCubit.get(context).onBoardingItem.length,
                      controller: onBoardingController,
                    ),
                  ),
                  const Spacer(),
                  _buttonAndIndicator(context: context)
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  _buttonAndIndicator({
    required BuildContext context,
  }) =>
      Expanded(
        flex: 1,
        child: Row(
          children: <Widget>[
            TextButton(
              onPressed: () {
                CacheHelper.saveData(key: 'onBoardingStatus', value: true)
                    .then((value) {
                  if (value) {
                    navigateAndTerminateLast(
                      context: context,
                      widget: const HomeLayoutScreen(),
                    );
                  }
                });
              },
              child: Text(
                'Skip',
                style: TextStyle(
                  color: bluish,
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const Spacer(),
            SmoothPageIndicator(
              controller: onBoardingController,
              count: AppCubit.get(context).onBoardingItem.length,
              effect: const ExpandingDotsEffect(
                dotColor: Colors.grey,
                activeDotColor: bluish,
                dotHeight: 10.0,
                dotWidth: 15.0,
                expansionFactor: 3,
                spacing: 6,
              ),
            ),
            const Spacer(),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(bluish),
                elevation: MaterialStateProperty.all(8.0),
              ),
              onPressed: () {
                AppCubit.get(context).finishPageView(
                    context: context, controller: onBoardingController);
              },
              child: Text(
                AppCubit.get(context).isLastPageView ? 'Finish' : 'Next',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      );
}
