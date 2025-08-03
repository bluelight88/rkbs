class APIS {
  /// LOCAL
  static const String baseUrl = 'http://api.timoraa.com/';

  // Authentication
  static const String loginAPI = '${baseUrl}api/login',
      todo = 'to_do',
      logout = '${baseUrl}api/logout',
      home = '${baseUrl}data/api/device/GetHomePageDetails',
      providerDetail = '${baseUrl}data/api/device/GetProviderDetails',
      bookAppointment = '${baseUrl}data/api/device/GetServiceById',
      sendOtp = '${baseUrl}api/send/otp';
}
