import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prac_http_api/controllers/login_controller.dart';
import 'package:http/http.dart' as http;
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  String _stepsCount = "";
  final _authController=Get.find<AuthController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            child: GestureDetector(
              onTap: ()=>_authController.signOut(),
              child: Center(
                child: Text("Sign Out"),
              ),
            ),
          )
        ],
      ),
      body: _buildBody(),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onMenuItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: 'Get Steps Count',
          ),
        ],
      ),
    );
  }
  void _onMenuItemTapped(int index) {
    if (index == 1) {
      _getStepsCountFromServer();
    }
    setState(() {
      _currentIndex = index;
    });
  }
  Future<void> _getStepsCountFromServer() async {
    final url = Uri.parse('http://qaapi.withstandfitness.com/Health/syncdata');

    final data = {
      "userId": 1,
      "data": [
        {
          "value": {"numericValue": "9000"},
          "data_type": "STEPS",
          "unit": "COUNT",
          "date_from": "2023-07-19T17:26:00.000",
          "date_to": "2023-07-19T17:56:00.000",
          "platform_type": "android",
          "device_id": "SP1A.210812.003",
          "source_id": "raw:com.google.step_count.delta:com.google.android.apps.fitness:user_input",
          "source_name": "com.google.android.apps.fitness"
        },
        // Add other data entries here
      ]
    };

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final stepsData = responseData["data"].where((entry) => entry["data_type"] == "STEPS").toList();

        int totalSteps = 0;
        for (var entry in stepsData) {
          totalSteps += int.parse(entry["value"]["numericValue"]);
        }

        setState(() {
          _stepsCount = totalSteps.toString();
        });
      } else {
        print("Failed to fetch steps count. Status code: ${response.statusCode}");
        setState(() {
          _stepsCount = "Failed to fetch steps count.";
        });
      }
    } catch (e) {
      print("Error fetching steps count: $e");
      setState(() {
        _stepsCount = "Error fetching steps count.";
      });
    }
  }
  Widget _buildBody() {
    if (_currentIndex == 0) {
      return Center(child: Text('Home Screen'));
    } else if (_currentIndex == 1) {
      return Center(child: Text('Steps Count: $_stepsCount'));
    } else {
      return Container();
    }
  }
}
