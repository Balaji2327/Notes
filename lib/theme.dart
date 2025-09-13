// theme_manager.dart
import 'package:flutter/material.dart';

class ThemeManager {
  static ValueNotifier<ThemeMode> themeNotifier =
      ValueNotifier(ThemeMode.system);
}
