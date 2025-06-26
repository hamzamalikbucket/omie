import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../core/utils/responsive_utils.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/splash_bloc.dart';
import '../bloc/splash_event.dart';
import '../bloc/splash_state.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SplashBloc()..add(const SplashStarted()),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listener: (context, state) {
        if (state.status == SplashStatus.completed) {
          Navigator.of(context).pushReplacementNamed(AppRoutes.welcome);
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              stops: [0.0, 1.0],
              colors: [
                Color(0xFFF08C51), // Primary orange
                Color(0xFFE87735), // Deeper orange
              ],
            ),
          ),
          child: Stack(
            children: [
              // Top-left triangular decorative element
              Positioned(
                top: ResponsiveUtils.getResponsiveHeight(-250),
                left: ResponsiveUtils.getResponsiveWidth(-180),
                child: SvgPicture.asset(
                  'assets/images/splash_triangle.svg',
                  width: 250,
                  height: 700,
                  fit: BoxFit.contain,
                ),
              ),

              // Bottom-right triangular decorative element
              Positioned(
                top: ResponsiveUtils.getResponsiveHeight(450), // 812 - 300 + 50
                left: ResponsiveUtils.getResponsiveWidth(250), // 379 - 300 + 50
                child: Transform.rotate(
                  angle: 270, // Convert degrees to radians
                  child: SvgPicture.asset(
                    'assets/images/splash_triangle_low.svg',
                    width: 250,
                    height: 700,
                    fit: BoxFit.contain,
                  ),
                ),
              ),

              // Animated logos and branding
              BlocBuilder<SplashBloc, SplashState>(
                builder: (context, state) {
                  return _buildAnimatedContent(context, state);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedContent(BuildContext context, SplashState state) {
    // Determine the scale based on the current state
    double scale;
    switch (state.status) {
      case SplashStatus.initial:
        scale = 0.2; // Start at 20%
        break;
      case SplashStatus.scaling:
        scale = 1.0; // Scale up to 100%
        break;
      default:
        scale = 1.0; // Final size
        break;
    }

    return Center(
      child: AnimatedScale(
        duration: state.status == SplashStatus.scaling
            ? const Duration(milliseconds: 2000)
            : const Duration(milliseconds: 200),
        scale: scale,
        curve: Curves.easeOutBack,
        child: _buildCenterBranding(context),
      ),
    );
  }

  Widget _buildCenterBranding(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/images/yoga_logo_icon.svg',
              width: 25.w,
              height: 25.h,
              fit: BoxFit.fitHeight,
            ),
            SizedBox(width: 10),
            Text(
              'Omni',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w700,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
