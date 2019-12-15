import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  void _onPress() {
    print("Search tapped!");
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.blue[100],
      //appBar
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Fancy Day",
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          new IconButton(
            icon: Icon(Icons.send),
            onPressed: () => debugPrint("Icon tapped"),
            color: Colors.black,
          ),
          new IconButton(
            icon: Icon(Icons.search),
            onPressed: _onPress,
            color: Colors.black,
          ),
        ],
      ),
      //body
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Bonnie",
              style: TextStyle(
                fontSize: 14.5,
                fontWeight: FontWeight.w400,
                color: Colors.deepOrange,
              ),
            ),
            InkWell(
              child: Text("Test"),
              onTap: () => debugPrint("Button tapped!"),
            ),
          ],
        ),
      ),
      //bottomNavBar
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            title: Text("Hey"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.print),
            title: Text("HeyHo"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.call),
            title: Text("Call"),
          ),
        ],
        onTap: (int i) => debugPrint("Hey Touched $i"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => debugPrint("Pressed Button"),
        backgroundColor: Colors.lightGreen,
        tooltip: "Going UP!",
        child: Icon(Icons.call_end),
      ),
    );
  }
}
