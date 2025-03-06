import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:traffic_sensei/config/routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Traffic Sensei',
      theme: ThemeData(
        primarySwatch: Colors.purple, // Changed to MaterialColor
      ),
      initialRoute: '/',
      routes: AppRoutes.routes,
    );
  }
}

// Splash Screen with Animation
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: FadeTransition(
          opacity: _animation,
          child: Image.asset('assets/logo_splash.png', width: 200),
        ),
      ),
    );
  }
}

// Home Screen
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _hour = 12;
  int _day = 1;
  int _weather = 0;
  String _prediction = "";

  Future<void> fetchPrediction() async {
    final response = await http.post(
      Uri.parse("http://your-backend-api.com/predict"), // Replace with actual API
      body: jsonEncode({"Hour": _hour, "Day of Week": _day, "Weather": _weather}),
      headers: {"Content-Type": "application/json"},
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      setState(() {
        _prediction = "Predicted Congestion: ${data['Congestion Level']}";
      });
    } else {
      setState(() {
        _prediction = "Error fetching prediction";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Traffic Sensei")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: _hour,
              items: List.generate(24, (index) =>
                DropdownMenuItem(value: index, child: Text("Hour: $index"))
              ),
              onChanged: (val) => setState(() => _hour = val!),
            ),
            DropdownButton<int>(
              value: _day,
              items: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
                  .asMap()
                  .entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (val) => setState(() => _day = val!),
            ),
            DropdownButton<int>(
              value: _weather,
              items: ["Clear", "Cloudy", "Rainy", "Foggy"]
                  .asMap()
                  .entries
                  .map((e) => DropdownMenuItem(value: e.key, child: Text(e.value)))
                  .toList(),
              onChanged: (val) => setState(() => _weather = val!),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: fetchPrediction,
              child: const Text("Predict Traffic"),
            ),
            const SizedBox(height: 20),
            Text(
              _prediction,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
