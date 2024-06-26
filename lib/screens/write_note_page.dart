import 'package:flutter/material.dart';
import 'package:google_notes/services/database.dart';

class WriteNotes extends StatefulWidget {
  const WriteNotes({super.key});

  @override
  State<WriteNotes> createState() => _WriteNotesState();
}

class _WriteNotesState extends State<WriteNotes> {
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();
final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_alert_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.add_alert_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.save_outlined),
            ),
          ],
        ),
      ),
      body: Form(
        key: formKey,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                      return "Flied required";
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
                    if(formKey.currentState!.validate()){
                      formKey.currentState!.save();
                      Map<String, dynamic> noteInfo = {
                      "Title": titleController.text.trim(),
                      "Note": noteController.text.trim(),
                    };
                    await DataBase().addNote(noteInfo).then((value) {
                      Navigator.pop(context);
                    });
                    }
                    
                  },
                  child: const Center(child: Text("Save")),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
