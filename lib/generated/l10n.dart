// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name =
        (locale.countryCode?.isEmpty ?? false)
            ? locale.languageCode
            : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Error `
  String get error {
    return Intl.message('Error ', name: 'error', desc: '', args: []);
  }

  /// `Success `
  String get success {
    return Intl.message('Success ', name: 'success', desc: '', args: []);
  }

  /// `Account created successfully! `
  String get accountCreated {
    return Intl.message(
      'Account created successfully! ',
      name: 'accountCreated',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Back! `
  String get welcomeBack {
    return Intl.message(
      'Welcome Back! ',
      name: 'welcomeBack',
      desc: '',
      args: [],
    );
  }

  /// `Forget Password? `
  String get forgetPassword {
    return Intl.message(
      'Forget Password? ',
      name: 'forgetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Continue `
  String get continueString {
    return Intl.message(
      'Continue ',
      name: 'continueString',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Cinema Ticket `
  String get welcome {
    return Intl.message(
      'Welcome to Cinema Ticket ',
      name: 'welcome',
      desc: '',
      args: [],
    );
  }

  /// `Start investing commission-free `
  String get startInvesting {
    return Intl.message(
      'Start investing commission-free ',
      name: 'startInvesting',
      desc: '',
      args: [],
    );
  }

  /// `Other fees may apply `
  String get otherFees {
    return Intl.message(
      'Other fees may apply ',
      name: 'otherFees',
      desc: '',
      args: [],
    );
  }

  /// `View our `
  String get viewOur {
    return Intl.message('View our ', name: 'viewOur', desc: '', args: []);
  }

  /// `fee schedule `
  String get fee {
    return Intl.message('fee schedule ', name: 'fee', desc: '', args: []);
  }

  /// `to learn more `
  String get learnMore {
    return Intl.message(
      'to learn more ',
      name: 'learnMore',
      desc: '',
      args: [],
    );
  }

  /// `All investing have risks `
  String get allInvesting {
    return Intl.message(
      'All investing have risks ',
      name: 'allInvesting',
      desc: '',
      args: [],
    );
  }

  /// `Let’s get started `
  String get letsStart {
    return Intl.message(
      'Let’s get started ',
      name: 'letsStart',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account? `
  String get haveAccount {
    return Intl.message(
      'Already have an account? ',
      name: 'haveAccount',
      desc: '',
      args: [],
    );
  }

  /// `Login `
  String get login {
    return Intl.message('Login ', name: 'login', desc: '', args: []);
  }

  /// `Create an account `
  String get createAccount {
    return Intl.message(
      'Create an account ',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Register `
  String get register {
    return Intl.message('Register ', name: 'register', desc: '', args: []);
  }

  /// `Do you want to continue? `
  String get question {
    return Intl.message(
      'Do you want to continue? ',
      name: 'question',
      desc: '',
      args: [],
    );
  }

  /// `as a guest `
  String get guest {
    return Intl.message('as a guest ', name: 'guest', desc: '', args: []);
  }

  /// `or `
  String get or {
    return Intl.message('or ', name: 'or', desc: '', args: []);
  }

  /// `Privacy Policy `
  String get privacy {
    return Intl.message('Privacy Policy ', name: 'privacy', desc: '', args: []);
  }

  /// `Email Address `
  String get email {
    return Intl.message('Email Address ', name: 'email', desc: '', args: []);
  }

  /// `Password `
  String get password {
    return Intl.message('Password ', name: 'password', desc: '', args: []);
  }

  /// `Full Name `
  String get fullName {
    return Intl.message('Full Name ', name: 'fullName', desc: '', args: []);
  }

  /// `Last Name `
  String get lastName {
    return Intl.message('Last Name ', name: 'lastName', desc: '', args: []);
  }

  /// `Postal Code `
  String get postalCode {
    return Intl.message('Postal Code ', name: 'postalCode', desc: '', args: []);
  }

  /// `Street `
  String get street {
    return Intl.message('Street ', name: 'street', desc: '', args: []);
  }

  /// `House Number `
  String get houseNumber {
    return Intl.message(
      'House Number ',
      name: 'houseNumber',
      desc: '',
      args: [],
    );
  }

  /// `Date Of Birth `
  String get dateOfBirth {
    return Intl.message(
      'Date Of Birth ',
      name: 'dateOfBirth',
      desc: '',
      args: [],
    );
  }

  /// `This field is required `
  String get fieldRequired {
    return Intl.message(
      'This field is required ',
      name: 'fieldRequired',
      desc: '',
      args: [],
    );
  }

  /// `Let’s create an account quickly for you `
  String get letsCreateAccount {
    return Intl.message(
      'Let’s create an account quickly for you ',
      name: 'letsCreateAccount',
      desc: '',
      args: [],
    );
  }

  /// `Ahmed Khalid `
  String get ahmadKhalid {
    return Intl.message(
      'Ahmed Khalid ',
      name: 'ahmadKhalid',
      desc: '',
      args: [],
    );
  }

  /// `Sign in With Google `
  String get signWithGoogle {
    return Intl.message(
      'Sign in With Google ',
      name: 'signWithGoogle',
      desc: '',
      args: [],
    );
  }

  /// `Sign in With Apple `
  String get signWithApple {
    return Intl.message(
      'Sign in With Apple ',
      name: 'signWithApple',
      desc: '',
      args: [],
    );
  }

  /// `search `
  String get search {
    return Intl.message('search ', name: 'search', desc: '', args: []);
  }

  /// `Top Movies `
  String get topMovies {
    return Intl.message('Top Movies ', name: 'topMovies', desc: '', args: []);
  }

  /// `New Movies `
  String get newMovies {
    return Intl.message('New Movies ', name: 'newMovies', desc: '', args: []);
  }

  /// `All Movies `
  String get allMovies {
    return Intl.message('All Movies ', name: 'allMovies', desc: '', args: []);
  }

  /// `Internet Disconnected `
  String get lostConnection {
    return Intl.message(
      'Internet Disconnected ',
      name: 'lostConnection',
      desc: '',
      args: [],
    );
  }

  /// `Please check your internet connection.\nThis message will automatically disappear when the connection is restored. `
  String get lostConnectionContent {
    return Intl.message(
      'Please check your internet connection.\nThis message will automatically disappear when the connection is restored. ',
      name: 'lostConnectionContent',
      desc: '',
      args: [],
    );
  }

  /// `The OTP in the email link has expired. `
  String get expiredActionCode {
    return Intl.message(
      'The OTP in the email link has expired. ',
      name: 'expiredActionCode',
      desc: '',
      args: [],
    );
  }

  /// `The email address is not valid. `
  String get invalidEmail {
    return Intl.message(
      'The email address is not valid. ',
      name: 'invalidEmail',
      desc: '',
      args: [],
    );
  }

  /// `The user has been disabled. `
  String get userDisabled {
    return Intl.message(
      'The user has been disabled. ',
      name: 'userDisabled',
      desc: '',
      args: [],
    );
  }

  /// `Operation not allowed. \nPlease enable this option in Firebase Console. `
  String get operationNotAllowed {
    return Intl.message(
      'Operation not allowed. \nPlease enable this option in Firebase Console. ',
      name: 'operationNotAllowed',
      desc: '',
      args: [],
    );
  }

  /// `The credential does not correspond to the user. `
  String get userMismatch {
    return Intl.message(
      'The credential does not correspond to the user. ',
      name: 'userMismatch',
      desc: '',
      args: [],
    );
  }

  /// `No user found with the provided credential. `
  String get userNotFound {
    return Intl.message(
      'No user found with the provided credential. ',
      name: 'userNotFound',
      desc: '',
      args: [],
    );
  }

  /// `The credential is not valid or has expired. `
  String get invalidCredential {
    return Intl.message(
      'The credential is not valid or has expired. ',
      name: 'invalidCredential',
      desc: '',
      args: [],
    );
  }

  /// `The password is incorrect or the account has no password set. `
  String get wrongPassword {
    return Intl.message(
      'The password is incorrect or the account has no password set. ',
      name: 'wrongPassword',
      desc: '',
      args: [],
    );
  }

  /// `The verification code is invalid. `
  String get invalidVerificationCode {
    return Intl.message(
      'The verification code is invalid. ',
      name: 'invalidVerificationCode',
      desc: '',
      args: [],
    );
  }

  /// `The verification ID is invalid. `
  String get invalidVerificationId {
    return Intl.message(
      'The verification ID is invalid. ',
      name: 'invalidVerificationId',
      desc: '',
      args: [],
    );
  }

  /// `An account already exists with this email address\n but with different credentials. `
  String get accountExistsWithDifferentCredential {
    return Intl.message(
      'An account already exists with this email address\n but with different credentials. ',
      name: 'accountExistsWithDifferentCredential',
      desc: '',
      args: [],
    );
  }

  /// `The email is already in use by another account. `
  String get emailAlreadyInUse {
    return Intl.message(
      'The email is already in use by another account. ',
      name: 'emailAlreadyInUse',
      desc: '',
      args: [],
    );
  }

  /// `The password is too weak. `
  String get weakPassword {
    return Intl.message(
      'The password is too weak. ',
      name: 'weakPassword',
      desc: '',
      args: [],
    );
  }

  /// `An unknown error occurred. `
  String get unknownError {
    return Intl.message(
      'An unknown error occurred. ',
      name: 'unknownError',
      desc: '',
      args: [],
    );
  }

  /// `tickets left! `
  String get ticketsLeft {
    return Intl.message(
      'tickets left! ',
      name: 'ticketsLeft',
      desc: '',
      args: [],
    );
  }

  /// `Last Ticket available! `
  String get lastTicketAvailable {
    return Intl.message(
      'Last Ticket available! ',
      name: 'lastTicketAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Be the first one! `
  String get beTheFirstOne {
    return Intl.message(
      'Be the first one! ',
      name: 'beTheFirstOne',
      desc: '',
      args: [],
    );
  }

  /// `Height IMDB rate: `
  String get heightIMDBRate {
    return Intl.message(
      'Height IMDB rate: ',
      name: 'heightIMDBRate',
      desc: '',
      args: [],
    );
  }

  /// `seats available `
  String get seatsAvailable {
    return Intl.message(
      'seats available ',
      name: 'seatsAvailable',
      desc: '',
      args: [],
    );
  }

  /// `seats `
  String get seats {
    return Intl.message('seats ', name: 'seats', desc: '', args: []);
  }

  /// `Low Price: `
  String get lowPrice {
    return Intl.message('Low Price: ', name: 'lowPrice', desc: '', args: []);
  }

  /// `Hurry! Only `
  String get hurry {
    return Intl.message('Hurry! Only ', name: 'hurry', desc: '', args: []);
  }

  /// `Just more few data! `
  String get fewData {
    return Intl.message(
      'Just more few data! ',
      name: 'fewData',
      desc: '',
      args: [],
    );
  }

  /// `We'll take a bit of information to enhance the \npersonalized experience, just a few seconds. `
  String get someInfo {
    return Intl.message(
      'We\'ll take a bit of information to enhance the \npersonalized experience, just a few seconds. ',
      name: 'someInfo',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number `
  String get mobileNumber {
    return Intl.message(
      'Phone Number ',
      name: 'mobileNumber',
      desc: '',
      args: [],
    );
  }

  /// `Additional Information `
  String get additionalInfo {
    return Intl.message(
      'Additional Information ',
      name: 'additionalInfo',
      desc: '',
      args: [],
    );
  }

  /// `city `
  String get city {
    return Intl.message('city ', name: 'city', desc: '', args: []);
  }

  /// `by press `
  String get byPress {
    return Intl.message('by press ', name: 'byPress', desc: '', args: []);
  }

  /// `You Accept our `
  String get youAccept {
    return Intl.message(
      'You Accept our ',
      name: 'youAccept',
      desc: '',
      args: [],
    );
  }

  /// `Terms and Conditions `
  String get termsAndConditions {
    return Intl.message(
      'Terms and Conditions ',
      name: 'termsAndConditions',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password `
  String get resetPassword {
    return Intl.message(
      'Reset Password ',
      name: 'resetPassword',
      desc: '',
      args: [],
    );
  }

  /// `password reset link was sent to your email\n .Check your inbox `
  String get passwordResetSuccess {
    return Intl.message(
      'password reset link was sent to your email\n .Check your inbox ',
      name: 'passwordResetSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Let's try resetting your password. We will send a link to \nset your password to your email address. `
  String get ltsResetPassword {
    return Intl.message(
      'Let\'s try resetting your password. We will send a link to \nset your password to your email address. ',
      name: 'ltsResetPassword',
      desc: '',
      args: [],
    );
  }

  /// `Orders `
  String get orders {
    return Intl.message('Orders ', name: 'orders', desc: '', args: []);
  }

  /// `Coupons `
  String get coupons {
    return Intl.message('Coupons ', name: 'coupons', desc: '', args: []);
  }

  /// `My Account Balance `
  String get myAppBalance {
    return Intl.message(
      'My Account Balance ',
      name: 'myAppBalance',
      desc: '',
      args: [],
    );
  }

  /// `Address `
  String get address {
    return Intl.message('Address ', name: 'address', desc: '', args: []);
  }

  /// `Payment Methods `
  String get paymentMethods {
    return Intl.message(
      'Payment Methods ',
      name: 'paymentMethods',
      desc: '',
      args: [],
    );
  }

  /// `Language `
  String get language {
    return Intl.message('Language ', name: 'language', desc: '', args: []);
  }

  /// `Theme Mode `
  String get themeMode {
    return Intl.message('Theme Mode ', name: 'themeMode', desc: '', args: []);
  }

  /// `Color Themes `
  String get colorThemeApp {
    return Intl.message(
      'Color Themes ',
      name: 'colorThemeApp',
      desc: '',
      args: [],
    );
  }

  /// `Feedback & Complaints `
  String get feedback {
    return Intl.message(
      'Feedback & Complaints ',
      name: 'feedback',
      desc: '',
      args: [],
    );
  }

  /// `About Us `
  String get aboutUs {
    return Intl.message('About Us ', name: 'aboutUs', desc: '', args: []);
  }

  /// `Privacy Policy `
  String get privacyPolicy {
    return Intl.message(
      'Privacy Policy ',
      name: 'privacyPolicy',
      desc: '',
      args: [],
    );
  }

  /// `Logout `
  String get logout {
    return Intl.message('Logout ', name: 'logout', desc: '', args: []);
  }

  /// `login Or Register `
  String get loginOrRegister {
    return Intl.message(
      'login Or Register ',
      name: 'loginOrRegister',
      desc: '',
      args: [],
    );
  }

  /// `skip `
  String get skip {
    return Intl.message('skip ', name: 'skip', desc: '', args: []);
  }

  /// `No favorites here yet!`
  String get noFaveItems {
    return Intl.message(
      'No favorites here yet!',
      name: 'noFaveItems',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get favorites {
    return Intl.message('Favorites', name: 'favorites', desc: '', args: []);
  }

  /// `You're not logged in yet. Please log in to continue to your cart!`
  String get notLoggedIn {
    return Intl.message(
      'You\'re not logged in yet. Please log in to continue to your cart!',
      name: 'notLoggedIn',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message('Cancel', name: 'cancel', desc: '', args: []);
  }

  /// `You’re not logged in!`
  String get urNotLogin {
    return Intl.message(
      'You’re not logged in!',
      name: 'urNotLogin',
      desc: '',
      args: [],
    );
  }

  /// `You need to log in before adding items to your cart!`
  String get uCantAddItemToCart {
    return Intl.message(
      'You need to log in before adding items to your cart!',
      name: 'uCantAddItemToCart',
      desc: '',
      args: [],
    );
  }

  /// `Your cart is empty for now!`
  String get noCartItems {
    return Intl.message(
      'Your cart is empty for now!',
      name: 'noCartItems',
      desc: '',
      args: [],
    );
  }

  /// `Cart`
  String get cart {
    return Intl.message('Cart', name: 'cart', desc: '', args: []);
  }

  /// `Choose your seat`
  String get chooseSeat {
    return Intl.message(
      'Choose your seat',
      name: 'chooseSeat',
      desc: '',
      args: [],
    );
  }

  /// `you didn't select any seat :(`
  String get uDidnotSelectSeat {
    return Intl.message(
      'you didn\'t select any seat :(',
      name: 'uDidnotSelectSeat',
      desc: '',
      args: [],
    );
  }

  /// `Available`
  String get available {
    return Intl.message('Available', name: 'available', desc: '', args: []);
  }

  /// `Go !`
  String get go {
    return Intl.message('Go !', name: 'go', desc: '', args: []);
  }

  /// `Selected`
  String get selected {
    return Intl.message('Selected', name: 'selected', desc: '', args: []);
  }

  /// `Reserved`
  String get reserved {
    return Intl.message('Reserved', name: 'reserved', desc: '', args: []);
  }

  /// `seat price : `
  String get seatPrice {
    return Intl.message('seat price : ', name: 'seatPrice', desc: '', args: []);
  }

  /// `seats chosen : `
  String get seatsChosen {
    return Intl.message(
      'seats chosen : ',
      name: 'seatsChosen',
      desc: '',
      args: [],
    );
  }

  /// `selected seats : `
  String get selectedSeats {
    return Intl.message(
      'selected seats : ',
      name: 'selectedSeats',
      desc: '',
      args: [],
    );
  }

  /// `final price : `
  String get finalPrice {
    return Intl.message(
      'final price : ',
      name: 'finalPrice',
      desc: '',
      args: [],
    );
  }

  /// `actors`
  String get actors {
    return Intl.message('actors', name: 'actors', desc: '', args: []);
  }

  /// `about`
  String get about {
    return Intl.message('about', name: 'about', desc: '', args: []);
  }

  /// `Do you Know who is `
  String get douKnowWhoIs {
    return Intl.message(
      'Do you Know who is ',
      name: 'douKnowWhoIs',
      desc: '',
      args: [],
    );
  }

  /// `resources`
  String get resources {
    return Intl.message('resources', name: 'resources', desc: '', args: []);
  }

  /// `Book NOW!`
  String get bookNow {
    return Intl.message('Book NOW!', name: 'bookNow', desc: '', args: []);
  }

  /// `More Details`
  String get moreDetails {
    return Intl.message(
      'More Details',
      name: 'moreDetails',
      desc: '',
      args: [],
    );
  }

  /// `pay`
  String get pay {
    return Intl.message('pay', name: 'pay', desc: '', args: []);
  }

  /// `Check out`
  String get checkOut {
    return Intl.message('Check out', name: 'checkOut', desc: '', args: []);
  }

  /// `Film name:`
  String get filmName {
    return Intl.message('Film name:', name: 'filmName', desc: '', args: []);
  }

  /// `Seats numbers:`
  String get seatsNumbers {
    return Intl.message(
      'Seats numbers:',
      name: 'seatsNumbers',
      desc: '',
      args: [],
    );
  }

  /// `Seats count:`
  String get seatsCount {
    return Intl.message('Seats count:', name: 'seatsCount', desc: '', args: []);
  }

  /// `Total price:`
  String get totalPrice {
    return Intl.message('Total price:', name: 'totalPrice', desc: '', args: []);
  }

  /// `Total discount:`
  String get totalDiscount {
    return Intl.message(
      'Total discount:',
      name: 'totalDiscount',
      desc: '',
      args: [],
    );
  }

  /// `Total to Pay:`
  String get totalToPay {
    return Intl.message(
      'Total to Pay:',
      name: 'totalToPay',
      desc: '',
      args: [],
    );
  }

  /// `Based on phone mode`
  String get basedOnPhoneMode {
    return Intl.message(
      'Based on phone mode',
      name: 'basedOnPhoneMode',
      desc: '',
      args: [],
    );
  }

  /// `Manual`
  String get manual {
    return Intl.message('Manual', name: 'manual', desc: '', args: []);
  }

  /// `Dark Mode`
  String get darkMode {
    return Intl.message('Dark Mode', name: 'darkMode', desc: '', args: []);
  }

  /// `Light Mode`
  String get lightMode {
    return Intl.message('Light Mode', name: 'lightMode', desc: '', args: []);
  }

  /// `Green`
  String get green {
    return Intl.message('Green', name: 'green', desc: '', args: []);
  }

  /// `Blue`
  String get blue {
    return Intl.message('Blue', name: 'blue', desc: '', args: []);
  }

  /// `Purple`
  String get purple {
    return Intl.message('Purple', name: 'purple', desc: '', args: []);
  }

  /// `BOPM`
  String get BOPM {
    return Intl.message('BOPM', name: 'BOPM', desc: '', args: []);
  }

  /// `Hall : `
  String get hall {
    return Intl.message('Hall : ', name: 'hall', desc: '', args: []);
  }

  /// `Date : `
  String get date {
    return Intl.message('Date : ', name: 'date', desc: '', args: []);
  }

  /// `Time : `
  String get time {
    return Intl.message('Time : ', name: 'time', desc: '', args: []);
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'nl'),
      Locale.fromSubtags(languageCode: 'ru'),
      Locale.fromSubtags(languageCode: 'tr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
