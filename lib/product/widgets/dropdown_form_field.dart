import 'package:flutter/material.dart';

class DropdownFormField extends StatelessWidget {
  const DropdownFormField(
      {super.key, required this.onTap, this.value, required this.label});

  final Function() onTap;
  final String? value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
          padding:
              MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(0.0)),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.transparent)))),
      onPressed: () {
        onTap();
      },
      child: TextFormField(
        enabled: false,
        decoration: InputDecoration(
          suffixIcon: const Icon(Icons.arrow_drop_down),
          label: Text(value ?? label),
        ),
        onChanged: (value) {},
      ),
    );
  }
}
