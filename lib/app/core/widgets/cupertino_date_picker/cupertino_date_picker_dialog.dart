import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../utils/extensions/navigation_extension.dart';
import '../../../utils/services/app_state.dart';
import '../buttons/app_elevated_button.dart';
import '../custom/toast_utils.dart';

Future<dynamic> showCupertinoDatePickerDialog(
  BuildContext context, {
  required DateTime initialDateTime,
  required DateTime maximumDate,
  required DateTime minimumDate,
  CupertinoDatePickerMode mode = CupertinoDatePickerMode.date,
  void Function()? onSubmit,
}) async {
  dynamic date;
  await showCupertinoModalPopup(
    context: context,
    builder:
        (context) => Material(
          child: Container(
            height: appState.getScreenWidth(percent: 0.65),
            width: double.infinity,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: CupertinoDatePicker(
                    onDateTimeChanged: (val) => date = val,
                    initialDateTime: initialDateTime,
                    minimumDate: minimumDate,
                    mode: mode,
                    maximumDate: maximumDate,
                    maximumYear: DateTime.now().year,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: 10,
                  ),
                  child: AppElevatedButton(
                    Text("Done"),
                    onPressed: () {
                      if (date == null) {
                        return ToastUtils.showFailed(message: "Select Date");
                      }
                      context.pop();
                      if (onSubmit != null) onSubmit();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
  );
  return date;
}

final class CustomDateButton extends StatelessWidget {
  const CustomDateButton({
    required this.buttonText,
    required this.onTap,
    required this.backgroundColor,
    required this.foregroundColor,
    super.key,
    this.horizontalMargin = 0,
  });

  final double horizontalMargin;
  final String buttonText;
  final Color backgroundColor, foregroundColor;
  final void Function() onTap;

  @override
  InkWell build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(10),
    child: Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(10),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      margin: EdgeInsets.symmetric(horizontal: horizontalMargin),
      child: Text(buttonText, style: TextStyle(color: foregroundColor)),
    ),
  );
}
