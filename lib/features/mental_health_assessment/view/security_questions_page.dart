import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/theme/app_theme.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [SecurityQuestionsPage] - Security Questions page
/// This page allows users to select a security question and provide an answer
/// as part of the comprehensive mental health assessment flow
class SecurityQuestionsPage extends StatelessWidget {
  const SecurityQuestionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const SecurityQuestionsView(),
    );
  }
}

/// [SecurityQuestionsView] - The main view for security questions selection
/// Displays security question options with radio buttons and an input field for the answer
class SecurityQuestionsView extends StatefulWidget {
  const SecurityQuestionsView({super.key});

  @override
  State<SecurityQuestionsView> createState() => _SecurityQuestionsViewState();
}

class _SecurityQuestionsViewState extends State<SecurityQuestionsView> {
  /// [_SecurityQuestionsViewState] Security question options
  static const List<String> _securityQuestions = [
    'What was the name of your elementary School?',
    'What is the official legal last name of your mother?',
    'What was the first name of your first pet you owned?',
  ];

  String? _selectedQuestion;
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // [_SecurityQuestionsViewState] Set default selected question
    _selectedQuestion = _securityQuestions[
        1]; // "What is the official legal last name of your mother?" is selected by default in Figma
  }

  @override
  void dispose() {
    _answerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [SecurityQuestionsView] Navigate to next step when continue is pressed
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          Navigator.of(context).pushNamed(AppRoutes.phoneOtpSetup);
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: const Color(0xFFFFFFFF),
            body: SafeArea(
              child: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: MediaQuery.of(context).size.height -
                        MediaQuery.of(context).padding.top -
                        MediaQuery.of(context).padding.bottom,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      children: [
                        _buildTopNavigation(context, theme),
                        _buildTitle(theme),
                        Expanded(
                          child: _buildMainContent(context, theme, state),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// [_buildTopNavigation] - Builds the top navigation bar with back button,
  /// progress indicator, and skip option
  Widget _buildTopNavigation(BuildContext context, YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 8.h),
      child: Column(
        children: [
          // Top navigation row
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () {
                  // [_buildTopNavigation] Handle back navigation
                  print('[SecurityQuestionsView] Back button pressed');
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: 24.w,
                  height: 24.w,
                  child: SvgPicture.asset(
                    'assets/images/chevron_left.svg',
                    width: 24.w,
                    height: 24.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF533630), // Stone color from Figma
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16.w),
              // Progress bar section
              Expanded(
                child: Column(
                  children: [
                    // Progress bar
                    Container(
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE7E5E4), // Background
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Row(
                        children: [
                          // Filled portion (50%)
                          Expanded(
                            flex: 50,
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF9BB167), // Success green
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                          ),
                          // Unfilled portion (50%)
                          const Expanded(
                            flex: 50,
                            child: SizedBox(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              // Skip button
              GestureDetector(
                onTap: () {
                  // [_buildTopNavigation] Handle skip action
                  print('[SecurityQuestionsView] Skip button pressed');
                  // TODO: Handle skip action
                },
                child: Text(
                  'Skip',
                  style: theme.labelLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF533630), // Stone color
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  /// [_buildTitle] - Builds the assessment title section
  Widget _buildTitle(YouthYogaTheme theme) {
    return Container(
      width: 375.w,
      padding: EdgeInsets.fromLTRB(8.w, 0.h, 8.w, 8.h),
      child: Text(
        'Profile Setup & Account Completion',
        style: theme.bodyLarge.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          color: const Color(0xFF57534E), // Stone/60 from Figma
          height: 1.6,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  /// [_buildMainContent] - Builds the main content area with question,
  /// illustration, security questions selection, and continue button
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.h),
          // Main question text
          Text(
            "Security Questions",
            style: theme.headlineLarge.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF533630), // Stone color from Figma
              height: 1.07, // 32px line height / 30px font size
              letterSpacing: -0.012 * 30.sp, // -1.2%
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Illustration from Figma design
          _buildIllustration(),
          SizedBox(height: 24.h),
          // Security questions selection container
          _buildQuestionsContainer(context, theme, state),
          SizedBox(height: 32.h),
          // Answer input field
          _buildAnswerInput(theme),
          const Spacer(),
          // Continue button
          _buildContinueButton(context, theme, state),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildIllustration] - Builds the illustration image
  Widget _buildIllustration() {
    return SizedBox(
      width: 214.73.w,
      height: 160.h,
      child: SvgPicture.asset(
        'assets/images/security_questions_illustration.svg',
        width: 214.73.w,
        height: 160.h,
        fit: BoxFit.contain,
      ),
    );
  }

  /// [_buildQuestionsContainer] - Builds the security questions selection container
  Widget _buildQuestionsContainer(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color(0x000F172A).withOpacity(0.02),
            offset: const Offset(0, 8),
            blurRadius: 16,
          ),
          BoxShadow(
            color: const Color(0x000F172A).withOpacity(0.03),
            offset: const Offset(0, 4),
            blurRadius: 8,
          ),
        ],
      ),
      child: Column(
        children: [
          // Question options
          ..._securityQuestions.asMap().entries.map((entry) {
            final index = entry.key;
            final question = entry.value;
            final isSelected = _selectedQuestion == question;

            return Container(
              margin: EdgeInsets.only(
                  bottom: index < _securityQuestions.length - 1 ? 8.h : 0),
              child: _buildQuestionOption(question, isSelected, theme),
            );
          }),
        ],
      ),
    );
  }

  /// [_buildQuestionOption] - Builds a single security question option with radio button
  Widget _buildQuestionOption(
      String question, bool isSelected, YouthYogaTheme theme) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? const Color(0xFFF5F7EE)
            : const Color(
                0xFFFFFFFF), // Light green if selected, white otherwise
        border: Border.all(
          color: isSelected
              ? const Color(0xFF9BB167)
              : const Color(
                  0xFFE5E5E5), // Green border if selected, gray otherwise
          width: 1,
        ),
        borderRadius: BorderRadius.circular(24.r),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            // [_buildQuestionOption] Handle question selection
            print(
                '[SecurityQuestionsView] Security question selected: $question');
            setState(() {
              _selectedQuestion = question;
            });
          },
          borderRadius: BorderRadius.circular(24.r),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Row(
              children: [
                // Question text
                Expanded(
                  child: Text(
                    question,
                    style: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? const Color(0xFF3F4B29)
                          : const Color(
                              0xFF57534E), // Darker green if selected, gray otherwise
                      height: 1.375, // 22px line height / 16px font size
                      letterSpacing: -0.007 * 16.sp, // -0.7%
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                // Radio button
                Container(
                  width: 24.w,
                  height: 24.h,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected
                        ? const Color(0xFF9BB167)
                        : const Color(0xFFFFFFFF),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF9BB167)
                          : const Color(0xFFD6D3D1),
                      width: 1,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: SvgPicture.asset(
                              'assets/images/chevron_left.svg', // Using checkmark-like representation
                              width: 11.5.w,
                              height: 8.h,
                              colorFilter: const ColorFilter.mode(
                                Color(0xFFFFFFFF),
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// [_buildAnswerInput] - Builds the answer input field
  Widget _buildAnswerInput(YouthYogaTheme theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Text(
          'Enter your answer',
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF292524), // Dark text color
            height: 1.43, // 20px line height / 14px font size
            letterSpacing: -0.006 * 14.sp, // -0.6%
          ),
        ),
        SizedBox(height: 8.h),
        // Input field
        Container(
          decoration: BoxDecoration(
            color: const Color(0xFFFFFFFF), // White background
            border: Border.all(
              color: const Color(0xFFD6D3D1), // Gray border
              width: 1,
            ),
            borderRadius: BorderRadius.circular(9999.r), // Fully rounded
          ),
          child: Row(
            children: [
              // Question mark icon
              Padding(
                padding: EdgeInsets.only(left: 12.w),
                child: SvgPicture.asset(
                  'assets/images/question_mark_circle_icon.svg',
                  width: 20.w,
                  height: 20.h,
                  colorFilter: const ColorFilter.mode(
                    Color(0xFFA8A29E), // Light gray color
                    BlendMode.srcIn,
                  ),
                ),
              ),
              SizedBox(width: 8.w),
              // Text input
              Expanded(
                child: TextField(
                  controller: _answerController,
                  style: TextStyle(
                    fontFamily: 'Urbanist',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF57534E), // Gray text
                    height: 1.375, // 22px line height / 16px font size
                    letterSpacing: -0.007 * 16.sp, // -0.7%
                  ),
                  decoration: InputDecoration(
                    hintText: 'Vermillion',
                    hintStyle: TextStyle(
                      fontFamily: 'Urbanist',
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF57534E), // Gray hint text
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 0),
                  ),
                  onChanged: (value) {
                    // [_buildAnswerInput] Handle text changes
                    print('[SecurityQuestionsView] Answer changed: $value');
                  },
                ),
              ),
              SizedBox(width: 12.w),
            ],
          ),
        ),
      ],
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [_buildContinueButton] Handle continue action
          print('[SecurityQuestionsView] Continue button pressed');
          print(
              '[SecurityQuestionsView] Selected question: $_selectedQuestion');
          print('[SecurityQuestionsView] Answer: ${_answerController.text}');

          context
              .read<MentalHealthAssessmentBloc>()
              .add(const ReadyButtonPressed());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange background
          foregroundColor: const Color(0xFFFFFFFF), // White text
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r), // Fully rounded
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue',
              style: TextStyle(
                fontFamily: 'Urbanist',
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFFFFFFF), // White text
                height: 1.375, // 22px line height / 16px font size
                letterSpacing: -0.007 * 16.sp, // -0.7%
              ),
            ),
            SizedBox(width: 10.w),
            SvgPicture.asset(
              'assets/images/arrow_right_signin_icon.svg',
              width: 20.w,
              height: 20.h,
              colorFilter: const ColorFilter.mode(
                Color(0xFFFFFFFF), // White color for the icon
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
