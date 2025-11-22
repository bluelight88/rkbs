

import '../../../utils/services/util_methods.dart';

class AppoinmentObj {
  final List<AppoinmentData> lstappointment;

  AppoinmentObj({required this.lstappointment});

  factory AppoinmentObj.fromJson(Map<String, dynamic> json) {
    return AppoinmentObj(
      lstappointment: List<AppoinmentData>.from(
        (json['obj'] as List<dynamic>).map(
          (item) => AppoinmentData.fromJson(item as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() => {
    'lstappointment': lstappointment.map((e) => e.toJson()).toList(),
  };
}

class AppoinmentData {
  final int bookingordersid;
  final bool iscancelled;
  final int servicesid;
  final String service;
  final int staffid;
  final String staffName;
  final int providerid;
  final String salonName;
  final String date;
  final String time;
  final String status;

  AppoinmentData({
    required this.bookingordersid,
    required this.iscancelled,
    required this.servicesid,
    required this.service,
    required this.staffid,
    required this.staffName,
    required this.providerid,
    required this.salonName,
    required this.date,
    required this.time,
    required this.status
  });

  factory AppoinmentData.fromJson(Map<String, dynamic> json) => AppoinmentData(
    bookingordersid: UtilMethods.instance.intValueParser(
      json['bookingordersid'],
    ),
    iscancelled: json['iscancelled'] ?? false,
    servicesid: UtilMethods.instance.intValueParser(
      json['servicesid'],
    ),
     service: UtilMethods.instance.stringValueParser(
      json['service'],
    ),
    staffid: UtilMethods.instance.intValueParser(
      json['staffid'],
    ),
    staffName: UtilMethods.instance.stringValueParser(
      json['staffName'],
    ),
    providerid: UtilMethods.instance.intValueParser(
      json['providerid'],
    ),
    salonName: UtilMethods.instance.stringValueParser(
      json['salonName'],
    ),
    date: UtilMethods.instance.stringValueParser(
      json['date'],
    ),
    time: UtilMethods.instance.stringValueParser(
      json['time'],
    ),
    status: UtilMethods.instance.stringValueParser(
      json['status'],
    )
  );

  Map<String, dynamic> toJson() => {
    'bookingordersid': bookingordersid,
    'iscancelled': iscancelled,
    'servicesid': servicesid,
    'service':service,
    'staffid':staffid,
    'staffName':staffName,
    'providerid':providerid,
    'salonName':salonName,
    'date':date,
    'time':time,
    'status':status
  };

}

