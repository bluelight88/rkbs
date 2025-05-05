import 'package:permission_handler/permission_handler.dart';

import '../../utils/services/app_state.dart';

final class PermissionNotGrantedException implements Exception {
  final Permission permission;
  PermissionNotGrantedException(this.permission);

  @override
  String toString() => appState.localization.permissionNotGranted;
}

final class PermissionPermanentDeniedException implements Exception {
  final Permission permission;
  PermissionPermanentDeniedException(this.permission);

  @override
  String toString() => appState.localization.permissionNotGranted;
}
