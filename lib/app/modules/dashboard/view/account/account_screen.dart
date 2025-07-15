import 'package:flutter/material.dart';

import '../../../../utils/services/app_state.dart';
import '../../../auth/view/login/login_screen.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return appState.userId.isEmpty
        ? LoginScreen()
        : Center(child: Text("Manage Your Profile"));
  }
}
