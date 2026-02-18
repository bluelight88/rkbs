import 'apis.dart';

enum Environment { dev, stage, preProd, prod, local }

final class AppConfig {
  static final AppConfig instance = AppConfig._();

  factory AppConfig() => instance;

  AppConfig._();

  Map<String, dynamic>? _config;
  late final Environment _currentEnv;
  static const String _baseUrl = "baseUrl", _isLocal = "isLocal";

  // Getters
  bool get isFlavourInitialized => _config != null;

  Environment get currentEnv => _currentEnv;

  void setEnvironment(Environment env) {
    _currentEnv = env;
    _config = switch (env) {
      Environment.dev => devConstants,
      Environment.stage => stageConstants,
      Environment.preProd => preProdConstants,
      Environment.prod => prodConstants,
      Environment.local => localConstants,
    };
  }

  String get baseUrlKey => _baseUrl;

  String get apiBaseUrl => _config![_baseUrl];

  String get chatSocketUrl => _config![_baseUrl];

  bool get isLocal => _config![_isLocal];

  void setBaseUrl(String url) => _config![_baseUrl] = url;

  Map<String, dynamic> devConstants = {_baseUrl: APIS.baseUrl, _isLocal: false};

  Map<String, dynamic> stageConstants = {
    _baseUrl: APIS.baseUrl,
    _isLocal: false,
  };

  Map<String, dynamic> preProdConstants = {
    _baseUrl: APIS.baseUrl,
    _isLocal: false,
  };

  Map<String, dynamic> prodConstants = {
    _baseUrl: APIS.baseUrl,
    _isLocal: false,
  };

  Map<String, dynamic> localConstants = {
    _baseUrl: APIS.baseUrl,
    _isLocal: false,
  };
}
