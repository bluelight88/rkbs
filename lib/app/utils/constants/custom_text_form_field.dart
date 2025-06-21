import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:stream_transform/stream_transform.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';

final class SearchTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String val) onChanged;
  final String labelText;

  const SearchTextFormField({
    required this.controller,
    required this.labelText,
    required this.onChanged,
    super.key,
  });

  @override
  State<SearchTextFormField> createState() => _SearchTextFormFieldState();
}

final class _SearchTextFormFieldState extends State<SearchTextFormField> {
  final StreamController<String> streamController = StreamController();

  @override
  void initState() {
    super.initState();
    streamController.stream
        .debounce(const Duration(milliseconds: 800))
        .listen((value) => widget.onChanged(value));
  }

  @override
  TextFormField build(BuildContext context) => TextFormField(
    controller: widget.controller,
    decoration: InputDecoration(
      labelText: widget.labelText,
      labelStyle: const TextStyle(
        fontSize: 13,
        fontFamily: "HelveticaNeueLTArabic",
        color: ColorConstants.primaryColor,
      ),
      floatingLabelBehavior: FloatingLabelBehavior.never,
      // Rounded border
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorConstants.greyColor),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorConstants.greyColor),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: ColorConstants.greyColor, width: 2),
      ),
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 10),
        child: Icon(Icons.search, size: 25, color: ColorConstants.primaryColor),
      ),
      suffixIconConstraints: const BoxConstraints(
        maxHeight: 30,
        maxWidth: 30,
        minHeight: 30,
        minWidth: 30,
      ),
    ),
    style: const TextStyle(
      fontWeight: FontWeight.normal,
      color: ColorConstants.primaryColor,
      fontFamily: "HelveticaNeueLTArabic",
    ),
    validator: null,
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    onChanged: (value) => streamController.add(value),
    onSaved: (val) => widget.controller.text = val!,
  );
}
