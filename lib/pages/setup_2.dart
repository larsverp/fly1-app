// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fly_1_app/widgets/default_button.dart';
import 'package:fly_1_app/widgets/default_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final ssidField = TextEditingController();
final passwordField = TextEditingController();

var buttonText = "Save WiFi credentials";

class Setup2 extends StatefulWidget {
  final Function goToNextPage;

  const Setup2(this.goToNextPage);
  @override
  State<Setup2> createState() => _Setup2State();
}

class _Setup2State extends State<Setup2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Connected',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xff002366),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "Please enter your WiFi credentials",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff002366),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: DefaultTextField(hintText: "Ssid", controller: ssidField),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: DefaultTextField(
                  hintText: 'Password', controller: passwordField),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 25.0),
              child: defaultButton(buttonText, () async {
                if (await setWiFi()) {
                  widget.goToNextPage(1);
                } else {
                  setState(() {
                    buttonText = "Error! Try again";
                  });
                }
              }),
            )
          ],
        ),
      ),
    );
  }
}

Future<bool> setWiFi() async {
  final response = await http.get(Uri.parse('http://10.10.10.1/data?ssid=' +
      ssidField.text +
      '&password=' +
      passwordField.text));

  if (response.statusCode == 200) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('id', response.body.toString());
    return true;
  }
  return false;
}
