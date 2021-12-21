import 'package:flutter/material.dart';

ElevatedButton defaultButton(String text, Function() saveData) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: const Color(0xff002366),
          onPrimary: Colors.white,
          minimumSize: const Size(230, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          )),
      onPressed: saveData,
      child: Text(text));
}
