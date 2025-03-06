// prediction_screen.dart
import 'package:flutter/material.dart';

class PredictionScreen extends StatelessWidget {
  final String congestionLevel;

  const PredictionScreen({Key? key, required this.congestionLevel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Traffic Prediction Result")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Predicted Traffic Congestion Level:",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              congestionLevel,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: congestionLevel == "High" ? Colors.red : congestionLevel == "Medium" ? Colors.orange : Colors.green,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}