import 'package:flutter/material.dart';

import 'package:path_provider/path_provider.dart' as path_provider;

import 'dart:io' as io;

void main() async {
  var data = await readData();
  if (data != null){
    String message = data;
    print(message);
  }
  runApp(MaterialApp(
    title: "Files",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Read/Write"),
        centerTitle: true,
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        padding: const EdgeInsets.all(14.5),
        alignment: Alignment.center,
        child: ListTile(
          title: TextField(
            controller: _enterDataField,
            decoration: InputDecoration(labelText: "Write Something"),
          ),
          subtitle: FlatButton(
            onPressed: () {
              writeData(_enterDataField.text);
            },
            child: Column(
              children: [
                Text("Save Data"),
                Padding(padding: const EdgeInsets.all(14.5)),
                FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context, AsyncSnapshot<String> data){
                    if(data.hasData != null){
                      return Text(data.data.toString());
                    }else{return Text("No data saved");}
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
  Future<String> get _localPath async {
    final dir = await path_provider.getApplicationDocumentsDirectory();
    return dir.path;
  }

  Future<io.File> get _localFile async {
    final path = await _localPath;
    return io.File("$path/data.txt");
  }

  Future<io.File> writeData(String message) async {
    final file = await _localFile;
    return file.writeAsString(message);
  }

  Future<String> readData() async {
    try {
      final file = await _localFile;

      String data = await file.readAsString();

      return data;
    } catch (e) {
      return "Something went wrong";
    }
  }
