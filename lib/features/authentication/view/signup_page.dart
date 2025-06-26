import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:equatable/equatable.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/bloc.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupBloc(),
      child: const SignupView(),
    );
  }
}

class SignupView extends StatefulWidget {
  const SignupView({super.key});

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;

  // Password validation states
  bool get _hasMinLength => _passwordController.text.length >= 8;
  bool get _hasNumber => _passwordController.text.contains(RegExp(r'[0-9]'));
  bool get _hasSpecialChar =>
      _passwordController.text.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
  bool get _hasUpperCase => _passwordController.text.contains(RegExp(r'[A-Z]'));

  int get _validationCount {
    int count = 0;
    if (_hasMinLength) count++;
    if (_hasNumber) count++;
    if (_hasSpecialChar) count++;
    if (_hasUpperCase) count++;
    return count;
  }

  Color _getValidationBarColor(int index) {
    final theme = YouthYogaTheme.of(context);
    final currentCount = _validationCount;

    if (currentCount == 0) {
      return theme.alternate; // Gray when no requirements met
    } else if (currentCount == 1) {
      return index == 0
          ? theme.error
          : theme.alternate; // Red for only one requirement
    } else if (currentCount == 2) {
      return index < 2
          ? theme.info
          : theme.alternate; // Light green for two requirements
    } else if (currentCount >= 3) {
      return index < currentCount
          ? theme.success
          : theme.alternate; // Green for 3+ requirements
    }
    return theme.alternate;
  }

  String get _validationText {
    final currentCount = _validationCount;
    if (currentCount == 0) return 'Enter your password';
    if (currentCount == 1) return 'Password strength: Weak ??';
    if (currentCount == 2) return 'Password strength: Good ??';
    if (currentCount == 3) return 'Password strength: Strong ??';
    return 'Password strength: Amazing! ?';
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return Scaffold(
      backgroundColor: theme.primary, // Orange background
      body: SafeArea(
        child: SizedBox(
          width: 375.w,
          height: MediaQuery.of(context).size.height -
              MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              // Logo section at the top
              _buildLogoSection(theme),

              // Main container with circular design element
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    // Circular container section - same pattern as onboarding
                    _buildCircularContainer(theme),

                    // Signup container
                    _buildSignupContainer(theme),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogoSection(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      height: 100.h,
      padding: EdgeInsets.only(top: 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Logo icon
          SvgPicture.asset(
            'assets/images/yoga_logo_icon.svg',
            width: 25.w,
            height: 25.h,
          ),
          SizedBox(width: 4.w),
          // Logo text
          Text(
            'Omie',
            style: theme.headlineLarge.copyWith(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: theme.primaryBackground,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCircularContainer(YouthYogaTheme theme) {
    return SizedBox(
      width: 375.w,
      height: 48.h,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Large decorative ellipse positioned exactly like onboarding screen
          Positioned(
            left: -253.w,
            top: 0.h,
            child: Container(
              width: 880.w,
              height: 880.w,
              decoration: BoxDecoration(
                color: theme.primaryBackground,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSignupContainer(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      height: 560.h, // Increased height for form fields
      decoration: BoxDecoration(
        color: theme.primaryBackground,
      ),
      child: Column(
        children: [
          Container(
            width: 375.w,
            padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 32.h),
            child: Column(
              children: [
                // Title section
                Column(
                  children: [
                    Text(
                      'Create an Account',
                      style: theme.headlineLarge.copyWith(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: theme.primary,
                        height: 1.27,
                        letterSpacing: -0.013 * 30.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),

                SizedBox(height: 24.h),

                // Form section
                Column(
                  children: [
                    // Email field
                    _buildEmailField(theme),

                    SizedBox(height: 24.h),

                    // Password field with validation
                    _buildPasswordField(theme),

                    SizedBox(height: 24.h),

                    // Confirm password field
                    _buildConfirmPasswordField(theme),

                    SizedBox(height: 32.h),

                    // Sign up button
                    _buildSignupButton(theme),
                  ],
                ),

                SizedBox(height: 16.h),

                // Sign in text
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.signin);
                  },
                  child: RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "Already have an account? ",
                          style: theme.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: const Color(
                                0xFF57534E), // Brown color from Figma
                            height: 1.43,
                            letterSpacing: -0.006 * 14.sp,
                          ),
                        ),
                        TextSpan(
                          text: "Sign In",
                          style: theme.bodyMedium.copyWith(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: theme.success,
                            height: 1.43,
                            letterSpacing: -0.006 * 14.sp,
                          ),
                        ),
                      ],
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

  Widget _buildEmailField(YouthYogaTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: theme.titleSmall.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524), // Dark color from Figma
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: const Color(0xFFD6D3D1), // Border color from Figma
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              SizedBox(width: 12.w),
              SvgPicture.asset(
                'assets/images/envelope_email_icon.svg',
                width: 20.w,
                height: 20.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF57534E), // Gray/60 from Figma
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextFormField(
                  controller: _emailController,
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'elementary221b@gmail.com',
                    hintStyle: theme.bodyLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                    filled: false,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField(YouthYogaTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: theme.titleSmall.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524), // Dark color from Figma
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: const Color(0xFFD6D3D1), // Border color from Figma
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              SizedBox(width: 12.w),
              SvgPicture.asset(
                'assets/images/lock_password_icon.svg',
                width: 20.w,
                height: 20.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF57534E), // Gray/60 from Figma
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextFormField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  onChanged: (value) {
                    setState(() {
                      // This will trigger rebuild and update validation bars
                    });
                  },
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Enter your password',
                    hintStyle: theme.bodyLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                    filled: false,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
                child: SvgPicture.asset(
                  'assets/images/eye_visibility_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFD6D3D1), // Gray/30 from Figma
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
          ),
        ),
        SizedBox(height: 10.h),
        // Password validation bars
        SizedBox(
          width: 343.w,
          height: 4.h,
          child: Row(
            children: List.generate(4, (index) {
              return Expanded(
                child: Container(
                  height: 4.h,
                  margin: EdgeInsets.only(right: index < 3 ? 4.w : 0),
                  decoration: BoxDecoration(
                    color: _getValidationBarColor(index),
                    borderRadius: BorderRadius.circular(1234.r),
                  ),
                ),
              );
            }),
          ),
        ),
        SizedBox(height: 8.h),
        // Validation text
        Text(
          _validationText,
          style: theme.bodyMedium.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF57534E),
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField(YouthYogaTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Confirm Password',
          style: theme.titleSmall.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524), // Dark color from Figma
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Container(
          width: 343.w,
          height: 44.h,
          decoration: BoxDecoration(
            color: theme.primaryBackground,
            border: Border.all(
              color: const Color(0xFFD6D3D1), // Border color from Figma
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r),
          ),
          child: Row(
            children: [
              SizedBox(width: 12.w),
              SvgPicture.asset(
                'assets/images/lock_password_icon.svg',
                width: 20.w,
                height: 20.h,
                colorFilter: const ColorFilter.mode(
                  Color(0xFF57534E), // Gray/60 from Figma
                  BlendMode.srcIn,
                ),
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: !_isConfirmPasswordVisible,
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                  decoration: InputDecoration(
                    hintText: 'Confirm your password',
                    hintStyle: theme.bodyLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E),
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                    filled: false,
                    fillColor: Colors.transparent,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
                  });
                },
                child: SvgPicture.asset(
                  'assets/images/eye_visibility_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFD6D3D1), // Gray/30 from Figma
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSignupButton(YouthYogaTheme theme) {
    return Container(
      width: 343.w,
      height: 44.h,
      decoration: BoxDecoration(
        color: theme.primary,
        borderRadius: BorderRadius.circular(9999.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(9999.r),
          onTap: () {
            // Validate form before proceeding
            if (_emailController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter your email address'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (_passwordController.text.isEmpty) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Please enter a password'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            if (_validationCount < 3) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password must meet at least 3 requirements'),
                  backgroundColor: Colors.orange,
                ),
              );
              return;
            }

            if (_passwordController.text != _confirmPasswordController.text) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Passwords do not match'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }

            // Show success message and navigate
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Account created successfully! ??'),
                backgroundColor: Colors.green,
              ),
            );

            // Navigate back to authentication screen or main app
            Navigator.of(context).pop();
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Sign Up',
                  style: theme.titleSmall.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.primaryBackground,
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                SvgPicture.asset(
                  'assets/images/arrow_right_signin_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    theme.primaryBackground,
                    BlendMode.srcIn,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Simple signup bloc for form validation
class SignupBloc extends Cubit<SignupState> {
  SignupBloc() : super(const SignupState());

  void emailChanged(String email) {
    emit(state.copyWith(email: email));
  }

  void passwordChanged(String password) {
    emit(state.copyWith(password: password));
  }

  void confirmPasswordChanged(String confirmPassword) {
    emit(state.copyWith(confirmPassword: confirmPassword));
  }

  void submitSignup() {
    // TODO: Implement signup logic
  }
}

class SignupState extends Equatable {
  const SignupState({
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.isSubmitting = false,
  });

  final String email;
  final String password;
  final String confirmPassword;
  final bool isSubmitting;

  SignupState copyWith({
    String? email,
    String? password,
    String? confirmPassword,
    bool? isSubmitting,
  }) {
    return SignupState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      isSubmitting: isSubmitting ?? this.isSubmitting,
    );
  }

  @override
  List<Object> get props => [email, password, confirmPassword, isSubmitting];
}
