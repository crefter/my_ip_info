import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ip_info/core/text_style_ext.dart';
import 'package:my_ip_info/features/info/src/bloc/ip/ip_bloc.dart';
import 'package:my_ip_info/features/info/src/bloc/user_information/user_information_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class IpTextWidget extends StatelessWidget {
  const IpTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 32),
        BlocConsumer<IpBloc, IpState>(
          listener: (context, state) {
            if (state is IpLoaded) {
              context.read<UserInformationBloc>().add(
                    UserInformationLoad(ip: state.ip),
                  );
            }
          },
          builder: (_, state) {
            return switch (state) {
              IpInitial() => const CircularProgressIndicator(),
              IpLoaded(ip: String ip) => Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "${AppLocalizations.of(context).ip}: ",
                      style: Theme.of(context).textTheme.header,
                    ),
                    Text(
                      ip,
                      style: Theme.of(context).textTheme.header,
                    ),
                  ],
                ),
              IpError(message: var message) => Center(
                  child: Text(message),
                ),
            };
          },
        ),
        BlocBuilder<UserInformationBloc, UserInformationState>(
          builder: (_, state) {
            return switch (state) {
              UserInformationLoaded(userInformation: var userInformation) =>
                userInformation.proxy
                    ? const Text('(proxy)')
                    : const SizedBox.shrink(),
              _ => const SizedBox.shrink(),
            };
          },
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}
