import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:lottie/lottie.dart';
import '../../core/constants/app_colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, required this.onFinished});
  final VoidCallback onFinished;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  final Map<String, LottieComposition> _lottieCache = {};

  final List<OnboardingPage> _pages = const [
    OnboardingPage(
      lottieAsset: 'assets/lottie/Burger making animation.json',
      title: 'Smart Pantry',
      description: 'Track all your ingredients and never run out of essentials. Get smart notifications before items expire.',
    ),
    OnboardingPage(
      lottieAsset: 'assets/lottie/Prepare Food.json',
      title: 'Plan Your Meals',
      description: 'Discover recipes based on what you have. Create weekly meal plans and get automated shopping lists.',
    ),
    OnboardingPage(
      lottieAsset: 'assets/lottie/Grocery shopping bag pickup and delivery.json',
      title: 'Food Giveaway',
      description: 'Save money and help the planet by minimizing food waste. Track savings and see your environmental impact.',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _preloadLottieAnimations();
  }

  Future<void> _preloadLottieAnimations() async {
    for (final page in _pages) {
      try {
        final composition = await AssetLottie(page.lottieAsset).load();
        _lottieCache[page.lottieAsset] = composition;
      } catch (e) {
        // Handle error silently
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _pages.length - 1) {
      _controller.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.easeOutCubic);
    } else {
      widget.onFinished();
    }
  }

  void _skipToEnd() {
    widget.onFinished();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.iceberg,
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(top: 4, right: 8),
                child: TextButton(
                  onPressed: _skipToEnd,
                  child: Text(
                    'Skip',
                    style: TextStyle(color: AppColors.blueGray, fontSize: 16, fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemCount: _pages.length,
                itemBuilder: (context, index) {
                  return _OnboardingPageView(
                    key: ValueKey(index),
                    page: _pages[index],
                    composition: _lottieCache[_pages[index].lottieAsset],
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _PageIndicator(currentPage: _currentPage, pageCount: _pages.length),
                  _NextButton(
                    isLast: _currentPage == _pages.length - 1,
                    onPressed: _nextPage,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage {
  const OnboardingPage({required this.lottieAsset, required this.title, required this.description});
  final String lottieAsset;
  final String title;
  final String description;
}

class _OnboardingPageView extends StatefulWidget {
  const _OnboardingPageView({super.key, required this.page, this.composition});
  final OnboardingPage page;
  final LottieComposition? composition;

  @override
  State<_OnboardingPageView> createState() => _OnboardingPageViewState();
}

class _OnboardingPageViewState extends State<_OnboardingPageView> with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    // Slight delay before starting to avoid lag on page change
    Future.microtask(() => _animController.forward());
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double lottieSize = screenWidth * 0.85;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeScaleTransition(
            animation: CurvedAnimation(
              parent: _animController,
              curve: Curves.easeOut,
            ),
            child: RepaintBoundary(
              child: SizedBox(
                width: lottieSize,
                height: lottieSize,
                child: widget.composition != null
                    ? Lottie(
                        composition: widget.composition!,
                        fit: BoxFit.contain,
                        repeat: true,
                        animate: true,
                        frameRate: FrameRate(30),
                        options: LottieOptions(
                          enableMergePaths: true,
                        ),
                      )
                    : Lottie.asset(
                        widget.page.lottieAsset,
                        fit: BoxFit.contain,
                        repeat: true,
                        animate: true,
                        frameRate: FrameRate(30),
                        options: LottieOptions(
                          enableMergePaths: true,
                        ),
                      ),
              ),
            ),
          ),
          const SizedBox(height: 48),
          FadeScaleTransition(
            animation: CurvedAnimation(
              parent: _animController,
              curve: const Interval(0.3, 1.0, curve: Curves.easeOut),
            ),
            child: Text(
              widget.page.title,
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.blueGray,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          FadeScaleTransition(
            animation: CurvedAnimation(
              parent: _animController,
              curve: const Interval(0.5, 1.0, curve: Curves.easeOut),
            ),
            child: Text(
              widget.page.description,
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: AppColors.blueGray.withOpacity(0.8),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({required this.currentPage, required this.pageCount});
  final int currentPage;
  final int pageCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        pageCount,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.only(right: 8),
          width: currentPage == index ? 28 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index ? AppColors.blueGray : AppColors.powderBlue.withOpacity(0.4),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}

class _NextButton extends StatelessWidget {
  const _NextButton({required this.isLast, required this.onPressed});
  final bool isLast;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: AppColors.blueGray,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(color: AppColors.blueGray.withOpacity(0.3), blurRadius: 12, spreadRadius: 1),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(28),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: isLast ? 32 : 20, vertical: 14),
            child: AnimatedCrossFade(
              duration: const Duration(milliseconds: 250),
              crossFadeState: isLast ? CrossFadeState.showFirst : CrossFadeState.showSecond,
              firstCurve: Curves.easeInOut,
              secondCurve: Curves.easeInOut,
              sizeCurve: Curves.easeInOut,
              alignment: Alignment.center,
              firstChild: SizedBox(
                width: 140,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Get Started',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
              secondChild: SizedBox(
                width: 140,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Next',
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

