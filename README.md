# Real Estate App - Flutter Assessment Project

## Project Overview

This project is a Flutter-based mobile application for a real estate platform, developed as part of a technical assessment. The app showcases modern UI design implementation, state management using Provider, and adherence to clean architecture principles.

![App Screenshot](https://cdn.dribbble.com/userupload/13450596/file/original-7a43c751ab3b3c9e93ccb1558c3813ce.png?resize=2048x1536&vertical=center)

[View Original Design](https://dribbble.com/shots/23780608-Real-Estate-App)

## Table of Contents

1. [Features](#features)
2. [Technology Stack](#technology-stack)
3. [Architecture](#architecture)
4. [Project Structure](#project-structure)
5. [Setup and Installation](#setup-and-installation)
6. [Usage](#usage)
7. [Testing](#testing)
8. [Performance Considerations](#performance-considerations)
9. [Future Improvements](#future-improvements)
10. [Contributing](#contributing)
11. [License](#license)

## Features

- Modern and intuitive user interface
- Property listing with detailed information
- Property search functionality
- User authentication and profile management
- Responsive design for various screen sizes

## Technology Stack

- Flutter SDK
- Dart programming language
- Provider for state management
- Clean Architecture for project structure
- Various Flutter packages (see `pubspec.yaml` for details)

## Architecture

This project follows the principles of Clean Architecture, which promotes separation of concerns and maintainability. The architecture is divided into three main layers:

1. **Presentation Layer**: Contains UI components, widgets, and view models.
2. **Domain Layer**: Holds business logic, use cases, and entity models.
3. **Data Layer**: Manages data sources, repositories, and external services.

## Project Structure

```
lib
├── model
│   ├── marker_model.dart
│   ├── models.dart
│   ├── offer_model.dart
│   └── property_model.dart
│
├── providers
│   ├── bottom_navigation_provider.dart
│   ├── home_provider.dart
│   ├── map_provider.dart
│   ├── menu_selection_provider.dart
│   └── provider.dart
│
├── repository
│   ├── map_repository.dart
│   ├── offer_repository.dart
│   ├── property_repository.dart
│   └── repositories.dart
│
├── screen
│   ├── chat_screen.dart
│   ├── favorites_screen.dart
│   ├── home_screen.dart
│   ├── map_screen.dart
│   ├── profile_screen.dart
│   └── screens.dart
│
├── util
│   ├── app_ints_util.dart
│   ├── app_locations_util.dart
│   ├── app_network_image_url_util.dart
│   ├── app_strings_util.dart
│   ├── color_util.dart
│   ├── marker_util.dart
│   └── utils.dart
│
├── widgets
│   ├── avatar_widget.dart
│   ├── bottom_navigation_bar_animated_widget.dart
│   ├── bottom_navigation_bar_widget.dart
│   ├── current_location_widget.dart
│   ├── glass_morphism_widget.dart
│   ├── gradient_background_widget.dart
│   ├── greeting_widget.dart
│   ├── map_bottom_left_buttons_widget.dart
│   ├── map_bottom_right_buttons_widget.dart
│   ├── map_widget.dart
│   ├── offer_widget.dart
│   ├── popup_menu_widget.dart
│   ├── property_tile_widget.dart
│   ├── search_bar_widget.dart
│   └── widgets.dart
│
├── main.dart
└── real_estate_app.dart
```

## Setup and Installation

1. Ensure you have Flutter installed on your machine. If not, follow the [official Flutter installation guide](https://flutter.dev/docs/get-started/install).

2. Clone the repository:
   ```
   git clone https://github.com/moeenchanna/assessment_app.git
   ```

3. Navigate to the project directory:
   ```
   cd assessment_app
   ```

4. Install dependencies:
   ```
   flutter pub get
   ```

5. Run the app:
   ```
   flutter run
   ```

## Usage

[Provide brief instructions on how to use the app, including any login credentials or sample data if applicable]

## Testing

To run the tests, execute the following command in the project root:

```
flutter test
```

## Performance Considerations

- Implemented efficient list rendering for smooth scrolling
- Optimized image loading and caching for faster load times
- Minimized unnecessary rebuilds using `const` constructors and `Provider.value`

## Future Improvements

- Implement more advanced search and filtering options
- Add property booking functionality
- Integrate with a backend API for real-time data
- Implement localization for multiple languages

## Contributing

While this project was developed as part of an assessment, contributions, issues, and feature requests are welcome. Feel free to check [issues page](https://github.com/moeenchanna/assessment_app/issues) if you want to contribute.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

---

Developed by [Moeen Channa](https://github.com/moeenchanna)