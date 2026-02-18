import '../../../utils/services/util_methods.dart';

class SplashResponseModel {
  String accessToken;
  int expIn, countryId, currencyId;

  SplashResponseModel({
    required this.accessToken,
    required this.expIn,
    required this.countryId,
    required this.currencyId,
  });

  factory SplashResponseModel.fromJson(Map<String, dynamic> data) =>
      SplashResponseModel(
        accessToken: UtilMethods.instance.stringValueParser(
          data['access_token'],
        ),
        expIn: UtilMethods.instance.intValueParser(data['expires_in']),
        countryId: UtilMethods.instance.intValueParser(data['country_id']),
        currencyId: UtilMethods.instance.intValueParser(data['currency_id']),
      );
}
