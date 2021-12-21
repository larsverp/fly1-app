import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TimeTextField extends StatelessWidget {
  final String hintText;
  final int minValue;
  final int maxValue;
  final TextEditingController controller;

  const TimeTextField({
    Key? key,
    required this.hintText,
    required this.minValue,
    required this.maxValue,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 100, maxHeight: 50),
        child: TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              CustomRangeTextInputFormatter(minValue, maxValue),
            ],
            autofocus: false,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Color(0xff002366), fontSize: 20),
            cursorColor: Colors.white,
            decoration: InputDecoration(
              labelText: hintText,
              labelStyle:
                  const TextStyle(color: Color(0xff002366), fontSize: 14),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xff002366)),
                borderRadius: BorderRadius.circular(25),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(width: 1, color: Color(0xff002366)),
                borderRadius: BorderRadius.circular(25),
              ),
            )),
      ),
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
