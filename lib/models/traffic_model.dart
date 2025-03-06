// traffic_model.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrafficModel {
  final int hour;
  final String dayOfWeek;
  final String weather;
  final String congestionLevel;

  TrafficModel({
    required this.hour,
    required this.dayOfWeek,
    required this.weather,
    required this.congestionLevel,
  });

  factory TrafficModel.fromJson(Map<String, dynamic> json) {
    return TrafficModel(
      hour: json['Hour'],
      dayOfWeek: json['Day of Week'],
      weather: json['Weather'],
      congestionLevel: json['Congestion Level'],
    );
  }
}

class TrafficService {
  static const String apiUrl = "http://your-backend-api.com/predict"; // Replace with actual API URL

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
