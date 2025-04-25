# Speciality Testing

A simple Flutter project to help users discover their natural IT talent through a series of questions.

## Project Structure

- **lib/main.dart**: Main app logic and user interface.
- **lib/functions.dart**: Functions for initializing questions and images.
- **lib/objects/question.dart**: `Question` object definition and answer logic.

## How it Works

1. The app asks a series of questions to the user.
2. Based on the user's answers (Yes/No), it navigates through a decision tree.
3. At the end, the app suggests an IT speciality that matches the user's preferences.

## Getting Started

1. Make sure you have [Flutter](https://flutter.dev/docs/get-started/install) installed.
2. Clone this repository.
3. Run `flutter pub get` to fetch dependencies.
4. Place your images in the `images/` directory as referenced in the code.
5. Run the app with `flutter run`.

## Notes

- All main logic is in the `lib` folder.
- The `Question` object uses a binary code to track the user's path through the quiz.
- You can customize questions and images by editing `functions.dart` and adding images to the `images/` folder.

---
*This is my first Flutter project. Feedback and suggestions are welcome!*
