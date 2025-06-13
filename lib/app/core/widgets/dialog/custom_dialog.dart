// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

import '../../../utils/constants/apis.dart';
import '../../../utils/constants/color_constants.dart';
import '../../../utils/constants/route_name.dart';
import '../../../utils/extensions/navigation_extension.dart';
import '../../../utils/manager/api_controller.dart';
import '../../../utils/manager/get_it_manager.dart';
import '../../../utils/manager/navigation_manager.dart';
import '../../../utils/services/app_state.dart';
import '../buttons/app_elevated_button.dart';
import '../buttons/app_outlined_buttons.dart';
import '../custom/center_loader_widget.dart';

enum DialogType {
  loader,
  logout,
  askCallType,
  askRequiredPermissions,
  leaveCall,
  consultationDone,
  downloadProgress,
  confirmation,
  subscription,
}

final class CustomDialog {
  static final CustomDialog instance = CustomDialog._();

  factory CustomDialog() => instance;

  CustomDialog._();

  /// Method to Hide Dialog from current Context
  static void hideDialog<T extends Object?>(
    BuildContext context, {
    final T? args,
  }) => context.hideDialog(args: args);

  /// Method to Hide Loader from current Context
  static void hideLoader<T extends Object?>(
    BuildContext context, {
    final T? args,
  }) => hideDialog(context, args: args);

  /// Method to Show Loader from current Context
  static void showLoader(BuildContext context) =>
      _showCustomDialog(context, DialogType.loader, "");

  static Future<void> _onSessionExpire(BuildContext context) async {
    showLoader(context);
    try {
      final Map<String, dynamic> param = {
        "params": {"user_id": appState.userId},
      };
      await getIt<APIController>().request(
        APIS.logout,
        APIMethod.post,
        param: param,
      );
    } catch (e) {
      debugPrint("Error found in _showCustomDialog => $e");
    }
    await appState.clearAllValues();
    await Future.delayed(const Duration(milliseconds: 300));
    context.pushNamedAndRemoveUntil(RouteName.authScreen);
  }

  /// Method to show Logout Widget
  static void showLogoutDialog(BuildContext context) {
    _showCustomDialog(
      context,
      DialogType.logout,
      appState.localization.yourSessionExpired,
      callMethodBeforePop: false,
      onYes: () async => _onSessionExpire(context),
    );
  }

  /// Method for handling of right dialog rendering
  static Future<void> showChildDialog({
    required BuildContext context,
    required Widget child,
    bool isDismissible = false,
  }) async => await showAdaptiveDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder: (_) => PopScope(canPop: isDismissible, child: child),
  );

  /// Method for handling of right dialog rendering
  static Future<void> _showCustomDialog(
    BuildContext context,
    DialogType dialogType,
    String message, {
    bool isDesignedDialog = false,
    bool isShowOk = true,
    bool isShowNo = false,
    bool isDismissible = false,
    bool callMethodBeforePop = true,
    bool shouldDialogPopOnYesTap = true,
    Future<void> Function()? onYes,
    Future<void> Function()? onNo,
    String? yesText,
    String? noText,
  }) async => await showAdaptiveDialog(
    context: context,
    barrierDismissible: isDismissible,
    builder:
        (context) => PopScope(
          canPop: isDismissible,
          child:
              dialogType == DialogType.loader
                  ? const BackgroundFadingSpinKitLoader()
                  : isDesignedDialog
                  ? _showDesignedMaterialAlertDialog(
                    context,
                    message: message,
                    isShowOk: isShowOk,
                    isShowNo: isShowNo,
                    callMethodBeforePop: callMethodBeforePop,
                    onYes: onYes,
                    onNo: onNo,
                    yesText: yesText,
                    noText: noText,
                  )
                  : _showMaterialAlertDialog(
                    context,
                    message: message,
                    isShowOk: isShowOk,
                    isShowNo: isShowNo,
                    shouldDialogPopOnYesTap: shouldDialogPopOnYesTap,
                    callMethodBeforePop: callMethodBeforePop,
                    onYes: onYes,
                    onNo: onNo,
                    yesText: yesText,
                    noText: noText,
                  ),
        ),
  );

  /// Method for show Material Alert Dialog
  static AlertDialog _showMaterialAlertDialog(
    BuildContext context, {
    required String message,
    required bool isShowOk,
    required bool isShowNo,
    required bool callMethodBeforePop,
    bool shouldDialogPopOnYesTap = true,
    Future<void> Function()? onYes,
    Future<void> Function()? onNo,
    String? yesText,
    String? noText,
  }) => AlertDialog.adaptive(
    title: Text(
      appState.localization.appName,
      style: const TextStyle(fontFamily: "HelveticaNeueLTArabic"),
    ),
    content: Text(
      message,
      style: const TextStyle(fontFamily: "HelveticaNeueLTArabic"),
    ),
    actions: _showMaterialActions(
      context,
      isShowOk: isShowOk,
      isShowNo: isShowNo,
      callMethodBeforePop: callMethodBeforePop,
      shouldDialogPopOnYesTap: shouldDialogPopOnYesTap,
      onYes: onYes,
      onNo: onNo,
      yesText: yesText,
      noText: noText,
    ),
  );

  /// Method for show Designed Material Alert Dialog
  static AlertDialog _showDesignedMaterialAlertDialog(
    BuildContext context, {
    required String message,
    required bool isShowOk,
    required bool isShowNo,
    required bool callMethodBeforePop,
    Future<void> Function()? onYes,
    Future<void> Function()? onNo,
    String? yesText,
    String? noText,
  }) => AlertDialog.adaptive(
    content: Text(message, textAlign: TextAlign.center),
    contentTextStyle: const TextStyle(
      fontSize: 16,
      fontFamily: "HelveticaNeueLTArabic",
      color: ColorConstants.primaryColor,
    ),
    actions: _showDesignedMaterialActions(
      context,
      isShowOk: isShowOk,
      isShowNo: isShowNo,
      callMethodBeforePop: callMethodBeforePop,
      onYes: onYes,
      onNo: onNo,
      yesText: yesText,
      noText: noText,
    ),
  );

  /// Method for show Designed Material Actions
  static List<Widget> _showMaterialActions(
    BuildContext context, {
    required bool isShowOk,
    required bool isShowNo,
    required bool callMethodBeforePop,
    bool shouldDialogPopOnYesTap = true,
    Future<void> Function()? onYes,
    Future<void> Function()? onNo,
    String? yesText,
    String? noText,
  }) => <Widget>[
    TextButton(
      child: Text(
        isShowOk
            ? appState.localization.ok
            : yesText ?? appState.localization.yes,
        style: const TextStyle(fontFamily: "HelveticaNeueLTArabic"),
      ),
      onPressed: () async {
        if (onYes != null && callMethodBeforePop) await onYes();
        if (shouldDialogPopOnYesTap) hideDialog(context);
        if (onYes != null && !callMethodBeforePop) await onYes();
      },
    ),
    if (!isShowOk && isShowNo)
      TextButton(
        child: Text(
          noText ?? appState.localization.no,
          style: const TextStyle(fontFamily: "HelveticaNeueLTArabic"),
        ),
        onPressed: () async {
          if (onNo != null && callMethodBeforePop) await onNo();
          hideDialog(context);
          if (onNo != null && !callMethodBeforePop) await onNo();
        },
      ),
  ];

  /// Method for show Material Actions
  static List<Widget> _showDesignedMaterialActions(
    BuildContext context, {
    required bool isShowOk,
    required bool isShowNo,
    required bool callMethodBeforePop,
    Future<void> Function()? onYes,
    Future<void> Function()? onNo,
    String? yesText,
    String? noText,
  }) => <Widget>[
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            child: AppElevatedButton(
              Text(
                isShowOk
                    ? appState.localization.ok
                    : yesText ?? appState.localization.yes,
                style: const TextStyle(fontFamily: "HelveticaNeueLTArabic"),
              ),
              onPressed: () async {
                if (onYes != null && callMethodBeforePop) await onYes();
                hideDialog(context);
                if (onYes != null && !callMethodBeforePop) await onYes();
              },
            ),
          ),
          if (!isShowOk && isShowNo) const SizedBox(width: 15),
          if (!isShowOk && isShowNo)
            Expanded(
              child: AppOutlinedButton(
                Text(
                  noText ?? appState.localization.no,
                  style: const TextStyle(fontFamily: "HelveticaNeueLTArabic"),
                ),
                onPressed: () async {
                  if (onNo != null && callMethodBeforePop) await onNo();
                  hideDialog(context);
                  if (onNo != null && !callMethodBeforePop) await onNo();
                },
              ),
            ),
        ],
      ),
    ),
  ];

  void showAskRequiredPermissionsDialog(
    GestureTapCallback onYes,
    String message, {
    bool shouldDialogPopOnYesTap = true,
    bool isOpenSettings = false,
  }) async {
    _showCustomDialog(
      NavigationManager.navigatorKey.currentContext!,
      DialogType.askRequiredPermissions,
      message,
      yesText: isOpenSettings ? "Allow" : "Open Settings",
      shouldDialogPopOnYesTap: shouldDialogPopOnYesTap,
      callMethodBeforePop: false,
      isShowOk: false,
      onYes: () async => onYes(),
    );
  }

  void showDownloadProgressDialog(
    final BuildContext context, {
    required final Stream<double> progressStream,
  }) async {
    await showAdaptiveDialog(
      context: context,
      barrierDismissible: false,
      builder:
          (_) => PopScope(
            canPop: false,
            child: AlertDialog.adaptive(
              title: Text(
                appState.localization.appName,
                style: const TextStyle(fontFamily: "HelveticaNeueLTArabic"),
              ),
              content: StreamBuilder(
                stream: progressStream,
                builder:
                    (context, snapshot) =>
                        (snapshot.hasData)
                            ? Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Row(
                                children: [
                                  const Gap(8),
                                  CircularProgressIndicator(
                                    value: snapshot.data,
                                  ),
                                  const Gap(30),
                                  Text(
                                    'Downloading... ${snapshot.data!.floor()}%',
                                    style: const TextStyle(
                                      fontFamily: "HelveticaNeueLTArabic",
                                    ),
                                  ),
                                ],
                              ),
                            )
                            : const SizedBox(
                              height: 75,
                              child: Center(
                                child: CircularProgressIndicator.adaptive(),
                              ),
                            ),
              ),
            ),
          ),
    );
  }

  void showConfirmationDialog(
    final BuildContext context, {

    ///  callback which will execute once you're pressed yes
    required final GestureTapCallback onConfirm,

    ///  confirmation message to show in dialog
    required final String message,
  }) {
    _showCustomDialog(
      context,
      DialogType.confirmation,
      message,
      isShowNo: true,
      isShowOk: false,
      onYes: () async => onConfirm(),
    );
  }

  void showLicenseExpireDialog({
    required final BuildContext context,
    required final String message,
    required final bool isLicenseExpired,
  }) {
    _showCustomDialog(
      context,
      DialogType.subscription,
      message,
      onYes:
          isLicenseExpired
              ? () async {
                _onSessionExpire(context);
              }
              : null,
      callMethodBeforePop: false,
    );
  }
}
