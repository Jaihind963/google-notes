import 'package:flutter/material.dart';
import 'package:google_notes/services/database.dart';

class EditNote extends StatefulWidget {
  final String noteid;
  final String existingTitle;
  final String existingNote;
  const EditNote(
      {super.key,
      required this.noteid,
      required this.existingTitle,
      required this.existingNote});

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  late TextEditingController noteController;
  late TextEditingController titleController;

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController(text: widget.existingNote);
    titleController = TextEditingController(text: widget.existingTitle);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
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
                  Map<String, dynamic> updateInfo = {
                    "Title": titleController.text,
                    "Note": noteController.text
                  };
                  await DataBase().editNote(widget.noteid, updateInfo);
                  Navigator.pop(context);
                },
                child: Center(
                  child: Text("Update"),
                ),
              ),
              SizedBox(height: 25),
              ElevatedButton(
                  onPressed: () {
                    DataBase().deleteNote(widget.noteid);
                    Navigator.pop(context);
                  },
                  child: Center(child: Text("Delete")))
            ],
          ),
        ),
      ),
    );
  }
}
