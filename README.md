# aditiswadi_mdtest
<<<<<<< HEAD

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
=======
FAN IT Mobile Developer Technical Test | Flutter + Clean Architecture + BLoC + Firebase

🚀 FAN IT Mobile Test – aditiswadi_mdtest
📌 Description

Mobile application for FAN IT Mobile Developer Technical Test.
Built with Flutter using Clean Architecture + BLoC (Business Logic Component) to ensure well-structured, scalable, and maintainable code.

Main features:

🔐 Authentication: Login, Register, Forgot Password

📩 Email Verification with real-time status updates

🏠 Home Page displaying user list from Cloud Firestore

🔎 Search & Filter users by email verification status

🔑 Password Reset

🧪 Unit Testing for critical components (Auth, Email Verification, Password Reset, Firestore Retrieval)

🛠️ Tech Stack

Flutter

Firebase Authentication

Firebase Firestore

BLoC (flutter_bloc) for state management

GetIt for dependency injection

Equatable for value equality in entities/models

Mockito for unit testing

Google Fonts for styling

📦 Dependencies
dependencies:
  bloc: ^9.0.1
  build_runner: ^2.8.0
  cloud_firestore: ^6.0.2
  cupertino_icons: ^1.0.8
  equatable: ^2.0.7
  firebase_auth: ^6.1.0
  firebase_core: ^4.1.1
  flutter:
    sdk: flutter
  flutter_bloc: ^9.1.1
  get_it: ^8.2.0
  google_fonts: ^6.3.2
  mockito: ^5.5.1

dev_dependencies:
  flutter_lints: ^5.0.0
  flutter_test:
    sdk: flutter

⚙️ Installation & Setup
1. Clone Repository
git clone https://github.com/aditiswadi/aditiswadi_mdtest.git
cd aditiiswadi_mdtest

2. Install Dependencies
flutter pub get

3. Setup Firebase

Create a new project in Firebase Console

Enable Authentication (Email/Password) and Firestore Database

Add the Firebase configuration files:

Android → android/app/google-services.json

iOS → ios/Runner/GoogleService-Info.plist

Make sure firebase_core is initialized in main.dart.

4. Run Application
flutter run

🧪 Running Tests
flutter test

📖 Additional Notes

Architecture follows Clean Architecture, separating data, domain, and presentation layers.

flutter_bloc is chosen for predictable, testable, and scalable state management.

GetIt is used for dependency injection to decouple layers.

Mockito is used for mocking in unit tests.

Google Fonts is used for improved UI styling.
>>>>>>> f8398218414f4b8a45cdff57a5ec9e4c447a375a
