// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fly_1_app/widgets/default_button.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Setup4 extends StatefulWidget {
  final Function goToNextPage;

  const Setup4(this.goToNextPage);

  @override
  State<Setup4> createState() => _Setup4State();
}

class _Setup4State extends State<Setup4> {
  String ip = "";

  void getIp() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      ip = prefs.getString('ip').toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    getIp();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Ready for',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xff002366),
              ),
            ),
            const Text(
              'take off',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xff002366),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Text(
                "We have detected your Fly-1",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff002366),
                ),
              ),
            ),
            Text(
              "on IP: " + ip,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Color(0xff002366),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: defaultButton("Continue", () {
                widget.goToNextPage(1);
              }),
            ),
          ],
        ),
      ),
    );
  }
}
