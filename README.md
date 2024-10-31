# Movie Reservation App

This project was created using the Dart programming language and the Flutter framework,
with the goal of showcasing my advanced skills and professionalism in handling complex 
features within Flutter applications.

## Project Overview

Throughout the development of this application, I have implemented several advanced
concepts that are evident from start to finish:

1. **Asynchronous Programming**:
    - Utilized an async main function to initialize Firebase and other necessary
    - components during the application startup.

2. **Singleton Pattern**:
    - Implemented a singleton pattern from the MyApp class to ensure efficient
    - application performance throughout its lifecycle.

3. **State Management**:
    - Employed the Bloc pattern for state management, which includes sending events and handling
    - various states across the application. I have incorporated a significant number of events and 
    - states to effectively manage the app's state.

4. **Bloc Consumer and Bloc Builder**:
    - Utilized BlocConsumer, BlocBuilder, and BlocProvider, along with streams for certain functionalities. 
    - While I could have opted for simpler state management techniques like Provider or GetX,
    - I chose to focus on showcasing my proficiency with more complex patterns.

5. **Clean Code Principles**:
    - Emphasized the concept of clean code by organizing all strings, numbers, colors, styles,
    - and constants independently within the presentation layer of the components folder.

6. **Error Handling**:
    - Focused on comprehensive error handling to manage potential user errors
    - during Firebase registration, login, and even when using Google or Apple sign-in.

## Architectural Patterns

- **MVVM (Model-View-ViewModel)**: Followed this architecture to maintain a clear separation of concerns.
- **Dependency Injection (DI)**: Applied DI principles to manage dependencies effectively.
- **Repository Pattern**: Used to abstract data sources.
- **Service Layer**: Implemented to handle business logic.
- **Event-Driven Architecture**: Designed to enhance responsiveness.
- **Layered Architecture**: Maintained clear layers within the application for better manageability.

## Extensive Use of APIs

- Interfaced with various APIs, including fetching actor information from Wikipedia API.
- I also created a personal API, which can be found on my 
- GitHub: [events_api](https://github.com/hmoodaps/events_api).

## Data Models

- Created different data models using three methods: the traditional approach, the Freezed package,
- and JSON serialization via Retrofit.

## Local Storage

- Implemented local storage using Shared Preferences to persist certain data.

## Push Notifications

- Configured Firebase Cloud Messaging for push notifications and implemented in-app notifications.

## Multiple HTTP Client Libraries

- Used both Dio and http libraries, demonstrating my ability to work with various HTTP client 
- options, although I could have chosen just one for the project.

## Geolocation

- Utilized Firebase to store additional user data, such as geographic location, as I plan to
- implement maps to show the nearest cinemas.

## Custom Package: Staggered Animated Widget

- To enhance the user experience within the application,
- I developed and published a custom Flutter package called
- [Staggered Animated Widget](https://pub.dev/packages/staggered_animated_widget) 
- on pub.dev. This package provides staggered animations for widgets, allowing for more dynamic
- and visually appealing transitions.

### Features
- **Multiple Animation Directions**: Supports animations from top, bottom, left, or right.
- **Customizable Delay**: Easily add delays before animations start.
- **Custom Duration and Curve**: Adjust the duration and curve of animations to suit your design needs.

### Installation

To use this package in your Flutter project, add the following line to your `pubspec.yaml` file:

```bash
flutter pub add staggered_animated_widget
```
or
```yaml
dependencies:
  staggered_animated_widget: ^1.0.0

```


## Challenges Faced

1. **Handling Complex State Management with Bloc**:
   - One of the key challenges was managing the state transitions with a large number of events and states.
   - To solve this, I thoroughly planned and organized the state flows, using BlocConsumer and separating business logic from UI logic efficiently.

2. **Optimizing Application Performance**:
   - Ensuring smooth performance across different devices was crucial.
   - I optimized the widget rebuilds by using proper caching and memoization techniques and reducing unnecessary re-renders with BlocBuilder.

3. **Error Handling and Resilience**:
   - Managing various error cases, especially with Firebase authentication, was challenging.
   - Implementing a robust error-handling mechanism ensured that users receive meaningful error messages without disrupting the flow of the app.

4. **Asynchronous Operations**:
   - Coordinating multiple asynchronous API calls, especially when integrating third-party APIs, was complex.
   - I leveraged Dart's `Future.wait` and streams effectively to ensure all data is fetched without blocking the UI.

5. **Firebase Integration Testing**:
   - Firebase testing presented challenges, especially for authentication flows.
   - To manage this, I configured a separate Firebase test project and used Firebase emulators during local testing.

## Testing

- **Manual Testing**:
   - Focused on manual and realistic testing rather than relying solely on built-in Flutter testing tools.
   - Conducted tests with real users to gain genuine feedback and insights on the application's performance and usability.

- **Continuous Integration**:
   - Integrated the tests with a CI/CD pipeline (using GitHub Actions) to automatically run the
   - tests on every commit, ensuring the application remains stable as new features are added.

## Future Improvements

1. **UI/UX Enhancements**:
   - Continuously improving the design with more animations and a better user experience.

2. **Offline Support**:
   - Implementing offline capabilities to allow users to browse movie listings without internet access.

3. **Enhanced Test Coverage**:
   - Increasing test coverage, especially for edge cases and integration scenarios with external APIs.


## Conclusion

Overall, this application exemplifies the highest architectural standards of Flutter development, 
clearly visible across four layers: MVVM, DI, Clean Code, and Clean Architecture, where no variable
definitions appear directly within the view classes. The thoroughness of my approach is evident in 
the comments throughout the code files.

## Technologies Used

- Dart
- Flutter
- Bloc (Business Logic Component)
- Firebase Integration
- Clean Architecture
- MVVM (Model-View-ViewModel)
- Dependency Injection (DI)
- Repository Pattern
- Service Layer
- Singleton Pattern
- Reactive Programming

Thank you for reviewing my work!
بالاضافة انو استخدمنا ال dartz  عشان نستخدم الايثر ...  واستخدمنا الريبوزيتوري  >>  سوينا عملية تسجيل الدخول عن طريق الستريم والستريم بيلدر واستغنينا عن البلوك عشان اظهر قدرتي بالتعامل مع الستريم مع اني قادر اني استخدم البلوك .. 
مع اني سويت تسجيل الدخول باستخدام البلوك وعلقتو وبعدين سويتو بالستريم ممكن نعلق واحد ونشتغل بالثاني براحتنا سويت الطريقتين .. 
## الاشياء الموجودة بالكود ... 
Clean Architecture Design Pattern
MVVM - Model - View - View Model Pattern
bloc pattern
ViewModel Inputs and Outputs
Base ViewModel and Base UseCase
//layers , , ,
Application Layer - Dependency Injection, components , constants(contain >> assets manager buttons manager , color manager , dio and mapper constants , error strings , font manager , general strings , icons manager , notification handler , route strings manager , route manager , size manager , stack background manager , text form filed manager , theme manager and variables manager  ) , firebase error handler , extensions and  myapp(singleton class )
Data Layer - handel dark and light mode , repository implementer , shared preferences , mapper (null protector (for the data that coming from the api )) , movie model (appling the mapper and the modern ways for bring data from api with very advanced method with with JsonSerializable  , and dio interceptor  to protect dio logs for users privacy ) and  network data handler(using dio and http with normal way , and dio with the retrofit  ) 
Domain Layer - local Models  , models object (movies , guests , reservations , users and actors models ) , repository
Presentation Layer - base view model , UI (cart , edit reservation , favorits , forget password , login  , main page , movie , movies , onboarding ,  past films , profile ,  question (to ask user if want to continue as a gust fires or wants to mack an account ) , register  ,  reservation  , splash screen  , user details ) , bloc state managment (events , bloc , states )

Using 50 Flutter Packages
Getting Device Info (Android - Ios)
Using Abstract classes
Separation of Concerns
