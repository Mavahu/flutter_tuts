import 'package:flutter/material.dart';

import 'package:no_to_do/models/nodoitem_model.dart';
//import 'package:no_to_do/util/database_client.dart';
import 'package:intl/intl.dart' as intl;
import 'package:no_to_do/util/database_client.dart';
import 'package:no_to_do/util/date_formatter.dart';

class NoToDoScreen extends StatefulWidget {
  @override
  _NoToDoScreenState createState() => _NoToDoScreenState();
}

class _NoToDoScreenState extends State<NoToDoScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  var db = DatabaseClient();
  final List<NoDoItem> _itemList = <NoDoItem>[];

  @override
  void initState() {
    super.initState();
    _readNoDoList();
  }

  void _handleSubmit(String text) async {
    _textEditingController.clear();
    NoDoItem noDoItem = NoDoItem(text, dateFormatted());
    int savedItemId = await db.saveItem(noDoItem);

    NoDoItem addedItem = await db.getItem(savedItemId);

    setState(() {
      _itemList.insert(0, addedItem);
    });

    print("Item saved id: $savedItemId");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: <Widget>[
          Flexible(
              child: ListView.builder(
            padding: const EdgeInsets.all(14.5),
            itemCount: _itemList.length,
            itemBuilder: (_, int index) {
              return Card(
                color: Colors.white10,
                child: ListTile(
                  title: _itemList[index],
                  onLongPress: () {
                    _updateItem(_itemList[index], index);
                  },
                  trailing: Listener(
                    key: Key(_itemList[index].itemName),
                    child: Icon(Icons.remove_circle, color: Colors.redAccent),
                    onPointerDown: (pointerEvent) {
                      _deleteNoDo(_itemList[index].id, index);
                    },
                  ),
                ),
              );
            },
          ))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: "Add Item",
        backgroundColor: Colors.redAccent,
        child: Icon(Icons.add),
        onPressed: _showFormDialog,
      ),
    );
  }

  void _showFormDialog() {
    var alert = AlertDialog(
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                labelText: "Item",
                hintText: "eg. Don't buy stuff!",
                icon: Icon(Icons.note_add),
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () {
            _handleSubmit(_textEditingController.text);
            Navigator.pop(context);
          },
          child: Text("Save"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  _readNoDoList() async {
    List items = await db.getAllItems();
    items.forEach((item) {
      //NoDoItem noDoItem = NoDoItem.map(item);
      setState(() {
        _itemList.insert(0, NoDoItem.map(item));
      });
      //print("Db item: ${noDoItem.itemName}");
    });
  }

  _deleteNoDo(int id, int index) async {
    debugPrint("Deleted Item!");
    await db.deleteItem(id);
    setState(() {
      _itemList.removeAt(index);
    });
  }

  _updateItem(NoDoItem item, int index) async {
    debugPrint("Updated Item!");
    var alert = AlertDialog(
      title: Text("Update Item"),
      content: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: InputDecoration(
                  hintText: "eg. Don't buy stuff",
                  labelText: "Item",
                  icon: Icon(Icons.update)),
            ),
          )
        ],
      ),
      actions: <Widget>[
        FlatButton(
          onPressed: () async {
            NoDoItem noDoItemUpdated = NoDoItem.fromMap({
              "itemName": _textEditingController.text,
              "dateCreated": dateFormatted(),
              "id": item.id
            });
            _handleSubmittedUpdate(index, item);
            await db.updateItem(noDoItemUpdated);
            setState(() {
              _readNoDoList();
            });
            Navigator.pop(context);
          },
          child: Text("Update"),
        ),
        FlatButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel"),
        )
      ],
    );
    showDialog(context: context, builder: (_) => alert);
  }

  void _handleSubmittedUpdate(int index, NoDoItem item) {
    //_textEditingController.clear();

    setState(() {
      _itemList.removeWhere((element) {
        _itemList[index].itemName == item.itemName;
      });
    });
  }
}

/*FutureBuilder(
        future: null, //db.getAllItems(),
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          if (snapshot.hasData) {
            List content = snapshot.data;
            return ListView.builder(
              padding: const EdgeInsets.all(14.5),
              itemCount: content.length,
              itemBuilder: (_, int position) {
                Item item = Item.fromMap(content[position]);

                final f = intl.DateFormat.yMMMMd().add_jm();
                var date = f.format(DateTime.fromMillisecondsSinceEpoch(
                    item.timestamp,
                    isUtc: true));
                return Card(
                  //margin: const EdgeInsets.fromLTRB(30.0, 0.0, 0.0, 0.0),
                  elevation: 3.0,
                  color: Colors.white,
                  child: ListTile(
                    //contentPadding: const EdgeInsets.fromLTRB(15.0, 0.0, 0.0, 0.0),
                    title: Text("${item.title}"),
                    subtitle: Text("Created on: $date"),
                    onLongPress: () => debugPrint("${item.id}"),
                  ),
                );
              },
            );
          } else {
            return Text("No data");
          }
        },
      ),
    ); */
