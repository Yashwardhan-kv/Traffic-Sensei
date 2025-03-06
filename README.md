# traffi_sensei

A new Flutter project.

## File Structure
📂 traffi_sensei/
│── 📂 android/              # Android-specific configurations
│── 📂 ios/                  # iOS-specific configurations
│── 📂 lib/                  # Main Flutter app code
│   │── 📂 models/           # Data models
│   │   ├── traffic_model.dart
|   ├── 📂 config
│   │   ├── routes.dart
│   │   ├── theme.dart
│   │── 📂 services/         # API Calls, AI model integration
│   │   ├── traffic_service.dart
│   │── 📂 screens/          # UI Screens
│   │   ├── splash_screen.dart
│   │   ├── home_screen.dart
│   │   ├── map_screen.dart
│   │   ├── prediction_screen.dart
│   ├── 📂 providers
│   │   ├── app_provider.dart
│   │── 📂 widgets/          # Reusable UI components
│   │   ├── custom_button.dart
│   │   ├── traffic_card.dart
│   │── 📂 utils/            # Helper functions, constants
│   │   ├── colors.dart
│   │   ├── app_constants.dart
|   |   ├── utils.dart 
│   │── main.dart            # App entry point
│── 📂 assets/               # Images, icons, and other resources
│   ├── splash_logo.png
│   ├── map_style.json
│── 📂 test/                 # Unit and Widget tests
│── pubspec.yaml             # Dependencies and project configurations
│── README.md                # Project documentation
