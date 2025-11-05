import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_images.dart';
import '../widgets/login_form.dart';
import '../widgets/signup_form.dart';
import '../widgets/social_buttons.dart';
import '../../../../core/widgets/glass_toggle.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> with TickerProviderStateMixin {
  bool _isLogin = true;
  late final AnimationController _controller;
  late final AnimationController _slideController;
  late final Animation<Offset> _slideAnimation;
  late final Widget _loginForm;
  late final Widget _signupForm;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _loginForm = const LoginForm(key: ValueKey('login'));
    _signupForm = const SignupForm(key: ValueKey('signup'));
    _slideController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));
    
    // Start slide animation after a short delay
    Future.delayed(const Duration(milliseconds: 100), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _slideController.dispose();
    super.dispose();
  }

  void _toggleAuthMode() {
    setState(() {
      _isLogin = !_isLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.blueGray, AppColors.iceberg],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SlideTransition(
        position: _slideAnimation,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 450),
            curve: Curves.easeOutCubic,
            margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * (_isLogin ? 0.28 : 0.15)),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Brand text positioned relative to card
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 220),
                  curve: Curves.easeOutCubic,
                  top: _isLogin ? -160.h : -80.h,
                  left: 24.w,
                  right: 0,
                  child: IgnorePointer(
                    ignoring: !_isLogin,
                    child: AnimatedOpacity(
                      duration: const Duration(milliseconds: 200),
                      curve: Curves.easeOut,
                      opacity: _isLogin ? 1.0 : 0.0,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('WELCOME', style: AppTextStyles.titleLarge()),
                          SizedBox(height: 0.h),
                          Transform.translate(
                            offset: Offset(0, -10.h),
                            child: Text(
                              _isLogin ? 'Sign in to continue' : 'Create your account',
                              style: AppTextStyles.subtitle(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Banner stacked with card (sits slightly outside the top border)
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 240),
                  curve: Curves.easeOutCubic,
                  top: -180.h,
                  left: 200.w,
                  right: 0,
                  child: RepaintBoundary(
                    child: IgnorePointer(
                      ignoring: !_isLogin,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        opacity: _isLogin ? 1.0 : 0.0,
                        child: Center(
                          child: Image.asset(
                            AppImages.banner,
                            width: 200.w,
                            height: 200.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // White card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(32.r),
                      topRight: Radius.circular(32.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 20.r,
                        spreadRadius: 5.r,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(32.w,  32.h, 32.w, 32.h),
                      child: AnimatedSize(
                        duration: const Duration(milliseconds: 350),
                        curve: Curves.easeInOutCubic,
                        alignment: Alignment.topCenter,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            GlassToggle(
                              selectedIndex: _isLogin ? 0 : 1,
                              onChanged: (i) {
                                if ((i == 0 && !_isLogin) || (i == 1 && _isLogin)) {
                                  _toggleAuthMode();
                                }
                              },
                              labels: const ['Login', 'Sign Up'],
                            ),
                            SizedBox(height: 32.h),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 350),
                              switchInCurve: Curves.easeInOutCubic,
                              switchOutCurve: Curves.easeInOutCubic,
                              transitionBuilder: (child, animation) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(0, 0.03),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  ),
                                );
                              },
                              layoutBuilder: (currentChild, previousChildren) {
                                return Stack(
                                  alignment: Alignment.topCenter,
                                  children: [
                                    ...previousChildren,
                                    if (currentChild != null) currentChild,
                                  ],
                                );
                              },
                              child: _isLogin ? _loginForm : _signupForm,
                            ),
                            SizedBox(height: 24.h),
                            SizedBox(height: 12.h),
                            const SocialButtons(),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  }

}


