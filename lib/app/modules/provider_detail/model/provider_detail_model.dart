import 'dart:convert';
import '../../../utils/services/util_methods.dart';

ProviderDetailModel providerDetailModelFromJson(String str) =>
    ProviderDetailModel.fromJson(json.decode(str));

String providerDetailModelToJson(ProviderDetailModel data) =>
    json.encode(data.toJson());

class ProviderDetailModel {
  final int providerId;
  final String providerName;
  final String providerCompanyName;
  final String providerEmail;
  final String providerContactNo;
  final String providerAddressline1;
  final String providerAddressline2;
  final String providerAddressline3;
  final String providerPostcode;
  final String providerCounty;
  final String providerCity;
  final String providerCountry;
  final DateTime createdDatetime;
  final bool providerActive;
  final String imageUrl;
  final String providerInfo;
  final List<BusinessType> businessTypes;
  final List<Staff> staff;
  final List<Service> services;
  final List<SocialMedia> socialMedia;
  final List<Amenity> amenities;
  final List<WorkingDay> workingDays;

  ProviderDetailModel({
    required this.providerId,
    required this.providerName,
    required this.providerCompanyName,
    required this.providerEmail,
    required this.providerContactNo,
    required this.providerAddressline1,
    required this.providerAddressline2,
    required this.providerAddressline3,
    required this.providerPostcode,
    required this.providerCounty,
    required this.providerCity,
    required this.providerCountry,
    required this.createdDatetime,
    required this.providerActive,
    required this.imageUrl,
    required this.providerInfo,
    required this.businessTypes,
    required this.staff,
    required this.services,
    required this.socialMedia,
    required this.amenities,
    required this.workingDays,
  });

  factory ProviderDetailModel.fromJson(Map json) => ProviderDetailModel(
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
    providerAddressline1: UtilMethods.instance.emptyStringValueParser(
      json['provider_addressline1'],
    ),
    providerAddressline2: UtilMethods.instance.emptyStringValueParser(
      json['provider_addressline2'],
    ),
    providerAddressline3: UtilMethods.instance.emptyStringValueParser(
      json['provider_addressline3'],
    ),
    providerPostcode: UtilMethods.instance.stringValueParser(
      json['provider_postcode'],
    ),
    providerCounty: UtilMethods.instance.stringValueParser(
      json['provider_county'],
    ),
    providerCity: UtilMethods.instance.stringValueParser(json['provider_city']),
    providerCountry: UtilMethods.instance.stringValueParser(
      json['providere_country'],
    ),
    createdDatetime: DateTime.parse(json['created_datetime']),
    providerActive: json['provider_active'] ?? false,
    imageUrl: UtilMethods.instance.stringValueParser(json['image_url']),
    providerInfo: UtilMethods.instance.stringValueParser(json['provider_info']),
    businessTypes: UtilMethods.instance.listValueParser(
      json['BusinessTypes'],
      BusinessType.fromJson,
    ),
    staff: UtilMethods.instance.listValueParser(json['Staff'], Staff.fromJson),
    services: UtilMethods.instance.listValueParser(
      json['Services'],
      Service.fromJson,
    ),
    socialMedia: UtilMethods.instance.listValueParser(
      json['social_media'],
      SocialMedia.fromJson,
    ),
    amenities: UtilMethods.instance.listValueParser(
      json['amenities'],
      Amenity.fromJson,
    ),
    workingDays: UtilMethods.instance.listValueParser(
      json['working_days'],
      WorkingDay.fromJson,
    ),
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
    'provider_postcode': providerPostcode,
    'provider_county': providerCounty,
    'provider_city': providerCity,
    'providere_country': providerCountry,
    'created_datetime': createdDatetime.toIso8601String(),
    'provider_active': providerActive,
    'image_url': imageUrl,
    'provider_info': providerInfo,
    'BusinessTypes': businessTypes.map((x) => x.toJson()).toList(),
    'Staff': staff.map((x) => x.toJson()).toList(),
    'Services': services.map((x) => x.toJson()).toList(),
    'social_media': socialMedia.map((x) => x.toJson()).toList(),
    'amenities': amenities.map((x) => x.toJson()).toList(),
    'working_days': workingDays.map((x) => x.toJson()).toList(),
  };
}

class BusinessType {
  final int businesstypeId;
  final String businesstypeCode;
  final String businesstypeDescription;
  final String businesstypeLogo;
  final String businesstypeLogoMobile;

  BusinessType({
    required this.businesstypeId,
    required this.businesstypeCode,
    required this.businesstypeDescription,
    required this.businesstypeLogo,
    required this.businesstypeLogoMobile,
  });

  factory BusinessType.fromJson(Map json) => BusinessType(
    businesstypeId: UtilMethods.instance.intValueParser(
      json['businesstype_id'],
    ),
    businesstypeCode: UtilMethods.instance.stringValueParser(
      json['businesstype_code'],
    ),
    businesstypeDescription: UtilMethods.instance.stringValueParser(
      json['businesstype_description'],
    ),
    businesstypeLogo: UtilMethods.instance.stringValueParser(
      json['businesstype_logo'],
    ),
    businesstypeLogoMobile: UtilMethods.instance.stringValueParser(
      json['businesstype_logo_mobile'],
    ),
  );

  Map<String, dynamic> toJson() => {
    'businesstype_id': businesstypeId,
    'businesstype_code': businesstypeCode,
    'businesstype_description': businesstypeDescription,
    'businesstype_logo': businesstypeLogo,
    'businesstype_logo_mobile': businesstypeLogoMobile,
  };
}

class Staff {
  final int staffId;
  final String staffName;
  final String staffEmail;
  final String staffPhone;

  Staff({
    required this.staffId,
    required this.staffName,
    required this.staffEmail,
    required this.staffPhone,
  });

  factory Staff.fromJson(Map json) => Staff(
    staffId: UtilMethods.instance.intValueParser(json['staff_id']),
    staffName: UtilMethods.instance.stringValueParser(json['staff_name']),
    staffEmail: UtilMethods.instance.stringValueParser(json['staff_email']),
    staffPhone: UtilMethods.instance.stringValueParser(json['staff_phone']),
  );

  Map<String, dynamic> toJson() => {
    'staff_id': staffId,
    'staff_name': staffName,
    'staff_email': staffEmail,
    'staff_phone': staffPhone,
  };
}

class Service {
  final int servicesId;
  final String servicesCode;
  final String servicesDescription;
  final List<ServiceCost> servicesCost;

  Service({
    required this.servicesId,
    required this.servicesCode,
    required this.servicesDescription,
    required this.servicesCost,
  });

  factory Service.fromJson(Map json) => Service(
    servicesId: UtilMethods.instance.intValueParser(json['services_id']),
    servicesCode: UtilMethods.instance.stringValueParser(json['services_code']),
    servicesDescription: UtilMethods.instance.stringValueParser(
      json['services_description'],
    ),
    servicesCost: UtilMethods.instance.listValueParser(
      json['ServicesCost'],
      ServiceCost.fromJson,
    ),
  );

  Map<String, dynamic> toJson() => {
    'services_id': servicesId,
    'services_code': servicesCode,
    'services_description': servicesDescription,
    'ServicesCost': servicesCost.map((x) => x.toJson()).toList(),
  };
}

class ServiceCost {
  final int servicesCostId;
  final int servicesId;
  final double cost;
  final int servicesDurationUnit;
  final int servicesDuration;

  ServiceCost({
    required this.servicesCostId,
    required this.servicesId,
    required this.cost,
    required this.servicesDurationUnit,
    required this.servicesDuration,
  });

  factory ServiceCost.fromJson(Map json) => ServiceCost(
    servicesCostId: UtilMethods.instance.intValueParser(
      json['services_cost_id'],
    ),
    servicesId: UtilMethods.instance.intValueParser(json['services_id']),
    cost: UtilMethods.instance.doubleValueParser(json['cost']),
    servicesDurationUnit: UtilMethods.instance.intValueParser(
      json['services_duration_unit'],
    ),
    servicesDuration: UtilMethods.instance.intValueParser(
      json['services_duration'],
    ),
  );

  Map<String, dynamic> toJson() => {
    'services_cost_id': servicesCostId,
    'services_id': servicesId,
    'cost': cost,
    'services_duration_unit': servicesDurationUnit,
    'services_duration': servicesDuration,
  };
}

class SocialMedia {
  final String title;
  final String description;
  final String logo;
  final String link;

  SocialMedia({
    required this.title,
    required this.description,
    required this.logo,
    required this.link,
  });

  factory SocialMedia.fromJson(Map json) => SocialMedia(
    title: UtilMethods.instance.stringValueParser(json['title']),
    description: UtilMethods.instance.stringValueParser(json['description']),
    logo: UtilMethods.instance.stringValueParser(json['logo']),
    link: UtilMethods.instance.stringValueParser(json['link']),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'logo': logo,
    'link': link,
  };
}

class Amenity {
  final String title;
  final String description;
  final String logo;
  final String link;

  Amenity({
    required this.title,
    required this.description,
    required this.logo,
    required this.link,
  });

  factory Amenity.fromJson(Map json) => Amenity(
    title: UtilMethods.instance.stringValueParser(json['title']),
    description: UtilMethods.instance.stringValueParser(json['description']),
    logo: UtilMethods.instance.stringValueParser(json['logo']),
    link: UtilMethods.instance.stringValueParser(json['link']),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'logo': logo,
    'link': link,
  };
}

class WorkingDay {
  final String title;
  final String description;
  final String logo;
  final String link;

  WorkingDay({
    required this.title,
    required this.description,
    required this.logo,
    required this.link,
  });

  factory WorkingDay.fromJson(Map json) => WorkingDay(
    title: UtilMethods.instance.stringValueParser(json['title']),
    description: UtilMethods.instance.stringValueParser(json['description']),
    logo: UtilMethods.instance.stringValueParser(json['logo']),
    link: UtilMethods.instance.stringValueParser(json['link']),
  );

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'logo': logo,
    'link': link,
  };
}
