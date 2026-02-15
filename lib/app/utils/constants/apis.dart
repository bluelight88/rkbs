class APIS {
  /// LOCAL
  static const String baseUrl = 'http://api.timoraa.com/';

  // Authentication
  static const String loginAPI = '${baseUrl}data/api/device/LoginCustomer',
      socialLogin = '${baseUrl}data/api/device/SocialLoginCustomer',
      todo = 'to_do',
      logout = '${baseUrl}api/logout',
      home = '${baseUrl}data/api/device/GetHomePageDetails',
      initApp = '${baseUrl}data/api/auth/init_app',
      providerDetail = '${baseUrl}data/api/device/GetProviderDetails',
      bookAppointmentDetails = '${baseUrl}data/api/device/GetServiceById',
      bookAppointment = '${baseUrl}data/api/device/DoBooking',
      sendOtp = '${baseUrl}api/send/otp',
      appoinment='${baseUrl}data/api/device/GetCustomerAppoinments',
      providerreview='${baseUrl}data/api/device/GetProviderReviews';
}
