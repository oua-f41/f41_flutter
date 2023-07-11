import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText({super.key, required this.text});

  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .headlineSmall
            ?.copyWith(fontSize: 25, fontWeight: FontWeight.bold));
  }
}
