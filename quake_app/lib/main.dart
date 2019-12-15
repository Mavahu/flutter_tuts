import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart' as intl;

import 'dart:convert' as convert;

List _quakes;

void main() async {
  Map _data = await getJsonData();
  _quakes = _data["features"];
  print(_quakes.length);
  runApp(
    MaterialApp(title: "Quake App", home: Quakes()),
  );
}

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
        padding: const EdgeInsets.all(15.0),
        itemCount: _quakes.length,
        itemBuilder: (BuildContext context, int position) {

          final f = intl.DateFormat.yMMMMd().add_jm();
          var date = f.format(DateTime.fromMillisecondsSinceEpoch(_quakes[position]["properties"]["time"], isUtc: true));

          return Column(
            children: <Widget>[
              Divider(height: 5.5),
              ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text("${_quakes[position]["properties"]["mag"]}",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.9,
                          fontWeight: FontWeight.bold)),
                ),
                title: Text(
                  "$date",
                  style: TextStyle(
                      color: Colors.orangeAccent,
                      fontWeight: FontWeight.w500,
                      fontSize: 15.9),
                ),
                subtitle: Text(
                  "${_quakes[position]["properties"]["place"]}",
                  style: TextStyle(
                      fontSize: 12.9,
                      fontStyle: FontStyle.italic,
                      color: Colors.grey),
                ),
                onTap: () => _showOnTapMessage(context, "${_quakes[position]["properties"]['type']}"),
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

Future<Map> getJsonData() async {
  final String apiUrl =
      "https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/4.5_week.geojson";

  http.Response response = await http.get(apiUrl);

  return convert.jsonDecode(response.body);
}
