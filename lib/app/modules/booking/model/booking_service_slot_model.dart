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
  final List<ServiceCost> cost;
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
    required this.cost,
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
    createdDatetime: UtilMethods.instance
        .dateValueParser(json['created_datetime']),
    isActive: json['is_active'] == true,
    firstDt:
    UtilMethods.instance.dateValueParser(json['first_dt']),
    cost: UtilMethods.instance.listValueParser(
      json['cost'],
      ServiceCost.fromJson,
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
    'cost': cost.map((e) => e.toJson()).toList(),
    'booking_slot': bookingSlot.map((e) => e.toJson()).toList(),
  };
}

class ServiceCost {
  final int servicesCostId;
  final int servicesId;
  final double cost;
  final int servicesDurationUnit;
  final int servicesDuration;
  final DateTime createdDatetime;
  final bool isActive;

  ServiceCost({
    required this.servicesCostId,
    required this.servicesId,
    required this.cost,
    required this.servicesDurationUnit,
    required this.servicesDuration,
    required this.createdDatetime,
    required this.isActive,
  });

  factory ServiceCost.fromJson(Map json) => ServiceCost(
    servicesCostId:
    UtilMethods.instance.intValueParser(json['services_cost_id']),
    servicesId: UtilMethods.instance.intValueParser(json['services_id']),
    cost: UtilMethods.instance.doubleValueParser(json['cost']),
    servicesDurationUnit:
    UtilMethods.instance.intValueParser(json['services_duration_unit']),
    servicesDuration:
    UtilMethods.instance.intValueParser(json['services_duration']),
    createdDatetime: UtilMethods.instance
        .dateValueParser(json['created_datetime']),
    isActive: json['is_active'] == true,
  );

  Map<String, dynamic> toJson() => {
    'services_cost_id': servicesCostId,
    'services_id': servicesId,
    'cost': cost,
    'services_duration_unit': servicesDurationUnit,
    'services_duration': servicesDuration,
    'created_datetime': createdDatetime.toIso8601String(),
    'is_active': isActive,
  };
}

class BookingSlot {
  final int staffId;
  final String staffName;
  final List<Slot> morningSlot;
  final List<Slot> afternoonSlot;
  final List<Slot> eveningSlot;

  BookingSlot({
    required this.staffId,
    required this.staffName,
    required this.morningSlot,
    required this.afternoonSlot,
    required this.eveningSlot,
  });

  factory BookingSlot.fromJson(Map json) => BookingSlot(
    staffId: UtilMethods.instance.intValueParser(json['staff_id']),
    staffName:
    UtilMethods.instance.stringValueParser(json['staff_name']),
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
  );

  Map<String, dynamic> toJson() => {
    'staff_id': staffId,
    'staff_name': staffName,
    'morning_slot': morningSlot.map((e) => e.toJson()).toList(),
    'afternoon_slot': afternoonSlot.map((e) => e.toJson()).toList(),
    'evening_slot': eveningSlot.map((e) => e.toJson()).toList(),
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
