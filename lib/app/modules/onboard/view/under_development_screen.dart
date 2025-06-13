import 'package:flutter/material.dart';

import '../../../core/widgets/app_bar/custom_app_bar.dart';
import '../../../utils/services/app_state.dart';

final class UnderDevelopmentScreen extends StatelessWidget {
  final bool showLeading;
  const UnderDevelopmentScreen({super.key, this.showLeading = true});

  @override
  Scaffold build(BuildContext context) => Scaffold(
    appBar: CustomAppBar(
      appState.localization.underDevelopment,
      showLeading: showLeading,
    ),
    body: Center(child: Text(appState.localization.comingSoon)),
  );
}
