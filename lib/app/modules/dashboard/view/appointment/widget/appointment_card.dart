import 'package:flutter/material.dart';

class AppointmentCard extends StatelessWidget {
  final String status;
  final Color statusColor;
  final Color statusTextColor;
  final String date;
  final String time;
  final bool showButton;
  final String service;
  final String staff;
  final String salon;

  const AppointmentCard({
    super.key,
    required this.status,
    required this.statusColor,
    required this.statusTextColor,
    required this.date,
    required this.time,
    required this.showButton,
    required this.service,
    required this.staff,
    required this.salon,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    service,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    date,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'With $staff',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  Text(time, style: const TextStyle(color: Colors.grey)),
                ],
              ),
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    salon,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (showButton)
                    SizedBox(
                      height: 30,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                        ),
                        onPressed: () {
                          // todo: Rebooking logic
                        },
                        child: const Text('Book Again'),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          left: 20,
          top: -10,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color: statusColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              status,
              style: TextStyle(
                color: statusTextColor,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
