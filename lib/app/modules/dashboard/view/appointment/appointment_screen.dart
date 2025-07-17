import 'package:timoraa/app/modules/dashboard/view/appointment/widget/appointment_card.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../core/widgets/buttons/app_elevated_button.dart';
import '../../../../utils/services/app_state.dart';
import '../../../auth/model/appointment_model.dart';

class AppointmentScreen extends StatefulWidget {
  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<AppointmentModel> appointments = [
    AppointmentModel(
      service: "Hair Cuts",
      staffName: "Kevin Smith",
      salonName: "ASALOON",
      date: "May 19, 2025",
      time: "09:30 AM – 10:00 AM",
      status: "CONFIRMED",
    ),
    AppointmentModel(
      service: "Hair Cuts",
      staffName: "Kevin Smith",
      salonName: "ASALOON",
      date: "Feb 25, 2025",
      time: "09:30 AM – 10:00 AM",
      status: "CANCELED",
    ),
  ];

  bool shouldShowButton(String status) => status == "CANCELED";

  Color getStatusColor(String status) {
    switch (status) {
      case "CONFIRMED":
        return Colors.green.shade500;
      case "CANCELED":
        return ColorConstants.lightGreyColor;
      default:
        return Colors.blueGrey;
    }
  }

  Color getStatusTextColor(String status) {
    switch (status) {
      case "CONFIRMED":
        return ColorConstants.whiteColor;
      default:
        return ColorConstants.primaryColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Appointments",
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
      ),
      body:
          appState.userId.isEmpty
              ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      AssetConstants.icAppointmentCalender,
                      height: MediaQuery.of(context).size.height * 0.35,
                      width: MediaQuery.of(context).size.width * 0.6,
                    ),
                    Text(
                      "Schedule Appointments",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    const Gap(10),
                    Text(
                      "Easily manage your hair, skin, and wellness appointments in one place.\n"
                      "Find salons, check availability, and book instantly.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey.shade600,
                        height: 1.5,
                      ),
                    ),
                    const Gap(30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: AppElevatedButton(
                        Text(
                          "Explore",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        onPressed: () {
                          appState.appPageIndex.value = 1;
                        },
                      ),
                    ),
                  ],
                ),
              )
              : ListView.separated(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 25,
                ),
                itemCount: appointments.length,
                separatorBuilder: (context, index) {
                  return Gap(20);
                },
                itemBuilder: (context, index) {
                  return AppointmentCard(
                    status: appointments[index].status,
                    statusColor: getStatusColor(appointments[index].status),
                    statusTextColor: getStatusTextColor(
                      appointments[index].status,
                    ),
                    date: appointments[index].date,
                    time: appointments[index].time,
                    showButton: true,
                    service: appointments[index].service,
                    staff: appointments[index].staffName,
                    salon: appointments[index].salonName,
                  );
                },
              ),
    );
  }
}
