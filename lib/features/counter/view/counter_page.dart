import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/responsive_utils.dart';
import '../../../core/constants/app_constants.dart';
import '../bloc/counter_bloc.dart';
import '../bloc/counter_event.dart';
import '../bloc/counter_state.dart';

class CounterPage extends StatelessWidget {
  const CounterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CounterBloc(),
      child: const CounterView(),
    );
  }
}

class CounterView extends StatelessWidget {
  const CounterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(
          'Youth for Yoga Counter',
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(20),
          ),
        ),
        centerTitle: true,
      ),
      body: BlocListener<CounterBloc, CounterState>(
        listener: (context, state) {
          if (state.status == CounterStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Unknown error'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Center(
          child: Container(
            constraints: BoxConstraints(
              maxWidth:
                  ResponsiveUtils.isDesktop(context) ? 400.w : double.infinity,
            ),
            padding: ResponsiveUtils.getResponsivePadding(
                all: AppConstants.paddingL),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'You have pushed the button this many times:',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.getResponsiveFontSize(16),
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(20)),
                BlocBuilder<CounterBloc, CounterState>(
                  builder: (context, state) {
                    return AnimatedSwitcher(
                      duration: AppConstants.normalAnimation,
                      child: state.status == CounterStatus.loading
                          ? SizedBox(
                              width: 24.w,
                              height: 24.h,
                              child: const CircularProgressIndicator(),
                            )
                          : Text(
                              '${state.value}',
                              key: ValueKey(state.value),
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    fontSize:
                                        ResponsiveUtils.getResponsiveFontSize(
                                            48),
                                    fontWeight: FontWeight.bold,
                                    color: state.status == CounterStatus.failure
                                        ? Colors.red
                                        : null,
                                  ),
                            ),
                    );
                  },
                ),
                SizedBox(height: ResponsiveUtils.getResponsiveHeight(40)),
                _buildActionButtons(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return ResponsiveUtils.isMobile(context)
        ? Column(
            children: [
              _buildIncrementButton(context),
              SizedBox(height: ResponsiveUtils.getResponsiveHeight(16)),
              _buildDecrementButton(context),
              SizedBox(height: ResponsiveUtils.getResponsiveHeight(16)),
              _buildResetButton(context),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildIncrementButton(context),
              _buildDecrementButton(context),
              _buildResetButton(context),
            ],
          );
  }

  Widget _buildIncrementButton(BuildContext context) {
    return SizedBox(
      width: ResponsiveUtils.isMobile(context)
          ? double.infinity
          : ResponsiveUtils.getResponsiveWidth(120),
      height: ResponsiveUtils.getResponsiveHeight(48),
      child: ElevatedButton.icon(
        onPressed: () =>
            context.read<CounterBloc>().add(const CounterIncrement()),
        icon: const Icon(Icons.add),
        label: Text(
          'Increment',
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.green,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
        ),
      ),
    );
  }

  Widget _buildDecrementButton(BuildContext context) {
    return SizedBox(
      width: ResponsiveUtils.isMobile(context)
          ? double.infinity
          : ResponsiveUtils.getResponsiveWidth(120),
      height: ResponsiveUtils.getResponsiveHeight(48),
      child: ElevatedButton.icon(
        onPressed: () =>
            context.read<CounterBloc>().add(const CounterDecrement()),
        icon: const Icon(Icons.remove),
        label: Text(
          'Decrement',
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
        ),
      ),
    );
  }

  Widget _buildResetButton(BuildContext context) {
    return SizedBox(
      width: ResponsiveUtils.isMobile(context)
          ? double.infinity
          : ResponsiveUtils.getResponsiveWidth(120),
      height: ResponsiveUtils.getResponsiveHeight(48),
      child: ElevatedButton.icon(
        onPressed: () => context.read<CounterBloc>().add(const CounterReset()),
        icon: const Icon(Icons.refresh),
        label: Text(
          'Reset',
          style: TextStyle(
            fontSize: ResponsiveUtils.getResponsiveFontSize(16),
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
        ),
      ),
    );
  }
}
