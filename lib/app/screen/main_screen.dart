import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_ip_info/app/router/router.gr.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

@RoutePage()
class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: AutoTabsRouter(
        routes: const [
          InfoRoute(),
          MapRoute(),
        ],
        builder: (innerContext, child) {
          final router = AutoTabsRouter.of(innerContext);
          return Scaffold(
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: router.activeIndex,
              onTap: (index) => router.setActiveIndex(index),
              items: [
                BottomNavigationBarItem(
                  icon: const Icon(
                    Icons.info_outline,
                  ),
                  label: AppLocalizations.of(context).titleBNBInfoPage,
                ),
                BottomNavigationBarItem(
                  icon: const Icon(Icons.map_outlined),
                  label: AppLocalizations.of(context).titleBNBMapPage,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
