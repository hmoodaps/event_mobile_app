import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';

Widget myCard({String? cardNumber , String ? endDate , String ? cardHolderName}) {
  TextStyle textStyle = TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
      fontFamily: 'orca');
  String formatEndDate(String? date) {
    if (date == null || date.isEmpty) {
      return "MM/YY";
    }
    if (date.length > 2) {
      return "${date.substring(0, 2)}/${date.substring(2)}";
    }
    return date;
  }
  String formatCardNumber(String? number) {
    if (number == null || number.isEmpty) {
      return "XXXX XXXX XXXX XXXX";
    }
    return number.replaceAllMapped(RegExp(r".{1,4}"), (match) => "${match.group(0)} ").trim();
  }


  return Container(
    height: 220,
    width: 380,
    decoration: BoxDecoration(
      color: Colors.blue,
      backgroundBlendMode: BlendMode.softLight,
      gradient: LinearGradient(
        colors: [Colors.blue, Colors.black],
        stops: [0.1, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: Colors.white),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade800,
          offset: Offset(3, 10),
          blurRadius: 8,
          spreadRadius: 1,
          blurStyle: BlurStyle.normal,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.all(18.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              Image.asset("assets/images/sim.png" , color: Colors.white , width: 50 , height: 50,),
              Spacer(),
              Image.asset("assets/images/PayInT.png" , color: Colors.white , width: 30 , height: 30,),
            ],
          ),
          Text("cardNumber",              style: TextStyle(color: Colors.white, fontSize: 9),),
          Text(
            formatCardNumber(cardNumber) ,
            style: textStyle,
          ),
          SizedBox(height: 10,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "end\nDate",
                style: TextStyle(color: Colors.white, fontSize: 9),
              ),
              SizedBox(width: 10,),
              Text(formatEndDate(endDate)  , style: textStyle,),
            ],
          ),
        Text("cardHolder" ,               style: TextStyle(color: Colors.white, fontSize: 9),),
          Text(cardHolderName ?? "Ahmed Alnahhal",style: textStyle,)
        ],
      ),
    ),
  );
}

Widget myCardback() {
  return Container(
    height: 200,
    width: 380,
    decoration: BoxDecoration(
      color: Colors.blue,
      backgroundBlendMode: BlendMode.softLight,
      gradient: LinearGradient(
        colors: [Colors.red, Colors.black],
        stops: [0.1, 1],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderRadius: BorderRadius.circular(25),
      border: Border.all(color: Colors.white),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.shade800,
          offset: Offset(3, 10),
          blurRadius: 8,
          spreadRadius: 1,
          blurStyle: BlurStyle.normal,
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Center(
            child: Text(
          "orca 123",
          style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'orca'),
        )),
      ],
    ),
  );
}

Widget myCreditCard(Key cardKey ,{String? cardNumber , String ? endDate , String ? cardHolderName , int ? cvv} ) {
  return FlipCard(
    direction: FlipDirection.HORIZONTAL,
    // default
    fill: Fill.fillBack,
    // Fill the back side of the card to make in the same size as the front.
    side: CardSide.FRONT,
    key: cardKey,
    back: myCardback(),
    front: myCard(cardNumber : cardNumber , endDate: endDate,cardHolderName : cardHolderName ),
    speed: 1000,
    flipOnTouch: false,
  );
}
