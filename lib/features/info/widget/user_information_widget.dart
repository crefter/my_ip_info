import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_ip_info/core/text_style_ext.dart';
import 'package:my_ip_info/features/info/src/bloc/user_information/user_information_bloc.dart';

const double _gapBetweenElements = 12.0;

class UserInformationWidget extends StatelessWidget {
  const UserInformationWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserInformationBloc, UserInformationState>(
      builder: (_, state) {
        return switch (state) {
          UserInformationInitial() => const Center(
              child: CircularProgressIndicator(),
            ),
          UserInformationLoading() => const Center(
              child: CircularProgressIndicator(),
            ),
          UserInformationLoaded(userInformation: var userInformation) => Column(
              children: [
                CenteredRowWidget(
                  textRows: [
                    userInformation.country,
                    userInformation.countryCode
                  ],
                  description: 'Country',
                ),
                const SizedBox(height: _gapBetweenElements),
                CenteredRowWidget(
                  textRows: [
                    userInformation.regionName,
                    userInformation.region
                  ],
                  description: 'Region',
                ),
                const SizedBox(height: _gapBetweenElements),
                CenteredRowWidget(
                  textRows: [userInformation.city, userInformation.zip],
                  description: 'City',
                ),
                const SizedBox(height: _gapBetweenElements),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
                ),
                CenteredRowWidget(
                  textRows: [userInformation.currency],
                  description: 'Currency',
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

class CenteredRowWidget extends StatelessWidget {
  const CenteredRowWidget({
    super.key,
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
          style: Theme.of(context).textTheme.description,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(textRows.join(', ')),
          ],
        ),
      ],
    );
  }
}
