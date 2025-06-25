enum Flavor {
  development,
  staging,
  production,
}

class AppConfig {
  static Flavor? _flavor;

  static Flavor get flavor => _flavor ?? Flavor.development;

  static void setFlavor(Flavor flavor) {
    _flavor = flavor;
  }

  static String get appName {
    switch (flavor) {
      case Flavor.development:
        return 'Youth Yoga Dev';
      case Flavor.staging:
        return 'Youth Yoga Staging';
      case Flavor.production:
        return 'Youth for Yoga';
    }
  }

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

  static bool get isDebugMode {
    switch (flavor) {
      case Flavor.development:
        return true;
      case Flavor.staging:
        return true;
      case Flavor.production:
        return false;
    }
  }

  static String get bundleId {
    switch (flavor) {
      case Flavor.development:
        return 'com.youthforyoga.development';
      case Flavor.staging:
        return 'com.youthforyoga.staging';
      case Flavor.production:
        return 'com.youthforyoga';
    }
  }
}
