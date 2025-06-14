class APIS {
  /// LOCAL
  static const String baseUrlLocal = '';

  /// DO NOT Change following url without approval
  /// Development
  static const String baseUrlDev = '';

  /// Production
  static const String baseUrlProd = '';

  // VERSIONS
  static const String version = 'v1/';

  // Authentication
  static const String loginAPI = '${version}api/login',
      todo = 'to_do',
      logout = '${version}api/logout',
      sendOtp = '${version}api/send/otp';
}
