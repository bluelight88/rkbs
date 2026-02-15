import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/core/widgets/custom/shimmer_widget.dart';
import 'package:timoraa/app/utils/constants/custom_text_form_field.dart';

import '../../../../core/widgets/custom/center_message_widget.dart';
import '../../../../utils/constants/color_constants.dart';
import '../../view_model/search/search_bloc.dart';

class SearchPage extends StatefulWidget {
  final TextEditingController searchController;

  const SearchPage({super.key, required this.searchController});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> with SingleTickerProviderStateMixin {
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _fadeAnimation = CurvedAnimation(parent: _fadeController, curve: Curves.easeIn);
    _fadeController.forward();
  }

  @override
  void dispose() {
    _fadeController.dispose();
    super.dispose();
  }

  void _getSearchData() {
    context.read<SearchBloc>().add(GetSearchRecord());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(
      builder: (context, state) {
        return FadeTransition(
          opacity: _fadeAnimation,
          child: _buildContent(state),
        );
      },
    );
  }

  Widget _buildContent(SearchState state) {
    if (state is SearchSuccess) {
      return _buildSearchUI(false);
    }
    if (state is SearchFailure) {
      return FailureWidget(state.message, onRefresh: _getSearchData);
    }
    // Loading state with Shimmer Skeleton
    return _buildSearchUI(true);
  }

  Widget _buildSearchUI(bool isLoading) {
    return Container(
      color: ColorConstants.whiteColor,
      child: Column(
        children: [
          const Gap(30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isLoading
                ? const ShimmerWidget.rectangular(height: 50)
                : SearchTextFormField(
                    controller: widget.searchController,
                    labelText: "What Are You Looking For?",
                    onChanged: (_) {},
                  ),
          ),
          const Gap(20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: 30,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 10,
              separatorBuilder: (context, index) => const Gap(10),
              itemBuilder: (context, index) {
                if (isLoading) {
                  return const ShimmerWidget.rectangular(width: 100, height: 30);
                }
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: ColorConstants.whiteColor,
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    border: Border.all(color: ColorConstants.greyBackGround2),
                  ),
                  child: const Center(
                    child: Text(
                      "Male Hair Cut",
                      style: TextStyle(height: 1, color: ColorConstants.primaryColor),
                    ),
                  ),
                );
              },
            ),
          ),
          const Gap(20),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: isLoading ? 5 : 0, // Placeholder count for shimmer
              itemBuilder: (context, index) {
                if (isLoading) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        const ShimmerWidget.rectangular(width: 80, height: 80),
                        const Gap(15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const ShimmerWidget.rectangular(height: 15),
                              const Gap(8),
                              ShimmerWidget.rectangular(
                                height: 12,
                                width: MediaQuery.of(context).size.width * 0.4,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ],
      ),
    );
  }
}
