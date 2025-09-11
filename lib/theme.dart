// theme_manager.dart
import 'package:flutter/material.dart';

class ThemeManager {
  // notifier that holds current theme mode
  static ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);
}
