// home_screen.dart
import 'package:flutter/material.dart';
import 'package:traffic_sensei/screens/result_screen.dart';
import 'package:traffic_sensei/services/traffic_service.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _hourController = TextEditingController();
  String _selectedDay = "Monday";
  String _selectedWeather = "Clear";
  bool _isLoading = false;

  Future<void> _getPrediction() async {
    setState(() => _isLoading = true);
    int hour = int.tryParse(_hourController.text) ?? 0;
    var prediction = await TrafficService.fetchPrediction(hour, _selectedDay, _selectedWeather);
    setState(() => _isLoading = false);
    
    if (prediction != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultScreen(
            prediction: prediction, 
            congestionLevel: prediction.congestionLevel,
          ), 

        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to fetch prediction. Try again!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Traffic Predictor")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Enter Hour (0-23):"),
            TextField(controller: _hourController, keyboardType: TextInputType.number),
            const SizedBox(height: 10),
            const Text("Select Day:"),
            DropdownButton<String>(
              value: _selectedDay,
              onChanged: (value) => setState(() => _selectedDay = value!),
              items: ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"]
                  .map((day) => DropdownMenuItem(value: day, child: Text(day)))
                  .toList(),
            ),
            const SizedBox(height: 10),
            const Text("Select Weather:"),
            DropdownButton<String>(
              value: _selectedWeather,
              onChanged: (value) => setState(() => _selectedWeather = value!),
              items: ["Clear", "Rainy", "Snowy", "Foggy", "Stormy"]
                  .map((weather) => DropdownMenuItem(value: weather, child: Text(weather)))
                  .toList(),
            ),
            const SizedBox(height: 20),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _getPrediction,
                    child: const Text("Predict Traffic"),
                  ),
          ],
        ),
      ),
    );
  }
}