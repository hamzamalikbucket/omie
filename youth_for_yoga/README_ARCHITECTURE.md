# Youth for Yoga - Architecture Guide

This Flutter app implements BLoC pattern, responsive design, and flavor configurations. Here's how to work with these features:

## ??? BLoC Architecture

### Folder Structure
```
lib/
??? core/
?   ??? config/
?   ?   ??? app_config.dart          # App configuration for flavors
?   ??? constants/
?   ?   ??? app_constants.dart       # App-wide constants
?   ??? di/
?   ?   ??? injection.dart           # Dependency injection setup
?   ??? theme/
?   ?   ??? app_theme.dart           # App theming
?   ??? utils/
?       ??? responsive_utils.dart    # Responsive design utilities
??? features/
?   ??? counter/                     # Feature-based organization
?       ??? bloc/
?       ?   ??? counter_bloc.dart    # Business logic
?       ?   ??? counter_event.dart   # Events
?       ?   ??? counter_state.dart   # States
?       ?   ??? bloc.dart           # Barrel export
?       ??? view/
?           ??? counter_page.dart    # UI components
??? main.dart                        # Main app entry
??? main_development.dart            # Development flavor entry
??? main_staging.dart               # Staging flavor entry
??? main_production.dart            # Production flavor entry
```

### Creating a New Feature with BLoC

1. **Create feature folder**: `lib/features/your_feature/`
2. **Create BLoC files**:
   ```dart
   // your_feature_event.dart
   abstract class YourFeatureEvent extends Equatable {
     const YourFeatureEvent();
     @override
     List<Object> get props => [];
   }
   
   // your_feature_state.dart
   class YourFeatureState extends Equatable {
     const YourFeatureState();
     @override
     List<Object> get props => [];
   }
   
   // your_feature_bloc.dart
   @injectable
   class YourFeatureBloc extends Bloc<YourFeatureEvent, YourFeatureState> {
     YourFeatureBloc() : super(const YourFeatureState()) {
       // Add event handlers
     }
   }
   ```

3. **Create UI**:
   ```dart
   class YourFeaturePage extends StatelessWidget {
     @override
     Widget build(BuildContext context) {
       return BlocProvider(
         create: (context) => YourFeatureBloc(),
         child: YourFeatureView(),
       );
     }
   }
   ```

## ?? Responsive Design

### Using Responsive Utils

```dart
// Check device type
if (ResponsiveUtils.isMobile(context)) {
  // Mobile layout
} else if (ResponsiveUtils.isTablet(context)) {
  // Tablet layout
} else {
  // Desktop layout
}

// Responsive sizing
Text(
  'Hello',
  style: TextStyle(
    fontSize: ResponsiveUtils.getResponsiveFontSize(16),
  ),
)

Container(
  width: ResponsiveUtils.getResponsiveWidth(200),
  height: ResponsiveUtils.getResponsiveHeight(100),
  padding: ResponsiveUtils.getResponsivePadding(all: 16),
)

// Grid with responsive columns
GridView.builder(
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: ResponsiveUtils.getCrossAxisCount(
      context,
      mobileCount: 1,
      tabletCount: 2,
      desktopCount: 3,
    ),
  ),
  // ...
)
```

### Breakpoints
- Mobile: < 600px
- Tablet: 600px - 1024px
- Desktop: > 1024px

## ?? Flavors

### Available Flavors
- **Development**: Red theme, debug features enabled
- **Staging**: Orange theme, testing environment
- **Production**: Purple theme, production environment

### Running Flavors

#### Command Line
```bash
# Development
flutter run -t lib/main_development.dart --flavor development

# Staging
flutter run -t lib/main_staging.dart --flavor staging

# Production
flutter run -t lib/main_production.dart --flavor production
```

#### VS Code
Use the debug configurations in `.vscode/launch.json`:
1. Open Run and Debug panel (Ctrl+Shift+D)
2. Select desired flavor from dropdown
3. Press F5 or click play button

### Building for Different Flavors

```bash
# Android
flutter build apk -t lib/main_production.dart --flavor production
flutter build appbundle -t lib/main_production.dart --flavor production

# iOS
flutter build ios -t lib/main_production.dart --flavor production
```

### Flavor Configuration

Each flavor has different:
- App name
- Bundle ID / Application ID
- API endpoints
- Theme colors
- Debug settings

Configure in `lib/core/config/app_config.dart`:

```dart
static String get baseUrl {
  switch (flavor) {
    case Flavor.development:
      return 'https://dev-api.youthforyoga.com';
    case Flavor.staging:
      return 'https://staging-api.youthforyoga.com';
    case Flavor.production:
      return 'https://api.youthforyoga.com';
  }
}
```

## ?? Getting Started

1. **Install dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate code** (if using injectable):
   ```bash
   flutter packages pub run build_runner build
   ```

3. **Run the app**:
   ```bash
   flutter run -t lib/main_development.dart --flavor development
   ```

## ?? Testing

```bash
# Run tests
flutter test

# Run tests with coverage
flutter test --coverage
```

## ?? Dependencies

### State Management
- `flutter_bloc`: BLoC pattern implementation
- `bloc`: Core BLoC library
- `equatable`: Value equality for events/states

### Responsive Design
- `flutter_screenutil`: Screen adaptation
- `responsive_builder`: Responsive layouts

### Dependency Injection
- `get_it`: Service locator
- `injectable`: Code generation for DI

### Flavors
- `flutter_flavorizr`: Flavor configuration

## ?? Best Practices

1. **BLoC Events**: Use descriptive names and include necessary data
2. **BLoC States**: Always extend Equatable for proper state comparison
3. **Responsive Design**: Test on different screen sizes
4. **Flavors**: Keep sensitive data out of version control
5. **Folder Structure**: Organize by features, not by file types
6. **Testing**: Write unit tests for BLoCs and widget tests for UI

## ?? Useful Commands

```bash
# Check for dependencies updates
flutter pub outdated

# Analyze code
flutter analyze

# Format code
dart format .

# Generate flavors (after updating pubspec.yaml)
flutter pub run flutter_flavorizr

# Clean build
flutter clean && flutter pub get
``` 