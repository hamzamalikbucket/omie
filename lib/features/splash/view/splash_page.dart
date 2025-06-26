import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
              // Top-left triangular decorative element pointing toward center
              _buildTriangularDecorativeElement(
                context,
                top: ResponsiveUtils.getResponsiveHeight(-50),
                left: ResponsiveUtils.getResponsiveWidth(-140),
                rotation: 90,
                isTopLeft: true,
              ),

              // Bottom-right triangular decorative element pointing toward center
              _buildTriangularDecorativeElement(
                context,
                top: ResponsiveUtils.getResponsiveHeight(562), // 812 - 300 + 50
                left: ResponsiveUtils.getResponsiveWidth(129), // 379 - 300 + 50
                rotation: 320,
                isTopLeft: false,
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

  Widget _buildTriangularDecorativeElement(
    BuildContext context, {
    required double top,
    required double left,
    required double rotation,
    required bool isTopLeft,
  }) {
    return Positioned(
      top: top,
      left: left,
      child: Transform.rotate(
        angle: rotation * (3.14159 / 180), // Convert degrees to radians
        child: ClipPath(
          clipper: CenterPointingTriangleClipper(isTopLeft: isTopLeft),
          child: Container(
            width: ResponsiveUtils.getResponsiveWidth(200),
            height: ResponsiveUtils.getResponsiveHeight(400),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.228, 0.617), // 110.28 degrees approximation
                end: Alignment(1.007, 0.161),
                stops: [0.0, 0.7784],
                colors: [
                  Color(0x00F7A9A0), // rgba(247, 169, 160, 0)
                  Color(0xFFF08C51), // #F08C51
                ],
              ),
            ),
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
        Image.asset(
          'assets/images/logo.png',
          width: ResponsiveUtils.getResponsiveWidth(200),
          height: ResponsiveUtils.getResponsiveHeight(40),
          fit: BoxFit.fitHeight,
        ),
      ],
    );
  }
}

// Custom clipper for creating triangular shapes pointing toward center
class CenterPointingTriangleClipper extends CustomClipper<Path> {
  final bool isTopLeft;

  CenterPointingTriangleClipper({required this.isTopLeft});

  @override
  Path getClip(Size size) {
    Path path = Path();

    if (isTopLeft) {
      // Top-left triangle pointing toward bottom-right (center)
      path.moveTo(0, 0); // Top-left corner
      path.lineTo(size.width, 0); // Top edge
      path.lineTo(0, size.height); // Left edge
      path.close(); // Close the path
    } else {
      // Bottom-right triangle pointing toward top-left (center)
      path.moveTo(size.width, size.height); // Bottom-right corner
      path.lineTo(0, size.height); // Bottom edge
      path.lineTo(size.width, 0); // Right edge
      path.close(); // Close the path
    }

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
