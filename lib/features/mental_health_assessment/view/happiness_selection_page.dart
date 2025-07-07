import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/routes/app_routes.dart';
import '../bloc/mental_health_assessment_bloc.dart';

/// [HappinessSelectionPage] - Happiness selection page
/// This page allows users to select things that make them happy
/// as part of the comprehensive mental health assessment flow
class HappinessSelectionPage extends StatelessWidget {
  const HappinessSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MentalHealthAssessmentBloc(),
      child: const HappinessSelectionView(),
    );
  }
}

/// [HappinessSelectionView] - The main view for happiness selection
/// Displays happiness options with search functionality and tag selection
class HappinessSelectionView extends StatefulWidget {
  const HappinessSelectionView({super.key});

  @override
  State<HappinessSelectionView> createState() => _HappinessSelectionViewState();
}

class _HappinessSelectionViewState extends State<HappinessSelectionView> {
  /// [_HappinessSelectionViewState] Search controller for the search field
  final TextEditingController _searchController = TextEditingController();

  /// [_HappinessSelectionViewState] Track if search modal is visible
  bool _isSearchModalVisible = false;

  /// [_HappinessSelectionViewState] All available happiness options
  static const List<String> _allHappinessOptions = [
    'Altruism',
    'Curiosity',
    'Dialogue',
    'Mastery',
    'Creation',
    'Empathy',
    'Progress',
    'Connection',
    'Growth',
    'Clarity',
    'Playfulness',
    'Improvement',
    'Relevance',
    'Collaboration',
    'Versatility',
    'Challenge',
    'Validation',
    'Impact',
    'Exploration',
    'Evolution',
    'Learning',
    'Fulfillment',
  ];

  /// [_HappinessSelectionViewState] Filter happiness options based on search
  List<String> _getFilteredOptions() {
    final searchTerm = _searchController.text.toLowerCase();
    if (searchTerm.isEmpty) {
      return _allHappinessOptions;
    }
    return _allHappinessOptions
        .where((option) => option.toLowerCase().contains(searchTerm))
        .toList();
  }

  /// [_HappinessSelectionViewState] Show search modal from bottom
  void _showSearchModal() {
    setState(() {
      _isSearchModalVisible = true;
    });
  }

  /// [_HappinessSelectionViewState] Hide search modal
  void _hideSearchModal() {
    setState(() {
      _isSearchModalVisible = false;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = YouthYogaTheme.of(context);

    return BlocListener<MentalHealthAssessmentBloc,
        MentalHealthAssessmentState>(
      listener: (context, state) {
        // [HappinessSelectionView] Navigate to next step when continue is pressed
        if (state.status == MentalHealthAssessmentStatus.navigateToAssessment) {
          Navigator.of(context).pushNamed(AppRoutes.stressLevelSelection);
        }
      },
      child:
          BlocBuilder<MentalHealthAssessmentBloc, MentalHealthAssessmentState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: theme.primaryBackground,
            body: SafeArea(
              child: Stack(
                children: [
                  Column(
                    children: [
                      _buildTopNavigation(context, theme),
                      _buildTitle(theme),
                      Expanded(
                        child: _buildMainContent(context, theme, state),
                      ),
                    ],
                  ),
                  // [HappinessSelectionView] Search modal overlay
                  if (_isSearchModalVisible)
                    _buildSearchModal(context, theme, state),
                ],
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
          // Top navigation row with back button, progress bar, and skip
          Row(
            children: [
              // Back button
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
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
              // Progress bar section - showing 50% completion as per Figma
              Expanded(
                child: Column(
                  children: [
                    // Progress bar container
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
                  // [HappinessSelectionView] Handle skip action - navigate to next step
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
        'Comprehensive Mental Health Assessment',
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
  /// search functionality, happiness options, and continue button
  Widget _buildMainContent(BuildContext context, YouthYogaTheme theme,
      MentalHealthAssessmentState state) {
    final filteredOptions = _getFilteredOptions();

    return Container(
      width: 343.w,
      margin: EdgeInsets.symmetric(horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 0.h),
          // Main question text
          Text(
            "What are the things that make you happy?",
            style: theme.headlineLarge.copyWith(
              fontSize: 30.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF533630), // Stone color from Figma
              height: 1.27,
              letterSpacing: -0.013 * 30.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 24.h),
          // Search section
          _buildSearchSection(theme, filteredOptions.length),
          SizedBox(height: 16.h),
          // Happiness options
          Expanded(
            child:
                _buildHappinessOptions(context, theme, state, filteredOptions),
          ),
          // Selected tags section
          if (state.selectedHappinessItems.isNotEmpty)
            _buildSelectedTags(context, theme, state),
          SizedBox(height: 24.h),
          // Continue button
          _buildContinueButton(context, theme),
          SizedBox(height: 32.h),
        ],
      ),
    );
  }

  /// [_buildSearchSection] - Builds the search section with total count
  Widget _buildSearchSection(YouthYogaTheme theme, int totalCount) {
    return Column(
      children: [
        // Search header with total count and search button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Total count
            Text(
              '$totalCount Total',
              style: theme.labelLarge.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF533630), // Stone color
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
            // Search button
            GestureDetector(
              onTap: () {
                // [HappinessSelectionView] Show search modal
                _showSearchModal();
              },
              child: Row(
                children: [
                  Text(
                    'Search',
                    style: theme.labelLarge.copyWith(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF926247), // Brand color
                      height: 1.375,
                      letterSpacing: -0.007 * 16.sp,
                    ),
                  ),
                  SizedBox(width: 10.w),
                  SvgPicture.asset(
                    'assets/images/search_magnifying_glass_icon.svg',
                    width: 20.w,
                    height: 20.w,
                    colorFilter: const ColorFilter.mode(
                      Color(0xFF926247), // Brand color
                      BlendMode.srcIn,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        // Search input field (hidden initially, shown when search is tapped)
        // TODO: Implement search field visibility toggle
      ],
    );
  }

  /// [_buildHappinessOptions] - Builds the happiness options grid
  Widget _buildHappinessOptions(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
    List<String> options,
  ) {
    return SingleChildScrollView(
      child: Wrap(
        spacing: 8.w,
        runSpacing: 8.h,
        children: options.map((option) {
          final isSelected = state.selectedHappinessItems.contains(option);
          return _buildHappinessOption(context, theme, option, isSelected);
        }).toList(),
      ),
    );
  }

  /// [_buildHappinessOption] - Builds individual happiness option button
  Widget _buildHappinessOption(
    BuildContext context,
    YouthYogaTheme theme,
    String option,
    bool isSelected,
  ) {
    Color backgroundColor;
    Color textColor;
    Color? borderColor;

    // [_buildHappinessOption] Set colors based on selection state and option
    if (isSelected) {
      // Selected states have different colors based on the option
      switch (option) {
        case 'Dialogue':
          backgroundColor = const Color(0xFFFFFBEB); // Light yellow
          textColor = const Color(0xFFFBBF24); // Yellow
          borderColor = const Color(0xFFFBBF24);
          break;
        case 'Creation':
        case 'Curiosity':
          backgroundColor = const Color(0xFFF5F7EE); // Light green
          textColor = const Color(0xFF9BB167); // Green
          borderColor = const Color(0xFF9BB167);
          break;
        case 'Growth':
          backgroundColor = const Color(0xFFFFF7ED); // Light orange
          textColor = const Color(0xFFFB923C); // Orange
          borderColor = const Color(0xFFFB923C);
          break;
        case 'Improvement':
          backgroundColor = const Color(0xFFFAF5FF); // Light purple
          textColor = const Color(0xFFC084FC); // Purple
          borderColor = const Color(0xFFC084FC);
          break;
        default:
          backgroundColor = const Color(0xFFF5F7EE); // Default light green
          textColor = const Color(0xFF9BB167); // Default green
          borderColor = const Color(0xFF9BB167);
      }
    } else {
      // Unselected state
      backgroundColor = const Color(0xFFF6F6F6); // Light gray
      textColor = const Color(0xFF57534E); // Dark gray
      borderColor = const Color(0xFFE5E5E5); // Light border
    }

    return GestureDetector(
      onTap: () {
        // [HappinessSelectionView] Handle happiness option selection
        context
            .read<MentalHealthAssessmentBloc>()
            .add(HappinessItemToggled(option));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(9999.r),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 1)
              : Border.all(color: const Color(0xFFE5E5E5), width: 1),
        ),
        child: Text(
          option,
          style: TextStyle(
            fontFamily: 'Urbanist',
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: textColor,
            height: 1.375,
            letterSpacing: -0.007 * 16.sp,
          ),
        ),
      ),
    );
  }

  /// [_buildSelectedTags] - Builds the selected tags section
  Widget _buildSelectedTags(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
  ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Selected label
          Text(
            'Selected:',
            style: theme.labelLarge.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF57534E), // Stone color
              height: 1.43,
              letterSpacing: -0.006 * 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          // Selected tags
          Wrap(
            spacing: 8.w,
            runSpacing: 8.h,
            children: state.selectedHappinessItems.map((item) {
              return _buildSelectedTag(context, theme, item);
            }).toList(),
          ),
        ],
      ),
    );
  }

  /// [_buildSelectedTag] - Builds individual selected tag with close button
  Widget _buildSelectedTag(
    BuildContext context,
    YouthYogaTheme theme,
    String item,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(12.w, 6.h, 12.w, 6.h),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEDE2), // Light orange background
        borderRadius: BorderRadius.circular(9999.r),
        border: Border.all(
          color: const Color(0xFFF08C51), // Orange border
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Tag text
          Text(
            item,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF57534E), // Dark color
              height: 1.43,
              letterSpacing: -0.006 * 14.sp,
            ),
          ),
          SizedBox(width: 8.w),
          // Close button
          GestureDetector(
            onTap: () {
              // [HappinessSelectionView] Handle tag removal
              context
                  .read<MentalHealthAssessmentBloc>()
                  .add(HappinessItemToggled(item));
            },
            child: SvgPicture.asset(
              'assets/images/close_x_icon.svg',
              width: 16.w,
              height: 16.w,
              colorFilter: const ColorFilter.mode(
                Color(0xFF57534E), // Dark color
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildContinueButton] - Builds the continue button
  Widget _buildContinueButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [HappinessSelectionView] Handle continue action
          context
              .read<MentalHealthAssessmentBloc>()
              .add(const ReadyButtonPressed());
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51), // Orange primary
          foregroundColor: theme.primaryBackground, // White text
          padding: EdgeInsets.symmetric(
            horizontal: 20.w,
            vertical: 12.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(9999.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Continue',
              style: theme.labelLarge.copyWith(
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
              height: 20.w,
              colorFilter: ColorFilter.mode(
                theme.primaryBackground,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// [_buildSearchModal] - Builds the search modal that appears from bottom
  Widget _buildSearchModal(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
  ) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: const Color(0x7A000000), // Semi-transparent overlay
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Modal container
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              color: theme.primaryBackground,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40.r),
                topRight: Radius.circular(40.r),
              ),
            ),
            child: Column(
              children: [
                // Modal handle
                Container(
                  width: 64.w,
                  height: 5.h,
                  margin: EdgeInsets.only(top: 12.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE7E5E4),
                    borderRadius: BorderRadius.circular(2.5.r),
                  ),
                ),
                SizedBox(height: 19.h),
                // Modal content
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Column(
                    children: [
                      // Header
                      _buildModalHeader(theme),
                      SizedBox(height: 24.h),
                      // Search field
                      _buildSearchField(theme),
                      SizedBox(height: 16.h),
                      // Search results with reactive filtering
                      ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _searchController,
                        builder: (context, searchValue, child) {
                          return _buildSearchResults(context, theme, state);
                        },
                      ),
                      SizedBox(height: 24.h),
                      // Selected tags
                      if (state.selectedHappinessItems.isNotEmpty)
                        _buildModalSelectedTags(context, theme, state),
                      SizedBox(height: 24.h),
                      // Apply button
                      _buildApplyButton(context, theme),
                      SizedBox(height: 32.h),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  /// [_buildModalHeader] - Builds modal header with title and close button
  Widget _buildModalHeader(YouthYogaTheme theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Things that make me happy',
          style: theme.headlineSmall.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF292524),
            height: 1.33,
            letterSpacing: -0.008 * 18.sp,
          ),
        ),
        GestureDetector(
          onTap: _hideSearchModal,
          child: SvgPicture.asset(
            'assets/images/close_x_icon.svg',
            width: 24.w,
            height: 24.w,
            colorFilter: const ColorFilter.mode(
              Color(0xFF57534E),
              BlendMode.srcIn,
            ),
          ),
        ),
      ],
    );
  }

  /// [_buildSearchField] - Builds search input field
  Widget _buildSearchField(YouthYogaTheme theme) {
    return Container(
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
            'assets/images/search_magnifying_glass_icon.svg',
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
              controller: _searchController,
              style: theme.bodyLarge.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF57534E),
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
              decoration: InputDecoration(
                hintText: 'Search anything...',
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
    );
  }

  /// [_buildSearchResults] - Builds search results list
  Widget _buildSearchResults(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
  ) {
    final filteredOptions = _getFilteredOptions();
    final displayOptions =
        filteredOptions.take(5).toList(); // Show max 5 results

    return Column(
      children: displayOptions.map((option) {
        final isSelected = state.selectedHappinessItems.contains(option);
        return _buildSearchResultItem(context, theme, option, isSelected);
      }).toList(),
    );
  }

  /// [_buildSearchResultItem] - Builds individual search result item
  Widget _buildSearchResultItem(
    BuildContext context,
    YouthYogaTheme theme,
    String option,
    bool isSelected,
  ) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      child: GestureDetector(
        onTap: () {
          context
              .read<MentalHealthAssessmentBloc>()
              .add(HappinessItemToggled(option));
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xFFF5F7EE) : const Color(0xFFFAFAF9),
            borderRadius: BorderRadius.circular(24.r),
            border: isSelected
                ? Border.all(color: const Color(0xFF9BB167), width: 1)
                : null,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  option,
                  style: theme.bodyLarge.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF292524),
                    height: 1.375,
                    letterSpacing: -0.007 * 16.sp,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              // Checkbox
              Container(
                width: 20.w,
                height: 20.w,
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF9BB167)
                      : theme.primaryBackground,
                  borderRadius: BorderRadius.circular(10.r),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF9BB167)
                        : const Color(0xFFD6D3D1),
                    width: 1,
                  ),
                ),
                child: isSelected
                    ? Icon(
                        Icons.check,
                        color: theme.primaryBackground,
                        size: 14.sp,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// [_buildModalSelectedTags] - Builds selected tags in modal
  Widget _buildModalSelectedTags(
    BuildContext context,
    YouthYogaTheme theme,
    MentalHealthAssessmentState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Selected:',
          style: theme.labelLarge.copyWith(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF57534E),
            height: 1.43,
            letterSpacing: -0.006 * 14.sp,
          ),
        ),
        SizedBox(height: 8.h),
        Wrap(
          spacing: 8.w,
          runSpacing: 8.h,
          children: state.selectedHappinessItems.map((item) {
            return _buildSelectedTag(context, theme, item);
          }).toList(),
        ),
      ],
    );
  }

  /// [_buildApplyButton] - Builds apply button for modal
  Widget _buildApplyButton(BuildContext context, YouthYogaTheme theme) {
    return SizedBox(
      width: double.infinity,
      height: 48.h,
      child: ElevatedButton(
        onPressed: () {
          // [HappinessSelectionView] Apply selections and close modal
          _hideSearchModal();
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFF08C51),
          foregroundColor: theme.primaryBackground,
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24.r),
          ),
          elevation: 0,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Apply',
              style: theme.labelLarge.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: theme.primaryBackground,
                height: 1.375,
                letterSpacing: -0.007 * 16.sp,
              ),
            ),
            SizedBox(width: 10.w),
            Icon(
              Icons.check,
              color: theme.primaryBackground,
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
