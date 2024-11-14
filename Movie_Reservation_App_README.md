# Movie Reservation App

This project was created using the Dart programming language and the Flutter framework,
with the goal of showcasing my advanced skills and professionalism in handling complex features
within Flutter applications.

## Project Overview

Throughout the development of this application, I have implemented several advanced concepts that
are evident from start to finish:

1. **Asynchronous Programming**:
    - Utilized an async main function to initialize Firebase and other necessary components during
      the application startup.

2. **Singleton Pattern**:
    - Implemented a singleton pattern from the MyApp class to ensure efficient application
      performance throughout its lifecycle.

3. **State Management**:
    - Employed the **Bloc** pattern for state management, which includes sending events and handling
      various states across the application. I have incorporated a significant number of events and
      states to effectively manage the app's state.
    - For login and registration, I experimented with both **Stream** and **Bloc** for
      authentication to showcase my ability to work with both approaches.

4. **Clean Code Principles**:
    - Emphasized the concept of clean code by organizing all strings, numbers, colors, styles, and
      constants independently within the presentation layer of the components folder.

5. **Error Handling**:
    - Focused on comprehensive error handling to manage potential user errors during Firebase
      registration, login, and even when using Google or Apple sign-in.

6. **Firebase Integration**:
    - Integrated Firebase for user authentication, database management, and storage operations. I
      used Firebase's built-in services to manage user sessions and ensure seamless transitions
      between user states (guest or registered).

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


## Detailed Flow of the App

### Application Startup

1. **Main Function**:
    - The application begins execution from the `main` function, where necessary components such as
      Firebase are initialized asynchronously. This function is used to configure the app, set up
      dependency injection, and call essential setup routines for proper app operation.

2. **Context Handling**:
    - Once the app initializes, the context is stored in a variable for later use. This context is
      necessary for manipulating widget properties like size, font, and appearance throughout the
      app.

3. **First Screen**:
    - The first screen of the app shows a progress indicator (0% to 100%), while an API call is made
      to fetch movie data from the Firebase database.

### Movie Data Fetching

1. **Repository Pattern**:
    - The **Repository** is used to abstract the data-fetching logic. The repository fetches the
      movie data by invoking a method that sends a request to the backend server using **Dio** or *
      *Retrofit**.

2. **Network Call**:
    - The network layer (built using **Dio** and **Retrofit**) sends the request to the server to
      fetch movie data. Once the data is received, it is processed and serialized into Dart objects
      using **JSONSerializable** and **Freezed** classes. The `todomain` function ensures that no
      `null` values exist in the movie data, providing a reliable structure for UI presentation.

3. **Firebase**:
    - Firebase is used to check the internet connection status and ensure that the app remains
      connected throughout its operation. Firebase Firestore is also used to store user-related data
      such as reservations and favorites.

### Onboarding and User Login Flow

1. **Onboarding Screens**:
    - When the user first opens the app, they are presented with onboarding screens. These screens
      introduce the app and allow users to choose whether they want to continue as a guest or sign
      in to their account.

2. **Guest Mode**:
    - If the user chooses to continue as a guest, they are allowed to browse movies, add them to
      their favorites, and read more about them. However, they cannot make reservations or payments.

3. **User Authentication**:
    - If the user wants to register or log in, they can do so via Firebase Authentication, using
      options like Google or Apple sign-in.
    - The app supports both **Bloc** and **StreamBuilder** for managing the authentication process,
      showcasing my ability to use both techniques depending on the use case.

### Main App Features

1. **Home Screen**:
    - Once the movie data is fetched, the main screen is displayed, showing movies in different
      categories like **New Releases**, **Top Films**, and **More**.
    - The movies are presented with a beautiful and user-friendly UI.

2. **Movie Details**:
    - Clicking on a movie directs the user to the movie details screen. Here, they can view a
      summary of the movie, mark it as a favorite, or proceed with booking a ticket.
    - If the user selects "Read More", a new screen opens with additional information about the
      movie, including details of the cast fetched from the **Wikipedia API**.

3. **Bottom Navigation**:
    - The app includes a bottom navigation bar that allows users to navigate between sections like *
      *Profile**, **Favorites**, **Reservations**, and **Settings**.

### Profile and Settings

1. **Profile Management**:
    - The app allows users to create an account or log in if they haven’t already done so. Users can
      modify their settings and update personal details via Firebase.

2. **Settings**:
    - Users can adjust the **theme** (dark/light mode) and choose between **manual** or **automatic
      ** theme adjustment based on the system settings.
    - They can also change the language of the app and provide feedback, including suggestions for
      new movies.

### Reservation and Payment

1. **Making Reservations**:
    - Users can select a movie and proceed to reserve tickets. The reservation process stores movie
      data and guest information in Firebase.
    - The user is prompted to complete the booking process (if logged in) or register/log in before
      confirming the reservation.

2. **Payment Gateway**:
    - A payment gateway is being implemented for ticket purchases, ensuring users can complete their
      bookings via various payment methods.

### Firebase and Local Storage

1. **Data Storage**:
    - **Shared Preferences** is used to persist user settings, such as dark/light mode preferences
      and language settings.
    - Firebase Firestore is used to manage user data, including reservations, favorites, and other
      app-specific details.

2. **Push Notifications**:
    - **Firebase Cloud Messaging** is used to send notifications about new movies, events, and
      reservation reminders.

### Error Handling

1. **Handling Errors Gracefully**:
    - The app handles potential errors in the authentication process and while making network
      requests (such as fetching movie data) by displaying user-friendly error messages.
    - **Dio Interceptors** are used to monitor and log errors in network requests while maintaining
      user privacy.

## Features

- **Multiple Animation Directions**: Supports animations from top, bottom, left, or right.
- **Customizable Delay**: Easily add delays before animations start.
- **Custom Duration and Curve**: Adjust the duration and curve of animations to suit your design
  needs.

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
- Dartz for functional programming

---

### Challenges Faced

1. **Handling Complex State Management with Bloc**:
    - Managing multiple states and events, particularly for handling authentication, was
      challenging. I carefully structured the Bloc architecture to ensure smooth transitions and
      user flow.

2. **Asynchronous Operations**:
    - Handling asynchronous network calls while ensuring smooth UI performance was a key challenge.
      Using `Future.wait` and streams ensured that all data loads efficiently without blocking the
      UI.

3. **Optimizing Firebase Integration**:
    - Ensuring correct Firebase setup and managing authentication flows without conflicts took
      significant effort. Testing in a local environment with Firebase emulators helped mitigate
      issues during development.

## Future Improvements

1. **UI/UX Enhancements**:
    - Continuously improving the design with more animations and a better user experience.

2. **Offline Support**:
    - Implementing offline capabilities to allow users to browse movie listings without internet
      access.

3. **Enhanced Test Coverage**:
    - Increasing test coverage, especially for edge cases and integration scenarios with external
      APIs.

---

### Conclusion

This application exemplifies the highest architectural standards of Flutter development, with a
focus on **MVVM**, **DI**, **Clean Code**, and **Clean Architecture** principles. The code is
designed to be modular and extensible, with clear separation of concerns across multiple layers.
This thoroughness ensures that the app is scalable and maintainable for future enhancements.
>>> 
> اشياء استخدمتها جديد 
> RepaintBoundary تقليل رسم الاجزاء غير الضرورية
> AspectRatio تحجيم الصور بنسبة مناسبه 
> cached_network_image لتقليل تحميل الصور من الشبكه 
> isolate تقليل الحمل عن الخيط الرئيسي في التطبيق 
> compute 
بالنسبة لاستخدام ايزوليت مع كمبيوت معاا يعمل على زيادة التعقديد ولكنني استخدمته لابراز قدراتي في التعامل مع التعقيد بالرغم من عدم ضرورة ذلك 
> لوكالايزيشن عربي انجليزي هولندي 
> اقرأ الوصف المرف في كيفية جلب الافلام من الداتا بيز لانني تعبت ونا بكتب فيه 
> 
> 