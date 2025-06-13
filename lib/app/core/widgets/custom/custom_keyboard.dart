import 'package:flutter/material.dart';

import '../../../utils/constants/color_constants.dart';

final class CustomKeyboard extends StatelessWidget {
  const CustomKeyboard({
    required this.onTextInput,
    required this.onBackspace,
    super.key,
  });

  final ValueSetter<String> onTextInput;
  final VoidCallback onBackspace;

  void _textInputHandler(String text) => onTextInput.call(text);

  void _backspaceHandler() => onBackspace.call();

  @override
  Directionality build(BuildContext context) => Directionality(
    textDirection: TextDirection.ltr,
    child: Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(1, -7),
            blurRadius: 5,
            spreadRadius: 0.5,
          ),
        ],
        color: ColorConstants.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      height: 250,
      child: Column(
        children: [
          const SizedBox(height: 15),
          buildRow(["1", "2", "3"]),
          buildRow(["4", "5", "6"]),
          buildRow(["7", "8", "9"]),
          buildRowFour(),
        ],
      ),
    ),
  );

  Expanded buildRow(List<String> list) => Expanded(
    child: Row(
      children: List.generate(
        3,
        (index) => TextKey(text: list[index], onTextInput: _textInputHandler),
      ),
    ),
  );

  Expanded buildRowFour() => Expanded(
    child: Row(
      children: [
        const Expanded(
          child: Padding(
            padding: EdgeInsets.all(1.0),
            child: Center(child: Text("")),
          ),
        ),
        TextKey(text: '0', onTextInput: _textInputHandler),
        BackspaceKey(onBackspace: _backspaceHandler),
      ],
    ),
  );
}

final class TextKey extends StatelessWidget {
  const TextKey({
    required this.text,
    required this.onTextInput,
    super.key,
    this.flex = 1,
  });

  final String text;
  final ValueSetter<String> onTextInput;
  final int flex;

  @override
  Expanded build(BuildContext context) => Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: () => onTextInput.call(text),
        child: Center(child: Text(text, style: const TextStyle(fontSize: 24))),
      ),
    ),
  );
}

final class BackspaceKey extends StatelessWidget {
  const BackspaceKey({required this.onBackspace, super.key, this.flex = 1});

  final VoidCallback onBackspace;
  final int flex;

  @override
  Expanded build(BuildContext context) => Expanded(
    flex: flex,
    child: Padding(
      padding: const EdgeInsets.all(1.0),
      child: InkWell(
        onTap: () => onBackspace.call(),
        child: const Center(child: Icon(Icons.backspace)),
      ),
    ),
  );
}
