import 'package:flutter/material.dart';

class ChangeCity extends StatelessWidget {
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        title: Text("Change City"),
        centerTitle: true,
      ),
      body: Stack(
        children: <Widget>[
          Image.asset(
            "assets/snow_screen.jpg",
            width: 490.0,
            height: 1200.0,
            fit: BoxFit.fill,
          ),
          ListView(
            children: <Widget>[
              ListTile(
                title: TextField(
                  controller: _cityController,
                  decoration: InputDecoration(hintText: "Enter City"),
                  keyboardType: TextInputType.text,
                ),
              ),
              ListTile(
                title: FlatButton(
                  child: Text("Get Weather!"),
                  onPressed: () {
                    Navigator.pop(context, {'info': _cityController.text});
                  },
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
