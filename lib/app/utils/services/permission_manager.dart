import 'package:permission_handler/permission_handler.dart';

import '../../core/models/custom_exceptions.dart';
import '../../core/widgets/dialog/custom_dialog.dart';
import '../extensions/navigation_extension.dart';
import '../manager/navigation_manager.dart';
import 'app_state.dart';

final class PermissionManager {
  bool _isDialogVisible = false;

  bool get isDialogVisible => _isDialogVisible;

  Future<bool> askPermissions(List<Permission> permissions,
      {final bool isRequired = true,
      final String message = "",
      bool shouldDialogPopOnYesTap = true}) async {
    try {
      final permissionsStatus = await permissions.request();
      for (final permission in permissions) {
        if (permissionsStatus[permission] == PermissionStatus.denied) {
          PermissionNotGrantedException(permission);
        } else if (permissionsStatus[permission] ==
            PermissionStatus.permanentlyDenied) {
          throw PermissionPermanentDeniedException(permission);
        }
      }
      return true;
    } on PermissionPermanentDeniedException catch (_) {
      if (!isRequired) return true;
      if (_isDialogVisible) {
        _isDialogVisible = false;
        NavigationManager.navigatorKey.currentContext?.pop();
      } else {
        _isDialogVisible = true;
        String msg = message;
        final String askedPermissions = permissions
            .map((e) => "$e".replaceAll("Permission.", ""))
            .join(", ");
        if (msg.isEmpty) {
          msg =
              "${appState.localization.pleaseGrant} $askedPermissions ${(permissions.length == 1) ? appState.localization.permissions : appState.localization.permissions} ${appState.localization.fromSettings}";
        }
        CustomDialog.instance.showAskRequiredPermissionsDialog(() async {
          _isDialogVisible = false;
          if (isRequired) await openAppSettings();
        }, msg, shouldDialogPopOnYesTap: shouldDialogPopOnYesTap);
      }
      return false;
    } on PermissionNotGrantedException catch (_) {
      await askPermissions(permissions);
    } catch (e) {
      return false;
    }
    return false;
  }
}
