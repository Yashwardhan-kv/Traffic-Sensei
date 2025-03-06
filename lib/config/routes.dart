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
    prediction: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args == null || !args.containsKey('congestionLevel')) {
        return const Scaffold(
          body: Center(child: Text("Error: Congestion Level Not Provided")),
        );
      }
      return PredictionScreen(congestionLevel: args['congestionLevel']);
    },
    result: (context) {
      final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
      if (args == null || !args.containsKey('prediction') || !args.containsKey('congestionLevel')) {
        return const Scaffold(
          body: Center(child: Text("Error: Missing Required Arguments")),
        );
      }
      return ResultScreen(
        prediction: args['prediction'],
        congestionLevel: args['congestionLevel'],
      );
    },
  };

  // Function to navigate with arguments
  static void navigateTo(BuildContext context, String routeName, {Map<String, dynamic>? args}) {
    Navigator.pushNamed(context, routeName, arguments: args);
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case map:
        return MaterialPageRoute(builder: (_) => const MapScreen());
      case prediction:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null || !args.containsKey('congestionLevel')) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text("Error: Congestion Level Not Provided")),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => PredictionScreen(congestionLevel: args['congestionLevel']),
        );
      case result:
        final args = settings.arguments as Map<String, dynamic>?;
        if (args == null || !args.containsKey('prediction') || !args.containsKey('congestionLevel')) {
          return MaterialPageRoute(
            builder: (_) => const Scaffold(
              body: Center(child: Text("Error: Missing Required Arguments")),
            ),
          );
        }
        return MaterialPageRoute(
          builder: (_) => ResultScreen(
            prediction: args['prediction'],
            congestionLevel: args['congestionLevel'],
          ),
        );
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
}
