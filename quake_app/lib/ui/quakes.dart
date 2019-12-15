/*import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Quakes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Quake App"),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: 2,
        itemBuilder: (BuildContext context, int position) {
          return Column(
            children: <Widget>[
              Divider(height: 5.5),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text("0.00",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.9,
                          fontWeight: FontWeight.w800)),
                ),
                title: Text(
                  "Datum",
                  style: TextStyle(color: Colors.orangeAccent, fontSize: 15.9),
                ),
                subtitle: Text(
                  "bla bla",
                  style: TextStyle(
                      fontSize: 12.9,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
                onTap: () => _showOnTapMessage(context, "test"),
              ),
            ],
          );
        },
      ),
    );
  }
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("Quakes"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text("Oki doki"),
        onPressed: () => Navigator.pop(context),
      )
    ],
  );

  showDialog(context: context, builder: (context) => alert);
}

Future<List> getJsonData() async {
  return null;
}
*/