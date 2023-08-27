import 'package:flutter/material.dart';

class ThemeWidget extends InheritedWidget {
  ThemeWidget({
    Key? key,
    required Widget child,
  })
      : super(key: key, child: child);

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.light);

  static ThemeWidget of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<
        ThemeWidget>() as ThemeWidget;
  }

  void toggleTheme() {
    if (themeMode.value == ThemeMode.light) {
      themeMode.value = ThemeMode.dark;
    } else {
      themeMode.value = ThemeMode.light;
    }
  }

  @override
  bool updateShouldNotify(ThemeWidget oldWidget) {
    return themeMode != oldWidget.themeMode;
  }
}
