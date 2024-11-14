import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/material.dart';

class TakeUserDetailsModelView extends BaseViewModel{
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController additinalInfo = TextEditingController();
  TextEditingController street = TextEditingController();
  final  formKey = GlobalKey<FormState>();

  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(DateTime.now().year - 16 - 1930 + 1, (index) => 1930 + index);


  int selectedDay = 26;
  int selectedMonth = 5;
  int selectedYear = 1999;
  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    // TODO: implement start
  }


}