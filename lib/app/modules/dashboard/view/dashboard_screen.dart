import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timoraa/app/modules/dashboard/view/home/home_screen.dart';
import 'package:timoraa/app/modules/dashboard/view/search/search_screen.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/asset_constants.dart';
import '../../../utils/services/app_state.dart';
import '../view_model/home/home_bloc.dart';
import 'account/account_screen.dart';
import 'appointment/appointment_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<Widget> _pages = [
    BlocProvider(create: (context) => HomeBloc(), child: const HomeScreen()),
    const SearchPage(),
    const AppointmentScreen(),
    const AccountPage(),
  ];

  void _onItemTapped(int index) {
    appState.appPageIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: appState.appPageIndex,
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: ColorConstants.whiteColor,
          body: SafeArea(child: _pages[appState.appPageIndex.value]),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: appState.appPageIndex.value,
            selectedIconTheme: IconThemeData(
              size: 25,
              color: ColorConstants.primaryColor,
            ),
            selectedItemColor: ColorConstants.primaryColor,
            unselectedItemColor: ColorConstants.searchFieldTextColor,
            onTap: _onItemTapped,
            items: [
              const BottomNavigationBarItem(
                icon: Icon(Icons.home_filled, size: 25),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.search, size: 25),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  AssetConstants.icCalender,
                  color:
                      appState.appPageIndex.value == 2
                          ? ColorConstants.primaryColor
                          : ColorConstants.searchFieldTextColor,
                  height: 25,
                  width: 25,
                ),
                label: '',
              ),
              const BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded, size: 25),
                label: '',
              ),
            ],
          ),
        );
      },
    );
  }
}
