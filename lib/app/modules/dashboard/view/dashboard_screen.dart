import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timoraa/app/modules/dashboard/view/home/home_screen.dart';
import 'package:timoraa/app/modules/dashboard/view/search/search_screen.dart';
import 'package:timoraa/app/modules/dashboard/view/appointment/appointment_screen.dart';
import 'package:timoraa/app/modules/dashboard/view/account/account_screen.dart';
import 'package:timoraa/app/modules/dashboard/view_model/search/search_bloc.dart';
import 'package:timoraa/app/utils/services/app_state.dart';
import 'package:timoraa/app/utils/constants/color_constants.dart';

import '../../../utils/constants/asset_constants.dart';
import '../../../utils/services/util_methods.dart';
import '../view_model/home/home_bloc.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    final TextEditingController searchController = TextEditingController();

    return ValueListenableBuilder<int>(
      valueListenable: appState.appPageIndex,
      builder: (context, index, _) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.black,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: ColorConstants.whiteColor,
            body: PageTransitionSwitcher(
              duration: const Duration(milliseconds: 400),
              reverse: false,
              transitionBuilder:
                  (child, animation, secondaryAnimation) =>
                      SharedAxisTransition(
                        animation: animation,
                        secondaryAnimation: secondaryAnimation,
                        transitionType: SharedAxisTransitionType.horizontal,
                        child: child,
                      ),
              child: _buildPage(index, searchController, key: ValueKey(index)),
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: index,
              backgroundColor: ColorConstants.whiteColor,
              elevation: 0,
              onTap: (i) => appState.appPageIndex.value = i,
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
          ),
        );
      },
    );
  }

  Widget _buildPage(
    int index,
    TextEditingController searchController, {
    Key? key,
  }) {
    switch (index) {
      case 0:
        return BlocProvider<HomeBloc>(
          create: (_) => HomeBloc()..add(GetHomeRecord()),
          child: HomeScreen(searchController: searchController),
        );
      case 1:
        return BlocProvider(
          create: (context) => SearchBloc()..add(GetSearchRecord()),
          child: SearchPage(searchController: searchController),
        );
      case 2:
        return const AppointmentScreen();
      case 3:
        return const AccountPage();
      default:
        return const SizedBox();
    }
  }
}
