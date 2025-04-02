//this constants just for dio and mapper
import 'package:event_mobile_app/domain/models/billing_info/billing_info.dart';

import '../../../domain/models/show_time_response/show_time_response.dart';

class AppConstants {
  static const String baseUrl = 'https://eventapi-teal.vercel.app/';
  static const String getMovies = 'get-movies/';
  static const String createGuest = '${baseUrl}create-guest/';
  static const String getStripeKeys = '${baseUrl}stripe_keys/';
  static const String create_reservation = '${baseUrl}create-reservation/';
  static const String delete_reservation = '${baseUrl}delete-reservation/';
  static const String createPayment = '${baseUrl}payments/create/';
  static  String getOneMovie ({required int movieId})=> '${baseUrl}viewsets/movies/${movieId}';
  static const String emptyText = '';
  static const double doubleZero = 0.0;
  static const int intZero = 0;
  static const List<int> emptyIntList = [];
  static const List<int> emptyList = [];
  static const List<ShowTimesResponse>? emptyShowTimesResponseList = [];
  static const List<BillingInfo> emptyBillingInfoList = [];
  static const List<double> emptyDoubleList = [];
  static const List<String> emptyStringList = [];
  static const Map emptyMap = {};
  static const Map<int, List<String>> emptyIntListMap = {};
  static const Map<int, double> emptyIntDoubleMap = {};
  static DateTime defaultDate = DateTime.now();
}
