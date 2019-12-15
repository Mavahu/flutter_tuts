import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  runApp(MaterialApp(
    title: "Shared Pref",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _enterDataField = TextEditingController();
  String _savedData = "";
  @override
  void initState() {
    super.initState();

    _loadSavedData();
  }

  _loadSavedData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      if (preferences.containsKey("data") && preferences.getString("data").isNotEmpty) {
        _savedData = preferences.getString("data");
      }
    });
  }

  _saveMessage(String message) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("data", message);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Shared Prefs"),
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
              _saveMessage(_enterDataField.text);
            },
            child: Column(
              children: [
                Text("Save Data"),
                Padding(padding: const EdgeInsets.all(14.5)),
                Text(_savedData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
