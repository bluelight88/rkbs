import 'dart:convert';
import '../../../utils/services/util_methods.dart';

class HomeObj {
  final List<BusinessType> business;
  final List<Section> sections;

  HomeObj({required this.business, required this.sections});

  factory HomeObj.fromJson(Map<String, dynamic> json) => HomeObj(
    business: UtilMethods.instance.listValueParser(
      json['business'],
      BusinessType.fromJson,
    ),
    sections: UtilMethods.instance.listValueParser(
      json['sections'],
      Section.fromJson,
    ),
  );

  Map<String, dynamic> toJson() => {
    'business': business.map((e) => e.toJson()).toList(),
    'sections': sections.map((e) => e.toJson()).toList(),
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

  factory BusinessType.fromJson(Map<String, dynamic> json) => BusinessType(
    businesstypeId: UtilMethods.instance.intValueParser(
      json['businesstype_id'],
    ),
    businesstypeName: UtilMethods.instance.stringValueParser(
      json['businesstype_name'],
    ),
    businesstypeLogoMobile: UtilMethods.instance.stringValueParser(
      json['businesstype_logo_mobile'],
    ),
  );

  Map<String, dynamic> toJson() => {
    'businesstype_id': businesstypeId,
    'businesstype_name': businesstypeName,
    'businesstype_logo_mobile': businesstypeLogoMobile,
  };
}

class Section {
  final String title;
  final String controlType;
  final int sortOrder;
  final List<Provider> details;

  Section({
    required this.title,
    required this.controlType,
    required this.sortOrder,
    required this.details,
  });

  factory Section.fromJson(Map<String, dynamic> json) => Section(
    title: UtilMethods.instance.stringValueParser(json['title']),
    controlType: UtilMethods.instance.stringValueParser(json['control_type']),
    sortOrder: UtilMethods.instance.intValueParser(json['sort_order']),
    details: UtilMethods.instance.listValueParser(
      jsonDecode(UtilMethods.instance.stringValueParser(json['details'])),
      Provider.fromJson,
    ),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'control_type': controlType,
    'sort_order': sortOrder,
    'details': jsonEncode(details.map((e) => e.toJson()).toList()),
  };
}

class Provider {
  final int providerId;
  final String providerName;
  final String providerCompanyName;
  final String providerEmail;
  final String providerContactNo;
  final String providerAddressline1;
  final String? providerAddressline2;
  final String? providerAddressline3;
  final String? providerCounty;
  final String providerPostcode;
  final String providerCity;
  final String providerCountry;
  final String? providerInfo;
  final String imageUrl;
  final String? createdDatetime;
  final bool? providerActive;

  Provider({
    required this.providerId,
    required this.providerName,
    required this.providerCompanyName,
    required this.providerEmail,
    required this.providerContactNo,
    required this.providerAddressline1,
    this.providerAddressline2,
    this.providerAddressline3,
    this.providerCounty,
    required this.providerPostcode,
    required this.providerCity,
    required this.providerCountry,
    this.providerInfo,
    required this.imageUrl,
    this.createdDatetime,
    this.providerActive,
  });

  factory Provider.fromJson(Map<String, dynamic> json) => Provider(
    providerId: UtilMethods.instance.intValueParser(json['provider_id']),
    providerName: UtilMethods.instance.stringValueParser(json['provider_name']),
    providerCompanyName: UtilMethods.instance.stringValueParser(
      json['provider_comapy_name'],
    ),
    providerEmail: UtilMethods.instance.stringValueParser(
      json['provider_email'],
    ),
    providerContactNo: UtilMethods.instance.stringValueParser(
      json['provider_contact_no'],
    ),
    providerAddressline1: UtilMethods.instance.stringValueParser(
      json['provider_addressline1'],
    ),
    providerAddressline2: json['provider_addressline2'],
    providerAddressline3: json['provider_addressline3'],
    providerCounty: json['provider_county'],
    providerPostcode: UtilMethods.instance.stringValueParser(
      json['provider_postcode'],
    ),
    providerCity: UtilMethods.instance.stringValueParser(json['provider_city']),
    providerCountry: UtilMethods.instance.stringValueParser(
      json['providere_country'],
    ),
    providerInfo: json['provider_info'],
    imageUrl: UtilMethods.instance.stringValueParser(json['image_url']),
    createdDatetime: json['created_datetime'],
    providerActive: json['provider_active'],
  );

  Map<String, dynamic> toJson() => {
    'provider_id': providerId,
    'provider_name': providerName,
    'provider_comapy_name': providerCompanyName,
    'provider_email': providerEmail,
    'provider_contact_no': providerContactNo,
    'provider_addressline1': providerAddressline1,
    'provider_addressline2': providerAddressline2,
    'provider_addressline3': providerAddressline3,
    'provider_county': providerCounty,
    'provider_postcode': providerPostcode,
    'provider_city': providerCity,
    'providere_country': providerCountry,
    'provider_info': providerInfo,
    'image_url': imageUrl,
    'created_datetime': createdDatetime,
    'provider_active': providerActive,
  };
}
