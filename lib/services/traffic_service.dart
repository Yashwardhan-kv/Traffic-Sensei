// traffic_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:traffic_sensei/models/traffic_model.dart';

class TrafficService {
  static const String apiUrl = "https://traffic-sensei.onrender.com/predict"; // Replace with actual API URL

  static Future<TrafficModel?> fetchPrediction(int hour, String day, String weather) async {
    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "Hour": hour,
          "Day of Week": day,
          "Weather": weather,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        return TrafficModel.fromJson(data);
      } else {
        print("Error: ${response.statusCode} - ${response.body}");
        return null;
      }
    } catch (e) {
      print("Network error: $e");
      return null;
    }
  }
}