import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.cyan,
        alignment: Alignment.center,
        child: Stack(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
            Container(
              width: 90,
              height: 90,
              color: Colors.green,
            ),
            Container(
              width: 80,
              height: 80,
              color: Colors.blue,
            ),
          ],
        )
/*       child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Item 1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.9,
            ),
          ),
          Text(
            "Item 2",
            style: TextStyle(
              color: Colors.white,
              fontSize: 12.9,
            ),
          ),
          const Expanded(
            child: const Text("Item 3"),
          ),
        ],
      ), */

/*       child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "First item",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Text(
            "Second item",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          Container(
            color: Colors.deepOrange.shade50,
            alignment: Alignment.bottomLeft,
            child: Text(
              "Container item",
              style: TextStyle(
                color: Colors.blue,
              ),
            ),
          ),
        ],
      ), */
/*       child: Text(
         "Hello",
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w900,
          fontSize: 36.0,
        ),
      ), */
        );
  }
}
