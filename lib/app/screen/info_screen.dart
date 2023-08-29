import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ip_info/app/di.dart';
import 'package:my_ip_info/core/widgets/theme_mode_button.dart';
import 'package:my_ip_info/features/info/src/bloc/ip/ip_bloc.dart';
import 'package:my_ip_info/features/info/src/bloc/user_information/user_information_bloc.dart';
import 'package:my_ip_info/features/info/widget/ip_text_widget.dart';
import 'package:my_ip_info/features/info/widget/user_information_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          title: Row(
            children: [
              const Icon(Icons.person_outline),
              Text(AppLocalizations.of(context).titleAppBarInfoPage),
            ],
          ),
          actions: const [
            ThemeModeButton(),
          ],
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
