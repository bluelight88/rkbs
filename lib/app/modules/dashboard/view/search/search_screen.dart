import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/constants/custom_text_form_field.dart';

import '../../../../core/widgets/custom/center_loader_widget.dart';
import '../../../../core/widgets/custom/center_message_widget.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../view_model/search/search_bloc.dart';
import '../home/widget/dynamic_slider.dart';

class SearchPage extends StatefulWidget {
  final TextEditingController searchController;

  const SearchPage({super.key, required this.searchController});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _getSearchData() {
    context.read<SearchBloc>().add(GetSearchRecord());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        if (state is SearchSuccess) {
          return Container(
            color: ColorConstants.whiteColor,
            child: Column(
              children: [
                const Gap(30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SearchTextFormField(
                    controller: widget.searchController,
                    labelText: "What Are You Looking For?",
                    onChanged: (_) {},
                  ),
                ),
                const Gap(20),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  height: 30,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 0,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.whiteColor,
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Center(
                          child: Text(
                            "Male Hair Cut",
                            style: TextStyle(
                              height: 1,
                              color: ColorConstants.primaryColor,
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Gap(10);
                    },
                    itemCount: 10,
                  ),
                ),
                SingleChildScrollView(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    width: MediaQuery.of(context).size.width,
                    child: DynamicSlider(
                      title: "Barber Near You",
                      showTileDot: false,
                      scrollDirection: Axis.horizontal,
                      items: state.searchResponseModel.recommended,
                      imageUrlGetter: (recommended) => recommended.imageUrl,
                      primaryTextGetter:
                          (recommended) => recommended.providerName,
                      secondaryTextGetter:
                          (recommended) =>
                              "${recommended.providerAddressline1}, ${recommended.providerCity}",
                      badgeText: (badge) => "4.9 | 8993 Reviews",
                    ),
                  ),
                ),
              ],
            ),
          );
        }
        if (state is SearchFailure) {
          return FailureWidget(state.message, onRefresh: _getSearchData);
        }
        return LoadingWidget();
      },
    );
  }
}
