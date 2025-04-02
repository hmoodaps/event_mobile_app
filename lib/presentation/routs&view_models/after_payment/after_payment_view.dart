import 'package:flutter/material.dart';

class AfterPaymentView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Payment Successful")),
      body: Center(child: Text("Thank you for your payment! 🎉")),
    );
  }
}
