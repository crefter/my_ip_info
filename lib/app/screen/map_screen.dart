import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';

@RoutePage()
class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red,
      child: const Center(child: Text('Map screen')),
    );
  }
}
