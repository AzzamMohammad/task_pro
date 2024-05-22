import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:task_pro/consetant/page_routes.dart';
import '../components/intro_slides.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late PageController _pageViewController;
  late bool _lastPage;

  @override
  void initState() {
    _pageViewController = PageController(initialPage: 0);
    _lastPage = false;
    _pageViewController.addListener(_listenToPageView);
    super.initState();
  }

  void _listenToPageView() {
    if (_lastPage) {
      if (_pageViewController.page! < 2) {
        setState(() {
          _lastPage = false;
        });
      }
    } else {
      if (_pageViewController.page! == 2) {
        setState(() {
          _lastPage = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _sliderBar(),
            _pageIndicator(),
            _controlBar(context),
          ],
        ),
      ),
    );
  }

  Widget _sliderBar() {
    return IntroSlides(pageViewController: _pageViewController);
  }

  Widget _pageIndicator() {
    return SmoothPageIndicator(
      controller: _pageViewController,
      count: 3,
      effect: WormEffect(
        offset: 10.w,
        dotHeight: 10.h,
        dotWidth: 15.h,
      ),
      onDotClicked: (index) {
        onDotClicked(index);
      },
    );
  }

  Widget _controlBar(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: _lastPage
          ? _getStartButton()
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _skipButton(),
                _nextSlideButton(),
              ],
            ),
    );
  }

  Widget _getStartButton() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: FilledButton(
        onPressed: (){
          onTapStart();
        },
        style: ButtonStyle(
          maximumSize: MaterialStateProperty.all<Size>(Size(200.w, 50.h)),
          minimumSize: MaterialStateProperty.all<Size>(Size(200.w, 50.h)),
        ),
        child: Text(
          AppLocalizations.of(context)!.start,
          style: TextStyle(fontSize: 15.spMin),
        ),
      ),
    );
  }

  Widget _nextSlideButton() {
    return FilledButton(
      onPressed: () async {
        await onTapNext();
      },
      child: Text(
        AppLocalizations.of(context)!.next,
        style: TextStyle(fontSize: 15.spMin),
      ),
    );
  }

  Widget _skipButton() {
    return TextButton(
      onPressed: () {
        onTapSkip();
      },
      child: Text(
        AppLocalizations.of(context)!.skip,
        style: TextStyle(fontSize: 15.spMin, color: Colors.grey),
      ),
    );
  }

  Future<void> onTapNext() async {
    await _pageViewController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
    );
  }

  Future<void> onTapSkip() async {
    await _pageViewController.animateToPage(
      2,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeIn,
    );
  }

  Future<void> onDotClicked(int index) async {
    await _pageViewController.animateToPage(
      index,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInCirc,
    );
  }

  void onTapStart(){
    Navigator.of(context).pushNamedAndRemoveUntil(PageRoutes.loginScreen, (route) => false);
  }
}
