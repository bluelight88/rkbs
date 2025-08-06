import '../../../utils/services/util_methods.dart';

class BookingServiceSlotModel {
  final int servicesId;
  final int providerId;
  final String servicesName;
  final String servicesCode;
  final String servicesDescription;
  final DateTime createdDatetime;
  final bool isActive;
  final DateTime firstDt;
  final List<Staff> staff;
  final List<BookingSlot> bookingSlot;

  BookingServiceSlotModel({
    required this.servicesId,
    required this.providerId,
    required this.servicesName,
    required this.servicesCode,
    required this.servicesDescription,
    required this.createdDatetime,
    required this.isActive,
    required this.firstDt,
    required this.staff,
    required this.bookingSlot,
  });

  factory BookingServiceSlotModel.fromJson(Map json) => BookingServiceSlotModel(
    servicesId: UtilMethods.instance.intValueParser(json['services_id']),
    providerId: UtilMethods.instance.intValueParser(json['provider_id']),
    servicesName:
    UtilMethods.instance.stringValueParser(json['services_name']),
    servicesCode:
    UtilMethods.instance.stringValueParser(json['services_code']),
    servicesDescription: UtilMethods.instance
        .stringValueParser(json['services_description']),
    createdDatetime:
    UtilMethods.instance.dateValueParser(json['created_datetime']),
    isActive: json['is_active'] == true,
    firstDt: UtilMethods.instance.dateValueParser(json['first_dt']),
    staff: UtilMethods.instance.listValueParser(
      json['staff'],
      Staff.fromJson,
    ),
    bookingSlot: UtilMethods.instance.listValueParser(
      json['booking_slot'],
      BookingSlot.fromJson,
    ),
  );

  Map<String, dynamic> toJson() => {
    'services_id': servicesId,
    'provider_id': providerId,
    'services_name': servicesName,
    'services_code': servicesCode,
    'services_description': servicesDescription,
    'created_datetime': createdDatetime.toIso8601String(),
    'is_active': isActive,
    'first_dt': firstDt.toIso8601String(),
    'staff': staff.map((e) => e.toJson()).toList(),
    'booking_slot': bookingSlot.map((e) => e.toJson()).toList(),
  };
}

class Staff {
  final int staffId;
  final String staffName;
  final String staffPhoto;
  final int selectedStaff;

  Staff({
    required this.staffId,
    required this.staffName,
    required this.staffPhoto,
    required this.selectedStaff,
  });

  factory Staff.fromJson(Map json) => Staff(
    staffId: UtilMethods.instance.intValueParser(json['staff_id']),
    staffName: UtilMethods.instance.stringValueParser(json['staff_name']),
    staffPhoto: UtilMethods.instance.stringValueParser(json['staff_photo']),
    selectedStaff:
    UtilMethods.instance.intValueParser(json['selected_staff']),
  );

  Map<String, dynamic> toJson() => {
    'staff_id': staffId,
    'staff_name': staffName,
    'staff_photo': staffPhoto,
    'selected_staff': selectedStaff,
  };
}

class BookingSlot {
  final int staffId;
  final String staffName;
  final String staffPhoto;
  final List<Slot> morningSlot;
  final List<Slot> afternoonSlot;
  final List<Slot> eveningSlot;
  final List<ServiceCost> cost;

  BookingSlot({
    required this.staffId,
    required this.staffName,
    required this.staffPhoto,
    required this.morningSlot,
    required this.afternoonSlot,
    required this.eveningSlot,
    required this.cost,
  });

  factory BookingSlot.fromJson(Map json) => BookingSlot(
    staffId: UtilMethods.instance.intValueParser(json['staff_id']),
    staffName: UtilMethods.instance.stringValueParser(json['staff_name']),
    staffPhoto: UtilMethods.instance.stringValueParser(json['staff_photo']),
    morningSlot: UtilMethods.instance.listValueParser(
      json['morning_slot'],
      Slot.fromJson,
    ),
    afternoonSlot: UtilMethods.instance.listValueParser(
      json['afternoon_slot'],
      Slot.fromJson,
    ),
    eveningSlot: UtilMethods.instance.listValueParser(
      json['evening_slot'],
      Slot.fromJson,
    ),
    cost: UtilMethods.instance.listValueParser(
      json['cost'],
      ServiceCost.fromJson,
    ),
  );

  Map<String, dynamic> toJson() => {
    'staff_id': staffId,
    'staff_name': staffName,
    'staff_photo': staffPhoto,
    'morning_slot': morningSlot.map((e) => e.toJson()).toList(),
    'afternoon_slot': afternoonSlot.map((e) => e.toJson()).toList(),
    'evening_slot': eveningSlot.map((e) => e.toJson()).toList(),
    'cost': cost.map((e) => e.toJson()).toList(),
  };
}

class Slot {
  final String slotDisplayTime;
  final int slotId;

  Slot({
    required this.slotDisplayTime,
    required this.slotId,
  });

  factory Slot.fromJson(Map json) => Slot(
    slotDisplayTime:
    UtilMethods.instance.stringValueParser(json['slot_display_time']),
    slotId: UtilMethods.instance.intValueParser(json['slot_id']),
  );

  Map<String, dynamic> toJson() => {
    'slot_display_time': slotDisplayTime,
    'slot_id': slotId,
  };
}

class ServiceCost {
  final int servicesId;
  final int staffId;
  final double cost;
  final int servicesDurationUnit;
  final int servicesDuration;

  ServiceCost({
    required this.servicesId,
    required this.staffId,
    required this.cost,
    required this.servicesDurationUnit,
    required this.servicesDuration,
  });

  factory ServiceCost.fromJson(Map json) => ServiceCost(
    servicesId: UtilMethods.instance.intValueParser(json['services_id']),
    staffId: UtilMethods.instance.intValueParser(json['staff_id']),
    cost: UtilMethods.instance.doubleValueParser(json['cost']),
    servicesDurationUnit: UtilMethods.instance
        .intValueParser(json['services_duration_unit']),
    servicesDuration:
    UtilMethods.instance.intValueParser(json['services_duration']),
  );

  Map<String, dynamic> toJson() => {
    'services_id': servicesId,
    'staff_id': staffId,
    'cost': cost,
    'services_duration_unit': servicesDurationUnit,
    'services_duration': servicesDuration,
  };
}
