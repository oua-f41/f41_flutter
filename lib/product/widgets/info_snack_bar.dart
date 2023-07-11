import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class InfoSnackBar extends SnackBar {
  InfoSnackBar(
      {this.onPressed,
      required this.contentText,
      super.key,
      BuildContext? context})
      : super(
            backgroundColor: context?.colorScheme.secondary ?? Colors.grey,
            content: Row(
              children: [
                const Icon(Icons.info_outline),
                FittedBox(
                  fit: BoxFit.fitWidth,
                  child: Container(
                    padding: context?.horizontalPaddingLow ??
                        const EdgeInsets.symmetric(horizontal: 8),
                    width: context?.dynamicWidth(0.7) ?? 280,
                    child: Text(
                      contentText,
                      softWrap: true,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: ShapeBorder.lerp(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                1),
            action: onPressed != null
                ? SnackBarAction(
                    label: "Retry",
                    onPressed: () {
                      onPressed();
                    },
                  )
                : null);

  final VoidCallback? onPressed;
  final String contentText;
}
