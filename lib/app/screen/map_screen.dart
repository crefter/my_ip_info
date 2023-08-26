import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ip_info/app/di.dart';
import 'package:my_ip_info/features/map/src/bloc/route_bloc.dart';
import 'package:my_ip_info/features/map/widget/map_widget.dart';

@RoutePage()
class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RouteBloc>(
      create: (_) => RouteBloc(
        repository: di.routeRepository,
      )..add(RouteLoad()),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Icon(Icons.map_outlined),
              Text('Map'),
            ],
          ),
        ),
        body: Center(
          child: MapWidget(),
        ),
      ),
    );
  }
}
