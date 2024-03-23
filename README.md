# TVMaze_App_Example

TVMaze_App_Example is an iOS application that allows users to explore and mark their favorite TV shows.

## Features

- View a list of TV shows with the option to mark as favorites.
- Favorites screen to see shows marked as favorites.
- Details of each show with the ability to mark or unmark as favorites.
- Use of the TV Maze API to retrieve show information.

## Compatibility

- Developed in Swift 5.
- Compatible with iOS 10 and later.
- Implementation of the VIPER architecture.
- Entirely in Swift without the use of any external libraries.

## VIPER Design Pattern

TVMaze_App_Example follows the VIPER design pattern to separate the concerns of the application into distinct layers:

- **View:** Presents the user interface and handles user interactions.
- **Interactor:** Contains the business logic and interacts with the data layer.
- **Presenter:** Formats the data to be displayed in the view and handles user inputs.
- **Entity:** Represents the data objects used by the application.
- **Router:** Manages navigation between modules.

## Video Tutorials

- [Understanding VIPER Design Pattern](https://youtu.be/RWuyIUokhx0)
- [TVMaze_App_Example Demo](https://youtu.be/daTTzsscA2A)

## Usage Instructions

1. Clone or download the TVMaze_App_Example repository.
2. Open the TVMaze_App_Example.xcodeproj file in Xcode.
3. Run the application on the iOS simulator or a physical device.

## Usage

- On the main screen, you can explore the available TV shows.
- Tap a show to view its details and mark or unmark as favorite as desired.
- Go to the "Favorites" tab to see the shows you've marked as favorites.
- Enjoy exploring and marking your favorite shows in TV Shows Explorer!
- Learn about the VIPER design pattern in iOS!

## Comments

- The application uses CoreData for local storage of favorite shows.
- TVMaze_App_Example is a fully functional application that can be further optimized for performance and scalability. Due to time constraints, certain optimizations may not have been implemented in this version.
- The decision to use the VIPER architecture was deliberate as it provides a clean separation of concerns and enhances maintainability, especially as the project scales. In UIKit-based applications like this, VIPER architecture offers a structured approach that aids in managing complexity and promoting code reusability.


## License

TVMaze_App_Example is released under the [MIT License](LICENSE).

## Authors

- [José Antonio Caballero Martínez](https://gitlab.com/JoseAntonioCaballero)
