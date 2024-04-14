import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_notes/services/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WriteNotes extends StatefulWidget {
  const WriteNotes({super.key});

  @override
  State<WriteNotes> createState() => _WriteNotesState();
}

class _WriteNotesState extends State<WriteNotes> {
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_alert_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.add_alert_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.save_outlined),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Title",
                  hintStyle: TextStyle(fontSize: 25),
                ),
              ),
              TextField(
                controller: noteController,
                minLines: 1,
                maxLines: 25,
                decoration: InputDecoration(
                  hintText: "Note",
                  hintStyle: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  Map<String, dynamic> noteInfo = {
                    "Title": titleController.text.trim(),
                    "Note": noteController.text.trim(),
                  };
                  await DataBase().addNote(noteInfo).then((value) {
                    Navigator.pop(context);
                  });
                },
                child: Center(child: Text("Save")),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
