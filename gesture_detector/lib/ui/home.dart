import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  final String title;

  Home({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text(title),
      ),
      body: Center(
        child: customButton(),
      ),
    );
  }
}

class customButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        final snackBar = SnackBar(
          content: Text("Hello Gestures",style: TextStyle(color: Colors.black),),
          backgroundColor: Theme.of(context).backgroundColor,
          duration: Duration(milliseconds: 900),
        );
        Scaffold.of(context).showSnackBar(snackBar);
      },
      //the actual button
      child: Container(
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Theme.of(context).buttonColor,
          borderRadius: BorderRadius.circular(5.5),
        ),
        child: Text("First Button!"),
      ),
    );
  }
}
