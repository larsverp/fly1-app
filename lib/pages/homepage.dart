// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fly_1_app/widgets/default_button.dart';
import 'package:fly_1_app/widgets/time_text_field.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final wakeupHour = TextEditingController();
final wakeupMinute = TextEditingController();
final sleepHour = TextEditingController();
final sleepMinute = TextEditingController();

var buttonText = 'Save';

class HomePage extends StatefulWidget {
  final Function goToNextPage;

  const HomePage(this.goToNextPage);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Fly-1',
                style: TextStyle(
                  fontSize: 48,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff002366),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'At what time do you want to wake up?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff002366),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimeTextField(
                      controller: wakeupHour,
                      hintText: "hour",
                      minValue: 0,
                      maxValue: 23,
                    ),
                    const Text(
                      " : ",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff002366),
                      ),
                    ),
                    TimeTextField(
                      controller: wakeupMinute,
                      hintText: "minute",
                      minValue: 0,
                      maxValue: 59,
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 30),
                child: Text(
                  'For how long do you want to sleep?',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Color(0xff002366),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0, right: 20, left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TimeTextField(
                      controller: sleepHour,
                      hintText: "hours",
                      minValue: 0,
                      maxValue: 23,
                    ),
                    const Text(
                      " : ",
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff002366),
                      ),
                    ),
                    TimeTextField(
                      controller: sleepMinute,
                      hintText: "minutes",
                      minValue: 0,
                      maxValue: 59,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultButton(buttonText, () async {
                  setState(() {
                    buttonText = "Saving...";
                  });
                  if (await setTime()) {
                    setState(() {
                      buttonText = "Saved";
                    });
                  } else {
                    setState(() {
                      buttonText = "Error! Try again";
                    });
                  }
                }),
              )
            ],
          ),
        ));
  }
}

Future<bool> setTime() async {
  final prefs = await SharedPreferences.getInstance();
  final ip = prefs.getString('ip').toString();
  final response = await http.get(Uri.parse('http://' +
      ip +
      '/data?wakeuptimehour=' +
      wakeupHour.text +
      '&wakeuptimeminute=' +
      wakeupMinute.text +
      '&sleeptimehour=' +
      sleepHour.text +
      '&sleeptimeminute=' +
      sleepMinute.text));
  if (response.statusCode == 200) {
    return true;
  }
  return false;
}
