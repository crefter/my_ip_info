import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ip_info/app/di.dart';
import 'package:my_ip_info/features/info/src/bloc/ip/ip_bloc.dart';
import 'package:my_ip_info/features/info/src/bloc/user_information/user_information_bloc.dart';
import 'package:my_ip_info/features/info/widget/ip_text_widget.dart';
import 'package:my_ip_info/features/info/widget/user_information_widget.dart';

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
          )..add(IpLoad()),
        ),
        BlocProvider<UserInformationBloc>(
          create: (_) => UserInformationBloc(
            repository: di.userInformationRepository,
          ),
        )
      ],
      child: Scaffold(
        appBar: AppBar(
          title: const Row(
            children: [
              Icon(Icons.person_outline),
              Text('Ip info'),
            ],
          ),
        ),
        body: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: IpTextWidget()),
            SliverToBoxAdapter(child: UserInformationWidget()),
          ],
        ),
      ),
    );
  }
}
