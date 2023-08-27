import 'package:flutter/material.dart';
import 'package:my_ip_info/app/router/router.dart';
import 'package:my_ip_info/core/theme_widget.dart';

import 'di.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
      child: Builder(builder: (context) {
        return ValueListenableBuilder<ThemeMode>(
          valueListenable: ThemeWidget.of(context).themeMode,
          builder: (context, themeMode, _) {
            return MaterialApp.router(
              title: 'Flutter Demo',
              theme: ThemeData.light(
                useMaterial3: true,
              ),
              darkTheme: ThemeData.dark(
                useMaterial3: true,
              ),
              themeMode: themeMode,
              routerConfig: _appRouter.config(),
            );
          },
        );
      }),
    );
  }
}
