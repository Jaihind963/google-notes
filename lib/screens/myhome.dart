import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_notes/screens/editnote.dart';
import 'package:google_notes/screens/write_note_page.dart';
import 'package:google_notes/utils/utils.dart';
import 'package:google_notes/widgets/show_notes.dart';
import 'package:iconsax/iconsax.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  TextEditingController noteController = TextEditingController();
  TextEditingController titleController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  final GlobalKey<ScaffoldState> _scoffoldKey = GlobalKey<ScaffoldState>();
  bool notes = false,
      remainder = false,
      label = false,
      archive = false,
      deleted = false,
      setting = false,
      help = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  const Text(
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
                          borderRadius:
                              notes ? BorderRadius.circular(10) : null,
                          color: notes ? Colors.grey.shade300 : null),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
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
                          borderRadius:
                              remainder ? BorderRadius.circular(10) : null,
                          color: remainder ? Colors.grey.shade300 : null),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
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
                          borderRadius:
                              label ? BorderRadius.circular(10) : null,
                          color: label ? Colors.grey.shade300 : null),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
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
                          borderRadius:
                              archive ? BorderRadius.circular(10) : null,
                          color: archive ? Colors.grey.shade300 : null),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
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
                          borderRadius:
                              deleted ? BorderRadius.circular(10) : null,
                          color: deleted ? Colors.grey.shade300 : null),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
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
                          borderRadius:
                              setting ? BorderRadius.circular(10) : null,
                          color: setting ? Colors.grey.shade300 : null),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
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
                          borderRadius: help ? BorderRadius.circular(10) : null,
                          color: help ? Colors.grey.shade300 : null),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      child: const Row(
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
                builder: (context) => const WriteNotes(),
              ),
            );
          },
          child: const Icon(Icons.add_outlined),
        ),
        body: Container(
          margin:
              const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 25),
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
                      icon: const Icon(Icons.menu),
                    ),
                    Expanded(
                      child:  TextField(
                        controller: searchController,
                        onChanged: (value) {
                          setState(() {
                            
                          });
                        },
                        cursorColor: Colors.black45,
                        decoration: InputDecoration(
                            hintText: "Search your notes",
                            border: InputBorder.none),
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const CircleAvatar(
                      backgroundImage: AssetImage("assets/images/profile.jpg"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              showNotes(searchController.text),
            ],
          ),
        ),
      ),
    );
  }
}
