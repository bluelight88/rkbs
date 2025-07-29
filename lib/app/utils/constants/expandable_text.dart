import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class ExpandableText extends StatefulWidget {
  final String text;
  final TextStyle? style;
  final int trimLines;

  const ExpandableText({
    super.key,
    required this.text,
    this.style,
    this.trimLines = 3,
  });

  @override
  State<ExpandableText> createState() => _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, size) {
      final span = TextSpan(text: widget.text, style: widget.style);
      final tp = TextPainter(
        text: span,
        maxLines: widget.trimLines,
        textDirection: TextDirection.ltr,
        ellipsis: '...',
      );
      tp.layout(maxWidth: size.maxWidth);

      _isOverflowing = tp.didExceedMaxLines;

      if (!_isOverflowing) {
        // Just return plain text if it doesn't overflow
        return Text(widget.text, style: widget.style);
      }

      if (_isExpanded) {
        return RichText(
          text: TextSpan(
            style: widget.style,
            children: [
              TextSpan(text: widget.text),
              const TextSpan(text: ' '),
              TextSpan(
                text: 'Show less',
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => setState(() => _isExpanded = false),
              ),
            ],
          ),
        );
      } else {
        final link = ' Show more';
        final truncatedText = _truncateText(
          widget.text,
          widget.style!,
          size.maxWidth,
          widget.trimLines,
          link,
        );

        return RichText(
          text: TextSpan(
            style: widget.style,
            children: [
              TextSpan(text: truncatedText),
              TextSpan(
                text: link,
                style: const TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap = () => setState(() => _isExpanded = true),
              ),
            ],
          ),
        );
      }
    });
  }

  String _truncateText(String text, TextStyle style, double maxWidth, int maxLines, String link) {
    String result = text;
    int end = text.length;
    int start = 0;

    while (start < end) {
      final mid = (start + end) ~/ 2;
      final testText = '${text.substring(0, mid).trimRight()}...$link';
      final tp = TextPainter(
        text: TextSpan(text: testText, style: style),
        maxLines: maxLines,
        textDirection: TextDirection.ltr,
      );
      tp.layout(maxWidth: maxWidth);

      if (tp.didExceedMaxLines) {
        end = mid;
      } else {
        result = text.substring(0, mid);
        start = mid + 1;
      }
    }

    return '${result.trimRight()}...';
  }
}
