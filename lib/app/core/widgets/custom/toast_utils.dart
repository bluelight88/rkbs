import 'package:flutter/material.dart';

import 'package:bot_toast/bot_toast.dart';

import '../../../utils/constants/asset_constants.dart';
import '../../../utils/constants/color_constants.dart';

final class ToastUtils {
  static void showSuccess({required String message, int duration = 3}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: duration),
      toastBuilder: (CancelFunc? cancelFunc) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 15,
            color: Colors.green[300],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.check, color: Colors.white, size: 30),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: Text(
                        message,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 5,
                        style: const TextStyle(
                          color: Colors.white,
                          height: 1,
                          fontFamily: AssetConstants.fontHelvetica,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showFailed({required String message, int duration = 3}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: duration),
      toastBuilder: (CancelFunc? cancelFunc) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 15,
            color: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.close, color: Colors.white, size: 30),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: RichText(
                        text: TextSpan(
                          text: message,
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1,
                            fontFamily: AssetConstants.fontHelvetica,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static void showBusy({required String message, int duration = 3}) {
    BotToast.showCustomNotification(
      duration: Duration(seconds: duration),
      toastBuilder: (CancelFunc? cancelFunc) {
        return Padding(
          padding: const EdgeInsets.all(12),
          child: Card(
            elevation: 15,
            color: Colors.orange,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.phone_callback_outlined,
                    color: Colors.white,
                    size: 30,
                  ),
                  const SizedBox(width: 20),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: 5),
                      child: RichText(
                        text: TextSpan(
                          text: message,
                          style: const TextStyle(
                            color: Colors.white,
                            height: 1,
                            fontFamily: AssetConstants.fontHelvetica,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
