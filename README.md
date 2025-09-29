🚀 FAN IT Mobile Test – aditiswadi_mdtest

📌 Description
Mobile application for FAN IT Mobile Developer Technical Test.
Built with Flutter using Clean Architecture + BLoC (Business Logic Component) to ensure well-structured, scalable, and maintainable code.

You can watch the demo video of the application here:  
👉 [Watch Demo on Google Drive](https://drive.google.com/file/d/1sFQdyqRpLeythjAqrHTGh8wWBOOrwHXH/view?usp=sharing)

Main features:
- Authentication: Login, Register, Forgot Password
- Email Verification with real-time status updates
- Home Page displaying user list from Cloud Firestore
- Search & Filter users by email verification status
- Password Reset
- Unit Testing for critical components (Auth, Email Verification, Password Reset, Firestore Retrieval)

🛠️ Tech Stack
- Flutter → Chosen because it allows cross-platform development (Android & iOS) with a single codebase, offers excellent performance with its own rendering engine, and provides a rich set of UI components.
- Firebase Authentication → Simplifies user authentication with email/password login, registration, password reset, and email verification, removing the need to build a custom backend for auth.
- Firebase Firestore → A cloud-hosted NoSQL database that supports real-time data sync, making it ideal for displaying and updating user lists dynamically.
- BLoC (flutter_bloc) → Used for state management to ensure a predictable, testable, and scalable way of handling UI states, separating business logic from presentation.
- GetIt → A service locator that enables clean dependency injection, improving modularity and testability of the codebase.
- Equatable → Helps simplify equality checks in entities and models, making BLoC state comparison more efficient and reducing boilerplate code.
- Mockito → Used for unit testing with mocks, allowing tests to run without relying on actual Firebase services (important for testing authentication, data retrieval, etc.).
- Google Fonts → Provides access to a wide variety of fonts, improving the UI/UX design and making the app look more modern and professional.

📦 Dependencies
- dependencies:
  bloc: ^9.0.1
  build_runner: ^2.8.0,
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
- dev_dependencies:
  flutter_lints: ^5.0.0
  flutter_test:
    sdk: flutter

⚙️ Installation & Setup
1. Clone Repository
   - git clone https://github.com/aditiswadi/aditiswadi_mdtest.git
   - cd aditiiswadi_mdtest
2. Install Dependencies
   - flutter pub get
3. Setup Firebase
   - Create a new project in Firebase Console
   - Enable Authentication (Email/Password) and Firestore Database
4. Add the Firebase configuration files:
   - Android → android/app/google-services.json
   - iOS → ios/Runner/GoogleService-Info.plist
   - Make sure firebase_core is initialized in main.dart.
5. Run Application
   - flutter run
   
🧪 Running Tests
- flutter test

📖 Additional Notes
Architecture follows Clean Architecture, separating data, domain, and presentation layers.
flutter_bloc is chosen for predictable, testable, and scalable state management.
GetIt is used for dependency injection to decouple layers.
Mockito is used for mocking in unit tests.
Google Fonts is used for improved UI styling.
