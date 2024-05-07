import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_notes/utils/utils.dart';

class DataBase {
  Future addNote(Map<String, dynamic> noteInfo) async {
    try {
      await FirebaseFirestore.instance.collection("Notes").add(noteInfo);
      Utils().flutterToast("Note successfully added");
    } on FirebaseException catch (ex) {
      Utils().flutterToast(ex.toString());
    }
  }

  Future editNote(String noteId, Map<String, dynamic> updateInfo) async {
    try {
      await FirebaseFirestore.instance
          .collection("Notes")
          .doc(noteId)
          .update(updateInfo);
      Utils().flutterToast("Note successfully edited");
    } catch (e) {
      print(e.toString());
      Utils().flutterToast(e.toString());
    }
  }

  Future deleteNote(String noteId) async {
    try {
      await FirebaseFirestore.instance.collection("Notes").doc(noteId).delete();
      Utils().flutterToast("Note successfully deleted");
    } catch (ex) {
      Utils().flutterToast(ex.toString());
    }
  }
}
