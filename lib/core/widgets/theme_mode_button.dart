import 'package:flutter/material.dart';
import 'package:my_ip_info/core/theme_widget.dart';

class ThemeModeButton extends StatelessWidget {
  const ThemeModeButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        ThemeWidget.of(context).toggleTheme();
      },
      icon: const Icon(
        Icons.dark_mode_outlined,
      ),
    );
  }
}
