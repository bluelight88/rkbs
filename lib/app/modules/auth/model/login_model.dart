import '../../../utils/services/util_methods.dart';

final class LoginModel {
  final int customerId;
  final String customerName;
  final String sessionId;
  final String customerImg;
  final String loginMessage;

  LoginModel({
    required this.customerId,
    required this.customerName,
    required this.sessionId,
    required this.customerImg,
    required this.loginMessage,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    customerId: UtilMethods().intValueParser(json['customer_id']),
    customerName: UtilMethods().emptyStringValueParser(json['customer_name']),
    sessionId: UtilMethods().emptyStringValueParser(json['SessionId']),
    customerImg: UtilMethods().emptyStringValueParser(json['customer_img']),
    loginMessage: UtilMethods().emptyStringValueParser(json['LoginMessage']),
  );
}
