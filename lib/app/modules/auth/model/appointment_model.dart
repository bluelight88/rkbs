class AppointmentModel {
  final String service;
  final String staffName;
  final String salonName;
  final String date;
  final String time;
  final String status;

  AppointmentModel({
    required this.service,
    required this.staffName,
    required this.salonName,
    required this.date,
    required this.time,
    required this.status,
  });

  // Optional: factory constructor for JSON parsing (if using API)
  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      service: json['service'] ?? '',
      staffName: json['staffName'] ?? '',
      salonName: json['salonName'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? '',
    );
  }

  // Optional: toJson for serialization
  Map<String, dynamic> toJson() {
    return {
      'service': service,
      'staffName': staffName,
      'salonName': salonName,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}
