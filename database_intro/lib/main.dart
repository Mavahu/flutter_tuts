import 'package:flutter/material.dart';

import 'models/user.dart';
import 'util/database_helper.dart';

void main() async {
  var db = DatabaseHelper();

  //await db.saveUser(User("Igor", "igar"));

  //print("User saved $savedUser");

  //Get all users;

  List users = await db.getAllUser();
  for (var i = 0; i < users.length; i++) {
    User user = User.fromMap(users[i]);

    print("Username: ${user.username}, User Id: ${user.id}");
  }
  //await db.deleteUser(1);
  User flutur = await db.getUser(2);

  await db.updateUser(flutur);
  //print("Got Username: ${flutur.username}");
  print(await db.getCount());

  runApp(MaterialApp(
    title: "DB Intro",
    home: Home(),
  ));
}

class Home extends StatelessWidget {
  var db = DatabaseHelper();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Database"),
          centerTitle: true,
          backgroundColor: Colors.lightGreen,
        ),
        body: FutureBuilder(
          future: db.getAllUser(),
          builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
            if (snapshot.hasData) {
              List content = snapshot.data;
              return ListView.builder(
                padding: const EdgeInsets.all(14.5),
                itemCount: content.length,
                itemBuilder: (_, int position) {
                  User user = User.fromMap(content[position]);
                  return Card(
                    elevation: 3.0,
                    color: Colors.white,
                    child: ListTile(
                      title: Text("User: ${user.username}"),
                      subtitle: Text("Id: ${user.id}"),
                      onTap: () => debugPrint("${user.password}"),
                    ),
                  );
                },
              );
            } else
              return Text("No data");
          },
        ));
  }
}
