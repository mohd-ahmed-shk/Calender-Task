import 'package:cheking/learning_sqlite/ui/notes_details/notes_details_page.dart';
import 'package:flutter/material.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({super.key});

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes"),backgroundColor: const Color(0xff456433),),
      backgroundColor: const Color(0xffe3ecdf),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(itemCount: 10,itemBuilder: (context, index) {
          return Card(
            child: ListTile(
              leading: CircleAvatar(),
              title: Text(""),
              trailing: Icon(Icons.delete),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotesDetailsPage(title: "Edit Page",),));
              },
            ),
          );
        },),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const NotesDetailsPage(title: "Add Page",),));

        },
        shape: OutlineInputBorder(borderRadius: BorderRadius.circular(100),borderSide: BorderSide.none),
        elevation: 0,
        backgroundColor: const Color(0xff456433),
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
