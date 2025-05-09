# note : Beta version still working on this i will update it once i learn more stuff 2025/5/1


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

## APK

An APK build is available in the repository as **app-release.apk**.

## Notes

- All main logic is in the `lib` folder.
- The `Question` object uses a binary code to track the user's path through the quiz.
- You can customize questions and images by editing `functions.dart` and adding images to the `images/` folder.

## Running the Web Build Locally

After running `flutter build web`, you can serve the `build/web` folder using any static file server.  
If you don't have Python, here are some alternatives:

- **If you have Node.js installed:**
  ```
  npx serve build/web
  ```
  Or install globally:
  ```
  npm install -g serve
  serve build/web
  ```

- **If you use VS Code:**
  1. Install the "Live Server" extension.
  2. Open the `build/web` folder in VS Code.
  3. Right-click `index.html` and select "Open with Live Server".

- **Or upload the contents of `build/web` to any static hosting service**  
  (like GitHub Pages, Netlify, Firebase Hosting, Vercel, etc.).

### Web Release Version

The release version of the app for web is available in the `webVersion` file.

- You can deploy or serve the contents of the `webVersion` file/folder as your web app.
- This is the optimized build output for production.

---
*This is my first Flutter project. Feedback and suggestions are welcome!*
