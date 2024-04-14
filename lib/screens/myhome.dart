import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_notes/screens/editnote.dart';
import 'package:google_notes/screens/write_note_page.dart';
import 'package:iconsax/iconsax.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  final GlobalKey<ScaffoldState> _scoffoldKey = GlobalKey<ScaffoldState>();
  bool notes = false, remainder = false, label = false, archive = false, deleted = false, setting = false, help = false;
  Widget showNotes() {
    return Expanded(
        child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          if (snapshot.hasData) {
            return GridView.builder(
              itemCount: snapshot.data!.docs.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
              ),
              itemBuilder: (context, index) {
                Map<String, dynamic> userMap =
                    snapshot.data!.docs[index].data();
                String noteId = snapshot.data!.docs[index].id;
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditNote(
                              noteid: noteId,
                              existingTitle: userMap['Title'],
                              existingNote: userMap["Note"]),
                        ));
                  },
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.sizeOf(context).width / 2,
                        decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${userMap["Title"]}",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${userMap["Note"]}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            );
          }
          return SizedBox();
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "  Google Keep",
                  style: TextStyle(fontSize: 22),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      notes = true;
                      remainder = false;
                      label = false;
                      archive = false;
                      deleted = false;
                      setting = false;
                      help = false;
                    });
                  },
                  child: Container(
                    
                    decoration: BoxDecoration(
                      
                      borderRadius: notes? BorderRadius.circular(10): null,
                      color: notes? Colors.grey.shade300 : null
                    ),
                    margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.note_add_outlined),
                        Text("  Notes"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                       notes = false;
                      remainder = true;
                      label = false;
                      archive = false;
                      deleted = false;
                      setting = false;
                      help = false;
                    });
                  },
                  child: Container(
                     decoration: BoxDecoration(
                      
                      borderRadius: remainder? BorderRadius.circular(10): null,
                      color: remainder? Colors.grey.shade300 : null
                    ),
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.timer_outlined),
                        Text("  Remainder"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                     setState(() {
                       notes = false;
                      remainder = false;
                      label = true;
                      archive = false;
                      deleted = false;
                      setting = false;
                      help = false;
                    });
                  },
                  child: Container(
                     decoration: BoxDecoration(
                        
                        borderRadius: label? BorderRadius.circular(10): null,
                        color: label? Colors.grey.shade300 : null
                      ),
                    margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.label_outlined),
                        Text("  Create new label"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                     setState(() {
                       notes = false;
                      remainder = false;
                      label = false;
                      archive = true;
                      deleted = false;
                      setting = false;
                      help = false;
                    });
                  },
                  child: Container(
                     decoration: BoxDecoration(
                        
                        borderRadius: archive? BorderRadius.circular(10): null,
                        color: archive? Colors.grey.shade300 : null
                      ),
                    margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.archive_outlined),
                        Text("  Archive"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                     setState(() {
                       notes = false;
                      remainder = false;
                      label = false;
                      archive = false;
                      deleted = true;
                      setting = false;
                      help = false;
                    });
                  },
                  child: Container(
                     decoration: BoxDecoration(
                        
                        borderRadius: deleted? BorderRadius.circular(10): null,
                        color: deleted? Colors.grey.shade300 : null
                      ),
                    margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.delete_outline_outlined),
                        Text("  Deleted"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                     setState(() {
                       notes = false;
                      remainder = false;
                      label = false;
                      archive = false;
                      deleted = false;
                      setting = true;
                      help = false;
                    });
                  },
                  child: Container(
                     decoration: BoxDecoration(
                        
                        borderRadius: setting? BorderRadius.circular(10): null,
                        color: setting? Colors.grey.shade300 : null
                      ),
                    margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined),
                        Text("  Setting"),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                   setState(() {
                       notes = false;
                      remainder = false;
                      label = false;
                      archive = false;
                      deleted = false;
                      setting = false;
                      help = true;
                    });
                  },
                  child: Container(
                     decoration: BoxDecoration(
                        
                        borderRadius: help? BorderRadius.circular(10): null,
                        color: help? Colors.grey.shade300 : null
                      ),
                    margin: EdgeInsets.all(10),
                     padding: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Icon(Iconsax.message_question),
                        Text("  Help & feedback"),
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
      key: _scoffoldKey,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey.shade300,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => WriteNotes(),
            ),
          );
        },
        child: Icon(Icons.add_outlined),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 55, left: 10, right: 10),
        child: Column(
          children: [
            Container(
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      _scoffoldKey.currentState!.openDrawer();
                    },
                    icon: Icon(Icons.menu),
                  ),
                  Text(
                    "Search your notes",
                    style: TextStyle(fontSize: 18),
                  ),
                  Spacer(),
                  CircleAvatar(
                    backgroundImage: AssetImage("assets/images/profile.jpg"),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              ),
            ),
            showNotes()
          ],
        ),
      ),
    );
  }
}
