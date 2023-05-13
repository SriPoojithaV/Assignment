# Task Flutter App

This is a basic Tasks app built with Flutter. It provides basic CRUD (Create, Read, Update, Delete) functionality with Flutter app development.

## Features

- Add new tasks with a title and description.
- View a list of tasks.
- Update existing tasks.
- Delete tasks.

## Prerequisites

To build a Flutter app, you'll need the following prerequisites:

1. **Flutter SDK**: Flutter is a UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase. You need to install the Flutter SDK, which includes the Flutter framework and Dart programming language. Visit the [Flutter website](https://flutter.dev) and follow the installation instructions specific to your operating system.

2. **Dart SDK**: Dart is the programming language used by Flutter. The Flutter SDK includes a version of the Dart SDK, so you don't need to install it separately. However, it's recommended to ensure you have the latest version of the Dart SDK compatible with the Flutter version you're using.

3. **Integrated Development Environment (IDE)**: Although not strictly required, using an IDE greatly enhances your productivity while developing Flutter apps. Two popular options are:

   - **Visual Studio Code (VS Code)**: A lightweight, free, and highly extensible code editor with excellent Flutter and Dart support. Install the [Flutter extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.flutter) and the [Dart extension](https://marketplace.visualstudio.com/items?itemName=Dart-Code.dart-code) for VS Code.
   - **Android Studio**: A full-featured integrated development environment (IDE) for Android, which also has built-in Flutter and Dart support. Install [Android Studio](https://developer.android.com/studio), and then configure the Flutter and Dart plugins from the settings.

4. **Android Emulator or iOS Simulator**: To test your app, you'll need an emulator/simulator. Flutter provides an embedded Android emulator, called the Android Virtual Device (AVD), which can be launched from the Android Studio AVD Manager. For iOS, you can use the iOS Simulator that comes with Xcode, Apple's developer toolset.

5. **Device Setup**: If you prefer testing on a physical device, you need to enable developer options on your Android device or enroll in the Apple Developer Program to deploy apps on iOS devices.

Once you have set up the above prerequisites, you are ready to start developing Flutter apps!

## Getting Started

1. Unzip the code folder to your local machine:
2. Navigate to the project directory:

3. Install the required dependencies:

   ```bash
   flutter pub get
   ```

4. Run the app on your preferred device/emulator:

   ```bash
   flutter run
   ```

   Alternatively, you can use the Flutter IDE plugins (e.g., Android Studio or Visual Studio Code) to run the app.

## Usage

- When you launch the app, you will see a list of existing tasks (if any).
- To add a new task, tap on the floating action button at the bottom of the screen.
- Enter the task title in the provided text field and tap the "Add" button.
- To update a task, tap on it in the list.
- Update the task title and tap the "Update" button.
- To delete a task, swipe it to the left or right in the list.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvements, please feel free to submit a pull request or create an issue in the repository.

When contributing, please adhere to the existing code style and follow the [Flutter style guide](https://flutter.dev/docs/development/ui/layout/style-guide).

## License

This project is licensed under the [MIT License](LICENSE). Feel free to modify and distribute this code as per the terms of the license.