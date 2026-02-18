class CountryInfo {
  final String countryCode;
  final String ipAddress;

  CountryInfo({required this.countryCode, required this.ipAddress});

  factory CountryInfo.fromJson(Map<String, dynamic> json) {
    return CountryInfo(
      countryCode: json['country'] ?? 'US',
      ipAddress: json['ip'] ?? '0.0.0.0',
    );
  }

  Map<String, String> toMap() {
    return {'countryCode': countryCode, 'ipAddress': ipAddress};
  }

  @override
  String toString() {
    return 'CountryInfo(countryCode: $countryCode, ipAddress: $ipAddress)';
  }
}
