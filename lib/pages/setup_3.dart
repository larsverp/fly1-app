// ignore_for_file: use_key_in_widget_constructors

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fly_1_app/widgets/default_button.dart';
import 'package:http/http.dart' as http;

class Setup3 extends StatefulWidget {
  final Function goToNextPage;

  const Setup3(this.goToNextPage);

  @override
  State<Setup3> createState() => _Setup3State();
}

class _Setup3State extends State<Setup3> {
  bool error = false;

  void setIP() async {
    var ip = await getIP();
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('ip', ip);
    testConnection(ip);
  }

  void testConnection(String ip) async {
    try {
      final response = await http.get(Uri.parse('http://' + ip + '/data'));

      if (response.statusCode == 200) {
        widget.goToNextPage(1);
      }
    } catch (e) {
      setState(() {
        error = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    setIP();
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Disconnected',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Color(0xff002366),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Text(
                'Looking for your Fly-1 on network "Bocht',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Color(0xff002366),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 75.0),
              child: !error
                  ? const SizedBox(
                      width: 75,
                      height: 75,
                      child: CircularProgressIndicator(
                        strokeWidth: 6,
                        valueColor:
                            AlwaysStoppedAnimation<Color>(Color(0xff002366)),
                      ))
                  : Padding(
                      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                      child: Column(
                        children: [
                          const Text(
                            "We couldn't find your Fly-1, please restart the fly-1 and try again.",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.red,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0),
                            child: defaultButton("Retry", () {
                              setState(() {
                                error = false;
                              });
                              setIP();
                            }),
                          )
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class IPresponse {
  final String ip;

  IPresponse({required this.ip});

  factory IPresponse.fromJson(Map<String, dynamic> data) {
    final ip = data['ip'] as String;
    return IPresponse(ip: ip);
  }
}

Future<String> getIP() async {
  final prefs = await SharedPreferences.getInstance();
  final id = prefs.getString('id');
  var ip = "";
  while (ip == "") {
    try {
      final response = await http.get(Uri.parse(
          'https://fly1-server.herokuapp.com/get-ip?id=' + id.toString()));

      final responseJson = json.decode(response.body);

      if (response.statusCode == 200) {
        IPresponse ipResponse = IPresponse.fromJson(responseJson);
        ip = ipResponse.ip;
      }
    } catch (e) {
      // print(e);
    }
  }
  return ip;
}
