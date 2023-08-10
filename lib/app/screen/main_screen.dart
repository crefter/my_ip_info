import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:my_ip_info/app/router/router.gr.dart';

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
            body: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: child,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: router.activeIndex,
              onTap: (index) => router.setActiveIndex(index),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.info_outline,
                  ),
                  label: 'Information',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.map_outlined),
                  label: 'Map',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
