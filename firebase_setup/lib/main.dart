import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/board.dart';

void main() async => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Community Board',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*
  void _incrementCounter() async{
    databaseRef
        .collection("message")
        .add({"firstName": "Martin", "lastName": "Hubert"});

    final data = await databaseRef.collection("message").getDocuments();
    print(data.documents);
    setState(() {
      _counter++;
    });
  }
  */

  List<Board> boardMessages = List();
  Board board = Board("", "");

  final Firestore database = Firestore.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  CollectionReference databaseRef;

  @override
  void initState() {
    super.initState();
    databaseRef = database.collection("comm_board").reference();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Community Board"),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Flexible(
            flex: 0,
            child: Form(
              key: formKey,
              child: Flex(
                direction: Axis.vertical,
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.subject),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => board.subject = val,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.message),
                    title: TextFormField(
                      initialValue: "",
                      onSaved: (val) => board.body = val,
                      validator: (val) => val == "" ? val : null,
                    ),
                  ),
                  FlatButton(
                    child: Text("Post"),
                    color: Colors.redAccent,
                    onPressed: () {
                      _handleSubmit();
                    },
                  )
                ],
              ),
            ),
          ),
          Flexible(
            child: StreamBuilder(
              stream: databaseRef.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) return Text('Error: ${snapshot.error}');
                switch (snapshot.connectionState) {
                  case ConnectionState.waiting:
                    return Text('Loading...');
                  default:
                    return ListView(
                      children: snapshot.data.documents
                          .map((DocumentSnapshot document) {
                        return ListTile(
                          title: Text(document['subject']),
                          subtitle: Text(document['body']),
                        );
                      }).toList(),
                    );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  void _addMessage(Board board) async {
    final key = await databaseRef.add(board.toJson());
    Board addedBoard = Board(board.subject, board.body);
    addedBoard.key = key.documentID;
    setState(() {
      boardMessages.add(addedBoard);
    });
    print("Added element");
    /*print(key.documentID);
    final obj = await databaseRef.document(key.documentID).get();
    print(obj.data);*/
  }

  void _handleSubmit() async {
    final FormState form = formKey.currentState;
    if (form.validate()) {
      form.save();
      form.reset();
      _addMessage(board);
    }
  }
}
