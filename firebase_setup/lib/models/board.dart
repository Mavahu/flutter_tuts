import 'package:cloud_firestore/cloud_firestore.dart';

class Board {
  String key;
  String subject;
  String body;

  Board(this.subject, this.body);

  Board.fromSnapshot(DocumentSnapshot snapshot) {
    key = snapshot.documentID;
    subject = snapshot.data["subject"];
    body = snapshot.data["body"];
  }

  toJson() {
    return {"subject": subject, "body": body};
  }
}
