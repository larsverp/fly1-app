// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:fly_1_app/pages/homepage.dart';
import 'package:fly_1_app/pages/setup_1.dart';
import 'package:fly_1_app/pages/setup_2.dart';
import 'package:fly_1_app/pages/setup_3.dart';
import 'package:fly_1_app/pages/setup_4.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fly-1',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Main> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    setIP();
  }

  void setIP() async {
    final prefs = await SharedPreferences.getInstance();
    var ip = prefs.getString('ip');
    if (ip != null) {
      testConnection(ip);
    }
  }

  void testConnection(String ip) async {
    try {
      final response = await http.get(Uri.parse('http://' + ip + '/data'));

      if (response.statusCode == 200) {
        _currentIndex = 4;
        setState(() {});
      }
    } catch (e) {
      _currentIndex = 2;
    }
  }

  @override
  Widget build(BuildContext context) {
    void navigateToPage(int index) {
      setState(() {
        _currentIndex += index;
      });
    }

    final List<Widget> pages = [
      Setup1(navigateToPage),
      Setup2(navigateToPage),
      Setup3(navigateToPage),
      Setup4(navigateToPage),
      HomePage(navigateToPage),
    ];

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
          image: AssetImage("assets/images/background.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: pages[_currentIndex],
    );
  }
}
