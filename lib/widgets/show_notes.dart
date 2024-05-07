import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:google_notes/screens/editnote.dart';

Widget showNotes(String searchQuery) {
  return Expanded(
      child: StreamBuilder(
    stream: FirebaseFirestore.instance.collection("Notes").snapshots(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.active) {
        if (snapshot.hasData) {
          final filteredNotes = snapshot.data!.docs.where((note) {
            final noteData = note.data() as Map<String, dynamic>;
            final title = noteData['Title'] as String;
            final noteContent = noteData['Note'] as String;
            return title.toLowerCase().contains(searchQuery.toLowerCase()) ||
                noteContent.toLowerCase().contains(searchQuery.toLowerCase());
          }).toList();

          return MasonryGridView.builder(
            itemCount: filteredNotes.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
             final noteData = filteredNotes[index].data() as Map<String, dynamic>;
  final noteId = filteredNotes[index].id;
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditNote(
                            noteid: noteId,
                            existingTitle: noteData['Title'],
                            existingNote: noteData["Note"]),
                      ));
                },
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                          left: 5, right: 5, bottom: 5, top: 5),
                      padding: const EdgeInsets.all(10),
                      width: MediaQuery.sizeOf(context).width / 2,
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${noteData["Title"]}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${noteData["Note"]}",
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
        return const SizedBox();
      } else {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }
    },
  ));
}
