import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/utils/toast_helper.dart';
import '../../data/models/auth_models.dart';
import '../providers/auth_provider.dart';
import '../providers/user_session_provider.dart';
import '../../../profile/presentation/providers/profile_initializer_provider.dart';
import 'primary_action_button.dart';

class SignupForm extends ConsumerStatefulWidget {
  const SignupForm({super.key});

  @override
  ConsumerState<SignupForm> createState() => _SignupFormState();
}

class _SignupFormState extends ConsumerState<SignupForm> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProviderProvider.notifier).signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text,
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProviderProvider);
    final isLoading = authState.isLoading;

    // Watch profile and session providers to trigger listeners
    ref.watch(profileInitializerProvider);
    ref.watch(userSessionNotifierProvider);

    // Listen to auth state changes
    ref.listen<AsyncValue<AuthResponse?>>(authProviderProvider, (previous, next) {
      next.when(
        data: (authResponse) {
          if (authResponse != null) {
            // Show success message
            ToastHelper.showSuccess(
              context,
              'Account created successfully!',
            );
          }
        },
        error: (error, stack) {
          // Show error message
          ToastHelper.showError(
            context,
            error.toString(),
          );
        },
        loading: () {},
      );
    });

    // Listen to profile fetch and user session changes to navigate
    ref.listen(profileInitializerProvider, (previous, next) {
      next.when(
        data: (_) {
          // Profile fetch completed, check householdId and navigate
          final session = ref.read(userSessionNotifierProvider);
          if (session != null) {
            if (session.householdId == null) {
              // No household, navigate to household setup
              context.go(AppRoutes.household);
            } else {
              // Has household, navigate to pantry
              context.go(AppRoutes.pantry);
            }
          }
        },
        error: (error, stack) {
          // If profile fetch fails but user is logged in, check current session
          final session = ref.read(userSessionNotifierProvider);
          if (session != null) {
            if (session.householdId == null) {
              context.go(AppRoutes.household);
            } else {
              context.go(AppRoutes.pantry);
            }
          }
        },
        loading: () {},
      );
    });

    // Also listen to user session changes as fallback
    ref.listen(userSessionNotifierProvider, (previous, next) {
      if (previous?.accessToken == null && next?.accessToken != null) {
        // User just signed up, wait a bit for profile to fetch
        // Navigation will happen when profile fetch completes
        Future.delayed(const Duration(milliseconds: 500), () {
          if (!mounted) return;
          final session = ref.read(userSessionNotifierProvider);
          final profileAsync = ref.read(profileInitializerProvider);
          
          // If profile is already loaded, navigate immediately
          if (profileAsync.hasValue && session != null) {
            if (session.householdId == null) {
              context.go(AppRoutes.household);
            } else {
              context.go(AppRoutes.pantry);
            }
          }
        });
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _SignupFields(
            firstNameController: _firstNameController,
            lastNameController: _lastNameController,
            emailController: _emailController,
            passwordController: _passwordController,
            confirmPasswordController: _confirmPasswordController,
          ),
          const SizedBox(height: 24),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) {
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween<double>(begin: 0.98, end: 1).animate(animation),
                  child: child,
                ),
              );
            },
            child: PrimaryActionButton(
              key: const ValueKey('signup_action'),
              label: isLoading ? 'Creating account...' : 'Sign Up',
              onPressed: isLoading ? null : () => _handleSignup(),
            ),
          ),
        ],
      ),
    );
  }
}

class _SignupFields extends StatelessWidget {
  const _SignupFields({
    required this.firstNameController,
    required this.lastNameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
  });

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Expanded(
              child: _InputField(
                label: 'First Name',
                hint: 'First name',
                icon: Icons.person_outline,
                controller: firstNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _InputField(
                label: 'Last Name',
                hint: 'Last name',
                icon: Icons.person_outline,
                controller: lastNameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required';
                  }
                  return null;
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _InputField(
          label: 'Email',
          hint: 'Enter your email',
          icon: Icons.email_outlined,
          controller: emailController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter your email';
            }
            if (!value.contains('@')) {
              return 'Please enter a valid email';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _InputField(
          label: 'Password',
          hint: 'Create a password',
          icon: Icons.lock_outline,
          isPassword: true,
          controller: passwordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter a password';
            }
            if (value.length < 6) {
              return 'Password must be at least 6 characters';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        _InputField(
          label: 'Confirm Password',
          hint: 'Confirm your password',
          icon: Icons.lock_outline,
          isPassword: true,
          controller: confirmPasswordController,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please confirm your password';
            }
            if (value != passwordController.text) {
              return 'Passwords do not match';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class _InputField extends StatefulWidget {
  const _InputField({
    required this.label,
    required this.hint,
    required this.icon,
    this.isPassword = false,
    this.controller,
    this.validator,
  });

  final String label;
  final String hint;
  final IconData icon;
  final bool isPassword;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<_InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<_InputField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.inputLabel,
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(178),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.powderBlue.withAlpha(128),
              width: 1,
            ),
          ),
          child: TextFormField(
            controller: widget.controller,
            validator: widget.validator,
            obscureText: widget.isPassword && _obscureText,
            decoration: InputDecoration(
              hintText: widget.hint,
              hintStyle: AppTextStyles.inputHint,
              prefixIcon: Icon(
                widget.icon,
                color: AppColors.blueGray.withAlpha(153),
                size: 20,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: AppColors.blueGray.withAlpha(153),
                        size: 20,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              border: InputBorder.none,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }
}




