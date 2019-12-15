import 'package:flutter/material.dart';

class Tester extends StatelessWidget {
  void _onPress() {
    print("Search tapped!");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue[100],
      //body
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bonnie",
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w400,
                color: Colors.deepOrange,
              ),
            ),
            InkWell(
              child: Text("Test"),
              onTap: () => debugPrint("Button tapped!"),
            ),
          ],
        ),
      ),
    );
  }
}
