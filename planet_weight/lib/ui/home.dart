import 'package:flutter/material.dart';

class PlanetWeight extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PlanetWeightState();
  }
}

class PlanetWeightState extends State<PlanetWeight> {
  TextEditingController _weightController = TextEditingController();

  int radioValue = 0;
  String _finalResult = "Please enter a weight";
  void handleRadioValueChanged(int value) {
    setState(() {
      radioValue = value;
      _weightChanged();
    });
  }

  void _weightChanged() {
    setState(() {
      /*
      https://www.livescience.com/33356-weight-on-planets-mars-moon.html
      Mercury: 0.38
      Venus: 0.91
      Earth: 1.00
      Mars: 0.38
      Jupiter: 2.34
      Saturn: 1.06
      Uranus: 0.92
      Neptune: 1.19
      Pluto: 0.06
       */
      if (_weightController.text.isNotEmpty) {
        double weight = double.parse(_weightController.text);
        _finalResult = "Your weight on ";
        switch (radioValue) {
          //Pluto
          case 0:
            {
              weight *= 0.06;
              _finalResult += "Pluto ";
            }
            break;
          //Mars
          case 1:
            {
              weight *= 0.38;
              _finalResult += "Mars ";
            }
            break;
          //Venus
          case 2:
            {
              weight *= 0.91;
              _finalResult += "Venus ";
            }
            break;
        }

        //convert the weight to a string to cut off the unnecessary decimals
        //which occure due to the double precision
        _finalResult += "is ${weight.toStringAsFixed(2)} kg";
      } else {
        _finalResult = "Please enter a weight";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        title: Text("Weight On Planet X"),
        centerTitle: true,
        backgroundColor: Colors.blueGrey[800],
      ),
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          padding: const EdgeInsets.all(2.5),
          children: <Widget>[
            Image.asset(
              "assets/planet.png",
              height: 130.0,
              width: 130.0,
            ),
            Container(
              margin: const EdgeInsets.all(3.0),
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _weightController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      labelText: 'Your Weight on Earth',
                      hintText: 'In Kg',
                      icon: Icon(Icons.person_outline),
                    ),
                    onEditingComplete: _weightChanged,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(5.0),
                  ),
                  //three radio Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Radio<int>(
                        activeColor: Colors.brown,
                        value: 0,
                        groupValue: radioValue,
                        onChanged: handleRadioValueChanged,
                      ),
                      const Text(
                        "Pluto",
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.w400),
                      ),
                      Radio<int>(
                        activeColor: Colors.red,
                        value: 1,
                        groupValue: radioValue,
                        onChanged: handleRadioValueChanged,
                      ),
                      const Text(
                        "Mars",
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.w400),
                      ),
                      Radio<int>(
                        activeColor: Colors.orangeAccent,
                        value: 2,
                        groupValue: radioValue,
                        onChanged: handleRadioValueChanged,
                      ),
                      const Text(
                        "Venus",
                        style: TextStyle(
                            color: Colors.white60, fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.all(15.6),
                  ),
                  Text(
                    "$_finalResult",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19.4,
                      fontWeight: FontWeight.w500,
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
