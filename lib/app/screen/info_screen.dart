import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:my_ip_info/app/di.dart';
import 'package:my_ip_info/features/info/src/bloc/ip/ip_bloc.dart';
import 'package:my_ip_info/features/info/src/bloc/user_information/user_information_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class InfoScreen extends StatelessWidget {
  const InfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<IpBloc>(
          create: (_) => IpBloc(
            ipRepository: di.ipRepository,
          ),
        ),
        BlocProvider<UserInformationBloc>(
          create: (_) => UserInformationBloc(
            repository: di.userInformationRepository,
          ),
        )
      ],
      child: Scaffold(
        appBar: AppBar(),
        body: Container(
          color: Colors.blue,
          child: const Center(child: Text('Info screen')),
        ),
      ),
    );
  }
}
