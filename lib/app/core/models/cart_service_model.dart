class CartServiceModel {
  int serviceId, staffId, slotId, serviceDuration;
  double cost;
  String serviceName, slotName;

  CartServiceModel({
    required this.serviceId,
    required this.staffId,
    required this.slotId,
    required this.serviceDuration,
    required this.serviceName,
    required this.slotName,
    required this.cost,
  });

  Map<String, dynamic> toJson() {
    return {
      'serviceName': serviceName,
      'cost': cost,
      'serviceId': serviceId,
      'staffId': staffId,
      'slotId': slotId,
      'serviceDuration': serviceDuration,
      'slotName': slotName,
    };
  }
}
