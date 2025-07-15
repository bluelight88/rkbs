import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timoraa/app/core/widgets/custom/center_loader_widget.dart';
import 'package:timoraa/app/core/widgets/custom/center_message_widget.dart';
import 'package:timoraa/app/modules/dashboard/view_model/home/home_bloc.dart';
import 'package:timoraa/app/utils/constants/asset_constants.dart';
import 'package:timoraa/app/utils/constants/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../../utils/constants/color_constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    _getHomeData();
    super.initState();
  }

  _getHomeData() {
    context.read<HomeBloc>().add(GetHomeRecord());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) {
        if (state is HomeSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Hello ",
                            style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          TextSpan(
                            text: "USER \n",
                            style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                            ),
                          ),
                          TextSpan(
                            text: "Welcome to Saloon",
                            style: TextStyle(
                              color: ColorConstants.primaryColor,
                              fontWeight: FontWeight.normal,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        AssetConstants.onBoardingImage,
                        height: 50,
                        width: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
                const Gap(20),
                SearchTextFormField(
                  controller: searchController,
                  labelText: "What Are You Looking For?",
                  onChanged: (value) {},
                ),
                const Gap(20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Category",
                      style: TextStyle(
                        color: ColorConstants.primaryColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        // todo: see all integration
                      },
                      child: Text("See All"),
                    ),
                  ],
                ),
                const Gap(10),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    separatorBuilder: (context, index) {
                      return Gap(20);
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.asset(
                              AssetConstants.onBoardingImage,
                              height: 70,
                              width: 70,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Gap(10),
                          Text("Hair Salon", style: TextStyle()),
                        ],
                      );
                    },
                    itemCount: 4,
                  ),
                ),
              ],
            ),
          );
        }
        if (state is HomeFailure) {
          return FailureWidget(state.message, onRefresh: _getHomeData);
        }
        return LoadingWidget();
      },
    );
  }
}
