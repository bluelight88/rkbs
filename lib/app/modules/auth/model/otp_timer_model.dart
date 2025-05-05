import '../../../utils/services/util_methods.dart';

class OTPTimerModel {
  int timer;
  String mobileNumber;

  OTPTimerModel({
    required this.timer,
    required this.mobileNumber,
  });

  factory OTPTimerModel.fromJson(Map<String, dynamic> data) => OTPTimerModel(
        timer: UtilMethods.instance.intValueParser(data['otp_timer']),
        mobileNumber: UtilMethods.instance
            .emptyStringValueParser(data['physician_mobile']),
      );
}
