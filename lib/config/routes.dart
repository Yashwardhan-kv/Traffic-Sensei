// routes.dart
import 'package:flutter/material.dart';
import 'package:traffic_sensei/screens/home_screen.dart';
import 'package:traffic_sensei/screens/map_screen.dart';
import 'package:traffic_sensei/screens/prediction_screen.dart';
import 'package:traffic_sensei/screens/result_screen.dart';
import 'package:traffic_sensei/screens/splash_screen.dart';

class AppRoutes {
  static const String home = '/home';
  static const String map = '/map';
  static const String prediction = '/prediction';
  static const String splash = '/';
  static const String result = '/result';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomeScreen(),
    map: (context) => const MapScreen(),
    prediction: (context) => _buildPredictionScreen(context),
    result: (context) => _buildResultScreen(context),
  };

  // Function to navigate with arguments
  static void navigateTo(BuildContext context, String routeName, {Map<String, dynamic>? args}) {
    Navigator.pushNamed(context, routeName, arguments: args);
  }

  // Route Generator Function
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case map:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case prediction:
        return MaterialPageRoute(builder: (context) => _buildPredictionScreen(context, settings.arguments));
      case result:
        return MaterialPageRoute(builder: (context) => _buildResultScreen(context, settings.arguments));
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }

  // Helper Functions to Handle Arguments
  static Widget _buildPredictionScreen(BuildContext context, [Object? arguments]) {
    final args = arguments as Map<String, dynamic>?;
    if (args == null || !args.containsKey('congestionLevel')) {
      return _errorScreen("Error: Congestion Level Not Provided");
    }
    return PredictionScreen(congestionLevel: args['congestionLevel']);
  }

  static Widget _buildResultScreen(BuildContext context, [Object? arguments]) {
    final args = arguments as Map<String, dynamic>?;
    if (args == null || !args.containsKey('prediction') || !args.containsKey('congestionLevel')) {
      return _errorScreen("Error: Missing Required Arguments");
    }
    return ResultScreen(
      prediction: args['prediction'],
      congestionLevel: args['congestionLevel'],
    );
  }

  static Widget _errorScreen(String message) {
    return Scaffold(
      body: Center(
        child: Text(message, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.red)),
      ),
    );
  }
}
