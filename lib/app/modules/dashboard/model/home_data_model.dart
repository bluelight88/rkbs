
import '../../../utils/services/util_methods.dart';

class HomeResponseModel {
  final List<BusinessType> business;
  final List<Provider> offer;
  final List<Provider> recommended;

  HomeResponseModel({
    required this.business,
    required this.offer,
    required this.recommended,
  });

  factory HomeResponseModel.fromJson(Map json) => HomeResponseModel(
    business: UtilMethods.instance
        .listValueParser(json['business'], BusinessType.fromJson),
    offer:
    UtilMethods.instance.listValueParser(json['offer'], Provider.fromJson),
    recommended: UtilMethods.instance
        .listValueParser(json['recommended'], Provider.fromJson),
  );

  Map toJson() => {
    'business': business.map((e) => e.toJson()).toList(),
    'offer': offer.map((e) => e.toJson()).toList(),
    'recommended': recommended.map((e) => e.toJson()).toList(),
  };
}

class BusinessType {
  final int businesstypeId;
  final String businesstypeName;
  final String businesstypeLogoMobile;

  BusinessType({
    required this.businesstypeId,
    required this.businesstypeName,
    required this.businesstypeLogoMobile,
  });

  factory BusinessType.fromJson(Map json) => BusinessType(
    businesstypeId:
    UtilMethods.instance.intValueParser(json['businesstype_id']),
    businesstypeName:
    UtilMethods.instance.stringValueParser(json['businesstype_name']),
    businesstypeLogoMobile: UtilMethods.instance
        .stringValueParser(json['businesstype_logo_mobile']),
  );

  Map toJson() => {
    'businesstype_id': businesstypeId,
    'businesstype_name': businesstypeName,
    'businesstype_logo_mobile': businesstypeLogoMobile,
  };
}

class Provider {
  final int providerId;
  final String providerName;
  final String providerCompanyName;
  final String providerEmail;
  final String providerContactNo;
  final String providerAddressline1;
  final String providerPostcode;
  final String providerCity;
  final String providerCountry;
  final String imageUrl;

  Provider({
    required this.providerId,
    required this.providerName,
    required this.providerCompanyName,
    required this.providerEmail,
    required this.providerContactNo,
    required this.providerAddressline1,
    required this.providerPostcode,
    required this.providerCity,
    required this.providerCountry,
    required this.imageUrl,
  });

  factory Provider.fromJson(Map json) => Provider(
    providerId: UtilMethods.instance.intValueParser(json['provider_id']),
    providerName:
    UtilMethods.instance.stringValueParser(json['provider_name']),
    providerCompanyName: UtilMethods.instance
        .stringValueParser(json['provider_comapy_name']),
    providerEmail:
    UtilMethods.instance.stringValueParser(json['provider_email']),
    providerContactNo: UtilMethods.instance
        .stringValueParser(json['provider_contact_no']),
    providerAddressline1: UtilMethods.instance
        .stringValueParser(json['provider_addressline1']),
    providerPostcode: UtilMethods.instance
        .stringValueParser(json['provider_postcode']),
    providerCity:
    UtilMethods.instance.stringValueParser(json['provider_city']),
    providerCountry:
    UtilMethods.instance.stringValueParser(json['providere_country']),
    imageUrl: UtilMethods.instance.stringValueParser(json['image_url']),
  );

  Map toJson() => {
    'provider_id': providerId,
    'provider_name': providerName,
    'provider_comapy_name': providerCompanyName,
    'provider_email': providerEmail,
    'provider_contact_no': providerContactNo,
    'provider_addressline1': providerAddressline1,
    'provider_postcode': providerPostcode,
    'provider_city': providerCity,
    'providere_country': providerCountry,
    'image_url': imageUrl,
  };
}
