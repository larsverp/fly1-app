// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;

  const DefaultTextField({required this.hintText, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
          maxWidth: 230, maxHeight: 50, minHeight: 50, minWidth: 230),
      child: TextField(
          controller: controller,
          autofocus: false,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Color(0xff002366), fontSize: 14),
          cursorColor: Colors.white,
          decoration: InputDecoration(
            labelText: hintText,
            labelStyle: const TextStyle(color: Color(0xff002366), fontSize: 14),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Color(0xff002366)),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1, color: Color(0xff002366)),
              borderRadius: BorderRadius.circular(25),
            ),
          )),
    );
  }
}

class CustomRangeTextInputFormatter extends TextInputFormatter {
  final int min;
  final int max;

  CustomRangeTextInputFormatter(this.min, this.max);

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text == '') {
      return newValue;
    } else if (int.parse(newValue.text) < min) {
      return const TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return int.parse(newValue.text) > max ? oldValue : newValue;
    }
  }
}
