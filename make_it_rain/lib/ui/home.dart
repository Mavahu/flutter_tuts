import 'package:flutter/material.dart';

class MakeItRain extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MakeItRainState();
  }
}

class MakeItRainState extends State<MakeItRain> {
  int _money = 0;

  //setState redraws the User Interface otherwise no money change
  //is visible
  void _rainMoney() {
    setState(() {
      _money += 1000;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Make It Rain!"),
        backgroundColor: Colors.lightGreen,
      ),
      body: Column(
        children: <Widget>[
          //title
          const Center(
            child: Text(
              "Get Rich!",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w400,
                fontSize: 30.0,
              ),
            ),
          ),
          //bank account balance
          Expanded(
            child: Center(
              child: Text(
                "\$$_money",
                style: TextStyle(
                  color: _money >= 10000 ? Colors.green : Colors.greenAccent,
                  fontSize: 46.9,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
          ),
          //add money button
          Expanded(
            child: Center(
              child: FlatButton(
                color: Colors.lightGreen,
                onPressed: _rainMoney,
                child: const Text(
                  "Let It Rain!",
                  style: TextStyle(
                    fontSize: 23.9,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
