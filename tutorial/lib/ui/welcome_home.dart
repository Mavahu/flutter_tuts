import 'package:flutter/material.dart';

class Welcome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(),
      body: ListTile(
        leading: Container(
          width: 40,
        ),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("data"),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("left"),
                Spacer(),
                Text("right"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
