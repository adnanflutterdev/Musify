import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:musify/core/extension/app_theme_extention.dart';

class CollapsibleText extends StatefulWidget {
  const CollapsibleText({
    super.key,
    required this.text,
    this.style,
    this.collapseAfterWords = 100,
  });
  final String text;
  final TextStyle? style;
  final int collapseAfterWords;

  @override
  State<CollapsibleText> createState() => _CollapsibleTextState();
}

class _CollapsibleTextState extends State<CollapsibleText> {
  late bool isCollapsed;
  late bool canCollapse;

  @override
  void initState() {
    super.initState();
    isCollapsed = widget.text.length > widget.collapseAfterWords;
    canCollapse = isCollapsed;
  }

  @override
  void didUpdateWidget(covariant CollapsibleText oldWidget) {
    super.didUpdateWidget(oldWidget);
    isCollapsed = widget.text.length > widget.collapseAfterWords;
    canCollapse = isCollapsed;
  }

  @override
  Widget build(BuildContext context) {
    if (canCollapse) {
      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: isCollapsed
                  ? widget.text.substring(0, widget.collapseAfterWords)
                  : widget.text,
              style: (widget.style ?? context.text.bodyMedium),
            ),
            TextSpan(
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                  });
                },
              text: ' ${isCollapsed ? '...show more' : 'show less'}',
              style: (widget.style ?? context.text.bodyMedium)?.copyWith(
                color: context.colors.primary,
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(widget.text, style: widget.style);
    }
  }
}
