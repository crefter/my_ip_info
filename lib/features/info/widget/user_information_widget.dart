import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ip_info/core/text_style_ext.dart';
import 'package:my_ip_info/features/info/src/bloc/user_information/user_information_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

const double _gapBetweenElements = 12.0;

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInformationBloc, UserInformationState>(
      builder: (_, state) {
        var appLocalizations = AppLocalizations.of(context);
        return switch (state) {
          UserInformationInitial() => const Center(
              child: CircularProgressIndicator(),
            ),
          UserInformationLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          UserInformationLoaded(userInformation: var userInformation) => Column(
              children: [
                _CenteredRowWidget(
                  textRows: [
                    userInformation.country,
                    userInformation.countryCode,
                  ],
                  description: appLocalizations.country,
                ),
                const SizedBox(height: _gapBetweenElements),
                _CenteredRowWidget(
                  textRows: [
                    userInformation.regionName,
                    userInformation.region,
                  ],
                  description: appLocalizations.region,
                ),
                const SizedBox(height: _gapBetweenElements),
                _CenteredRowWidget(
                  textRows: [
                    userInformation.city,
                    userInformation.zip,
                  ],
                  description: appLocalizations.city,
                ),
                const SizedBox(height: _gapBetweenElements),
                _CenteredRowWidget(
                  textRows: [
                    userInformation.currency,
                  ],
                  description: appLocalizations.currency,
                ),
              ],
            ),
          UserInformationError(error: String error) => Center(
              child: Text(error),
            ),
        };
      },
    );
  }
}

class _CenteredRowWidget extends StatelessWidget {
  const _CenteredRowWidget({
    required this.textRows,
    required this.description,
  });

  final List<String> textRows;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '$description:',
          style: Theme.of(context).textTheme.header,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              textRows.join(', '),
              style: Theme.of(context).textTheme.mainText,
            ),
          ],
        ),
      ],
    );
  }
}
