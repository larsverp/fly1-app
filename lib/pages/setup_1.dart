// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fly_1_app/widgets/default_button.dart';
import 'package:app_settings/app_settings.dart';

class Setup1 extends StatefulWidget {
  final Function goToNextPage;

  const Setup1(this.goToNextPage);

  @override
  State<Setup1> createState() => _Setup1State();
}

class _Setup1State extends State<Setup1> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Fly-1',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xff002366),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                "We'll make sure you stick",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                  color: Color(0xff002366),
                ),
              ),
            ),
            const Text(
              "to your sleeping schedule",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w300,
                color: Color(0xff002366),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 150),
              child: Text(
                'Get started by connecting',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff002366),
                ),
              ),
            ),
            const Text(
              'to "Fly-1" WiFi network.',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xff002366),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: defaultButton('Go to your WiFi settings', () async {
                AppSettings.openWIFISettings();
                widget.goToNextPage(1);
              }),
            )
          ],
        ),
      ),
    );
  }
}
