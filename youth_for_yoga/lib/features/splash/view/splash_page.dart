import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/responsive_utils.dart';
import '../../../core/constants/app_constants.dart';
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
          Navigator.of(context).pushReplacementNamed(AppRoutes.counter);
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
              // Background decorative elements
              _buildDecorativeElement(
                context,
                top: ResponsiveUtils.getResponsiveHeight(491),
                left: ResponsiveUtils.getResponsiveWidth(198),
              ),
              _buildDecorativeElement(
                context,
                top: ResponsiveUtils.getResponsiveHeight(-209),
                left: ResponsiveUtils.getResponsiveWidth(-209),
              ),

              // Additional decorative containers from Figma
              _buildDecorativeContainer(
                context,
                top: ResponsiveUtils.getResponsiveHeight(491),
                left: ResponsiveUtils.getResponsiveWidth(198),
                rotation: 0,
              ),
              _buildDecorativeContainer(
                context,
                top: ResponsiveUtils.getResponsiveHeight(367),
                left: ResponsiveUtils.getResponsiveWidth(213),
                rotation: 180,
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

  Widget _buildDecorativeElement(BuildContext context,
      {double? top, double? left}) {
    return Positioned(
      top: top,
      left: left,
      child: Container(
        width: ResponsiveUtils.getResponsiveWidth(422),
        height: ResponsiveUtils.getResponsiveHeight(576),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: const Alignment(-0.228, 0.617),
            end: const Alignment(1.007, 0.161),
            stops: const [0.0, 1.0],
            colors: [
              const Color(0xFFF7A9A0).withValues(alpha: 0.0), // Transparent
              const Color(0xFFF08C51)
                  .withValues(alpha: 0.3), // Semi-transparent orange
            ],
          ),
          borderRadius:
              BorderRadius.circular(ResponsiveUtils.getResponsiveWidth(20)),
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
        Image.asset(
          'assets/images/logo.png',
          width: ResponsiveUtils.getResponsiveWidth(200),
          height: ResponsiveUtils.getResponsiveHeight(40),
          fit: BoxFit.cover,
        ),
      ],
    );
  }

  Widget _buildDecorativeContainer(
    BuildContext context, {
    required double top,
    required double left,
    required double rotation,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: rotation * (3.14159 / 180), // Convert degrees to radians
        child: Container(
          width: ResponsiveUtils.getResponsiveWidth(422),
          height: ResponsiveUtils.getResponsiveHeight(576),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment(-0.228, 0.617), // 110.28 degrees approximation
              end: Alignment(1.007, 0.161),
              stops: [0.0, 0.7784],
              colors: [
                Color(0x00F7A9A0), // rgba(247, 169, 160, 0)
                Color(0xFFF08C51), // #F08C51
              ],
            ),
            borderRadius:
                BorderRadius.circular(ResponsiveUtils.getResponsiveWidth(20)),
          ),
        ),
      ),
    );
  }
}
