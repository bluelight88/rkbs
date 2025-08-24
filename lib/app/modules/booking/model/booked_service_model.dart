class BookingObj {
  final String status;
  final DateTime? bookingDate;
  final int bookingOrdersId;
  final String msg;

  BookingObj({
    required this.status,
    this.bookingDate,
    required this.bookingOrdersId,
    required this.msg,
  });

  factory BookingObj.fromJson(Map<String, dynamic> json) {
    return BookingObj(
      status: json['status'] ?? '',
      bookingDate:
          json['booking_date'] != null
              ? DateTime.tryParse(json['booking_date'])
              : null,
      bookingOrdersId: json['booking_orders_id'] ?? 0,
      msg: json['msg'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'booking_date': bookingDate?.toIso8601String(),
    'booking_orders_id': bookingOrdersId,
    'msg': msg,
  };
}
