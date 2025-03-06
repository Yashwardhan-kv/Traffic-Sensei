// traffic_model.dart
import 'dart:convert';
import 'package:http/http.dart' as http;

class TrafficModel {
  final int hour;
  final String dayOfWeek;
  final String weather;
  final String predictionText;
  final String congestionLevel;

  TrafficModel({
    required this.hour,
    required this.dayOfWeek,
    required this.weather,
    required this.predictionText,
    required this.congestionLevel,
  });

  factory TrafficModel.fromJson(Map<String, dynamic> json) {
    return TrafficModel(
      hour: json['Hour'],
      dayOfWeek: json['Day of Week'],
      weather: json['Weather'],
      predictionText: json['Prediction Text'],
      congestionLevel: json['Congestion Level'],
    );
  }
}
