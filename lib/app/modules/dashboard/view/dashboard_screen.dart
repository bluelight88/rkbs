import 'package:base_project/app/modules/dashboard/view/home/home_screen.dart';
import 'package:base_project/app/utils/constants/color_constants.dart';
import 'package:flutter/material.dart';

import '../../../utils/constants/asset_constants.dart';
import 'appointment/appointment_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [
    HomeScreen(),
    SearchPage(),
    AppointmentScreen(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.whiteColor,
      body: SafeArea(child: _pages[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedIconTheme: IconThemeData(
          size: 25,
          color: ColorConstants.primaryColor,
        ),
        selectedItemColor: ColorConstants.primaryColor,
        unselectedItemColor: ColorConstants.textFieldIconColor,
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
              AssetConstants.calender,
              color:
                  _selectedIndex == 2
                      ? ColorConstants.primaryColor
                      : ColorConstants.textFieldIconColor,
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
  }
}

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Search for Services or Stylists"));
  }
}

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Manage Your Profile"));
  }
}
