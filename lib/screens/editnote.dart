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
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    noteController = TextEditingController(text: widget.existingNote);
    titleController = TextEditingController(text: widget.existingTitle);
  }
  @override
  void didUpdateWidget(covariant EditNote oldWidget) {
    super.didUpdateWidget(oldWidget);
    noteController.text = widget.existingNote;
    titleController.text = widget.existingTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Title",
                    hintStyle: TextStyle(fontSize: 25),
                  ),
                ),
                TextFormField(
                  validator: (value) {
                    if(value.toString().isEmpty){
                      return "Field Required";
                    }
                  },
                  controller: noteController,
                  minLines: 1,
                  maxLines: 25,
                  decoration: const InputDecoration(
                    hintText: "Note",
                    hintStyle: TextStyle(fontSize: 18),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      Map<String, dynamic> updateInfo = {
                      "Title": titleController.text,
                      "Note": noteController.text
                    };
                    await DataBase().editNote(widget.noteid, updateInfo);
                    Navigator.pop(context);
                    }
                    
                  },
                  child: const Center(
                    child: Text("Update"),
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    onPressed: () {
                      DataBase().deleteNote(widget.noteid);
                      Navigator.pop(context);
                    },
                    child: const Center(child: Text("Delete")))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
