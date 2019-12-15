import 'package:flutter/material.dart';

import 'ui/home.dart';

void main() async {
  //var db = DatabaseHelper();
  //await db.deleteItem(1);

  //print("User saved $savedUser");

  //Get all users;

  //List users = await db.getAllUser();
  /*for (var i = 0; i < users.length; i++) {
    User user = User.fromMap(users[i]);

    print("Username: ${user.username}, User Id: ${user.id}");
  }
  User flutur = await db.getUser(2);

  await db.updateUser(flutur);
  //print("Got Username: ${flutur.username}");
  print(await db.getCount());
*/
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "NoToDo",
    home: Home(),
  ));
}
