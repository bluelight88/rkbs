import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timoraa/app/core/widgets/app_bar/custom_app_bar.dart';
import 'package:timoraa/app/core/widgets/custom/center_loader_widget.dart';
import 'package:timoraa/app/core/widgets/custom/center_message_widget.dart';
import 'package:timoraa/app/modules/dashboard/model/appoinment_data_model.dart';
import 'package:timoraa/app/modules/dashboard/view/appointment/widget/appointment_card.dart';
import 'package:timoraa/app/modules/dashboard/view_model/appoinment/appoinment_bloc.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/services/app_state.dart';

class AppointmentScreen extends StatefulWidget {

  const AppointmentScreen({super.key});

  @override
  State<AppointmentScreen> createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  List<AppoinmentData> appointments = [];

  @override
  void initState() {
    super.initState();
    _getAppoinmentData();
  }

  // Function to dispatch the event and fetch appointment data
  void _getAppoinmentData() {
    final customerId = int.parse(appState.userId); // Get the userId from appState
    context.read<AppoinmentBloc>().add(GetAppoinmentRecord(customerId: customerId));
  }


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
      appBar: CustomAppBar(
        "Appointments",
        titleColor: ColorConstants.primaryColor,
        color: Colors.white,
        leading: null,
        showLeading: false,
      ),
      body:BlocBuilder<AppoinmentBloc, AppoinmentState>(
      builder: (context, state) {
        if (state is AppoinmentSuccess) {
          appointments = state.appoinmentResponseData;
          return ListView.separated(
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
                    showButton: shouldShowButton(appointments[index].status),
                    service: appointments[index].service,
                    staff: appointments[index].staffName,
                    salon: appointments[index].salonName,
                  );
                },
              );
        }
        if (state is AppoinmentFailure) {
          return FailureWidget(state.message, onRefresh: _getAppoinmentData);
        }
        return LoadingWidget();
      }
      )
    );
  }
}
