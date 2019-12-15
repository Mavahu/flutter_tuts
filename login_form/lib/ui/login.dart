import 'package:flutter/material.dart';

class LoginForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginFormState();
  }
}

class LoginFormState extends State<LoginForm> {
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  String _welcomeString = "";

  void _erase() {
    setState(() {
      _userController.clear();
      _passController.clear();
    });
  }

  void _showWelcome() {
    setState(() {
      if (_userController.text.isNotEmpty && _passController.text.isNotEmpty) {
        _welcomeString = _userController.text;
      } else {
        _welcomeString = "Nothing";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //appBar
      appBar: AppBar(
        title: Text("Login Form"),
        //centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      backgroundColor: Colors.blueGrey,
      body: Container(
        alignment: Alignment.topCenter,
        child: ListView(
          children: <Widget>[
            //picture
            Image.asset(
              "assets/face.png",
              height: 89.9,
              width: 89.9,
            ),
            //form
            Container(
              height: 180.0,
              width: 380.0,
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: _userController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      icon: Icon(Icons.person),
                    ),
                  ),
                  TextField(
                    controller: _passController,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      icon: Icon(Icons.lock),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10.5),
                  ),
                  Center(
                    child: Row(
                      children: <Widget>[
                        //Login Button
                        Container(
                          margin: const EdgeInsets.only(left: 30.0),
                          child: RaisedButton(
                            onPressed: _showWelcome,
                            color: Colors.redAccent,
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.9),
                            ),
                          ),
                        ),
                        //Clear Button
                        Container(
                          margin: const EdgeInsets.only(left: 140.0),
                          child: RaisedButton(
                            onPressed: _erase,
                            color: Colors.redAccent,
                            child: Text(
                              "Clear",
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.9),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ), // form ends here
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(
                top: 18.4,
              ),
              child: Text(
                "Welcome, $_welcomeString",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19.4,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
