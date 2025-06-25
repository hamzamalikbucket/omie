import 'package:flutter/material.dart';

import 'core/config/app_config.dart';
import 'main.dart' as runner;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  AppConfig.setFlavor(Flavor.staging);

  runner.main();
}
