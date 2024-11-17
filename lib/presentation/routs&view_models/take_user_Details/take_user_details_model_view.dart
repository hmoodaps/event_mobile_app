import 'package:event_mobile_app/presentation/base/base_view_model.dart';
import 'package:flutter/cupertino.dart';

import '../../../domain/local_models/models.dart';
import '../../bloc_state_managment/bloc_manage.dart';
import '../../bloc_state_managment/events.dart';

class TakeUserDetailsModelView extends BaseViewModel
    with TakeUserDetailsFunctions {
  TextEditingController dateOfBirth = TextEditingController();
  TextEditingController houseNumber = TextEditingController();
  TextEditingController mobileNumber = TextEditingController();
  TextEditingController postalCode = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController additinalInfo = TextEditingController();
  TextEditingController street = TextEditingController();
  late final BuildContext context ;
  final formKey = GlobalKey<FormState>();

  final List<int> days = List.generate(31, (index) => index + 1);
  final List<int> months = List.generate(12, (index) => index + 1);
  final List<int> years = List.generate(
      DateTime.now().year - 16 - 1930 + 1, (index) => 1930 + index);

  int selectedDay = 26;
  int selectedMonth = 5;
  int selectedYear = 1999;
  late EventsBloc _bloc;

  @override
  void dispose() {
    // TODO: implement dispose
  }

  @override
  void start() {
    _bloc = EventsBloc.get(context);
  }

  @override
  onContinueTap({required CreateUserRequirements req}) {
    _bloc.add(AddUserDetailsEvent(req: req));
  }
}

mixin TakeUserDetailsFunctions {
  onContinueTap({required CreateUserRequirements req});
}
