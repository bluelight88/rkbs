import 'dart:async';

// ignore: depend_on_referenced_packages
import 'package:stream_transform/stream_transform.dart';
import 'package:flutter/material.dart';
import 'color_constants.dart';

final class SearchTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final void Function(String val) onChanged;
  final GestureTapCallback? onTapSuffix;
  final String labelText;
  final IconData image;
  final bool enable, isPassword, isVisible;
  final String? Function(String?)? validator;

  const SearchTextFormField({
    required this.controller,
    required this.labelText,
    required this.onChanged,
    this.onTapSuffix,
    this.enable = false,
    this.isPassword = false,
    this.isVisible = false,
    this.image = Icons.search,
    this.validator,
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
    validator: widget.validator,
    decoration: InputDecoration(
      labelText: widget.labelText,
      labelStyle: const TextStyle(
        fontSize: 15,
        fontFamily: "PlusJakartaSans",
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
        child: InkWell(
          onTap: widget.onTapSuffix,
          child: Icon(
            widget.image,
            size: 20,
            color: ColorConstants.primaryColor,
          ),
        ),
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
      fontFamily: "PlusJakartaSans",
    ),
    autovalidateMode: AutovalidateMode.onUserInteraction,
    obscureText: widget.isPassword ? widget.isVisible : false,
    enabled: widget.enable,
    onTapOutside: (event) => FocusScope.of(context).unfocus(),
    onChanged: (value) => streamController.add(value),
    onSaved: (val) => widget.controller.text = val!,
  );
}
