import 'package:flutter/material.dart';

import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() async {
  List _data = await getJson();

  for (int i = 0; i < _data.length; i++) {
    print(_data[i]['id']);
  }
  String _body = "";
  _body = _data[0]["body"];

  runApp(MaterialApp(
    title: "Intro into Parsing!",
    home: Scaffold(
      appBar: AppBar(
        title: Text("JSON Parse"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: _data.length,
        padding: const EdgeInsets.all(14.5),
        itemBuilder: (BuildContext context, int position) {
          return Column(
            children: <Widget>[
              Divider(
                height: 5.5,
              ),
              ListTile(
                title: Text(
                  "${_data[position]["title"]}",
                  style: TextStyle(
                    fontSize: 17.9,
                  ),
                ),
                subtitle: Text(
                  "${_data[position]['body']}",
                  style: TextStyle(
                    fontSize: 13.9,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  child: Text(
                    "${_data[position]['id']}",
                    style: TextStyle(
                      fontSize: 16.9,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                onTap: () =>
                    _showOnTapMessage(context, _data[position]["body"]),
              )
            ],
          );
        },
      ),
    ),
  ));
}

void _showOnTapMessage(BuildContext context, String message) {
  var alert = AlertDialog(
    title: Text("My App"),
    content: Text(message),
    actions: <Widget>[
      FlatButton(
        child: Text("OK"),
        onPressed: () {
          Navigator.pop(context);
        },
      )
    ],
  );

  showDialog(context: context, builder: (context) => alert);
}

// https://jsonplaceholder.typicode.com/posts
Future<List> getJson() async {
  final String apiUrl = "https://jsonplaceholder.typicode.com/posts";

  http.Response response = await http.get(apiUrl);

  return convert.jsonDecode(response.body);
}
