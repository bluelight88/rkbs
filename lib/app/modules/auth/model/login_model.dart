import '../../../utils/services/util_methods.dart';

final class LoginModel {
  final int uid;
  final String name;

  LoginModel({required this.uid, required this.name});

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    uid: UtilMethods().intValueParser(json['uid']),
    name: UtilMethods().stringValueParser(json['name']),
  );
}
