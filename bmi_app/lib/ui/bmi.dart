import 'package:flutter/material.dart';
import 'dart:math' as math;

class BMI extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return BMIState();
  }
}

class BMIState extends State<BMI> {
  TextEditingController _ageController = TextEditingController();
  TextEditingController _heightController = TextEditingController();
  TextEditingController _weightController = TextEditingController();

  String _weightStatus ="";
  String _finalBMI = "";
  void calculateBMI() {
    setState(() {
      if (_ageController.text.isNotEmpty &&
          _heightController.text.isNotEmpty &&
          _weightController.text.isNotEmpty) {
        double weight = double.parse(_weightController.text);
        double height = double.parse(_heightController.text)/100;
        int age = int.parse(_ageController.text);

        double bmi;
        if (weight > 0 && height > 0) {
          bmi = (weight / math.pow(height, 2)); //or just divide height through 100
          if (bmi < 18.5) {
            _weightStatus = "Underweight";
          } else if (18.5 <= bmi && bmi < 25) {
            _weightStatus = "Normal weight";
          } else if (25 <= bmi && bmi < 30) {
            _weightStatus = "Overweight";
          } else if (30 <= bmi && bmi < 35) {
            _weightStatus = "Obesity";
          } else if (bmi >= 35) {
            _weightStatus = "Severe obesity";
          }
          debugPrint("$bmi");
          debugPrint("${bmi.toStringAsPrecision(4)}");
          _finalBMI = "Your BMI: ${bmi.toStringAsPrecision(4)}";
        }
      } else {
        _finalBMI = "";
        _weightStatus = "";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("BMI"),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(2.0),
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(2.5),
              child: Image.asset(
                "assets/BMI.png",
                height: 130.0,
                width: 130.0,
              ),
            ),
            Container(
              color: Colors.grey[350],
              //alignment: Alignment.center,
              margin: EdgeInsets.all(5.5),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _ageController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Age",
                      icon: Icon(Icons.person_outline),
                    ),
                  ),
                  TextField(
                    controller: _heightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Height in cm",
                      icon: Icon(Icons.poll),
                    ),
                  ),
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Weight in kg",
                      icon: Icon(Icons.line_weight),
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(10.0)),
                  RaisedButton(
                    color: Colors.pinkAccent,
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onPressed: calculateBMI,
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text(
                    "$_finalBMI",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 19.9,
                    ),
                  ),
                  Padding(padding: EdgeInsets.all(5.0)),
                  Text(
                    "$_weightStatus",
                    style: TextStyle(
                      color: Colors.pink,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.italic,
                      fontSize: 19.9,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
