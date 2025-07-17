import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:timoraa/app/utils/constants/custom_text_form_field.dart';

class SearchPage extends StatelessWidget {
  final TextEditingController searchController;

  const SearchPage({super.key, required this.searchController});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Gap(20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SearchTextFormField(
            controller: searchController,
            labelText: "What Are You Looking For?",
            onChanged: (_) {},
          ),
        ),
        const Gap(20),
        const Center(child: Text("Search Results or Filters Here")),
      ],
    );
  }
}
