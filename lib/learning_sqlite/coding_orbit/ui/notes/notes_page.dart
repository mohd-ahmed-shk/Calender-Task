import 'package:cheking/learning_sqlite/coding_orbit/db_helper/db_helpers.dart';
import 'package:cheking/learning_sqlite/coding_orbit/model/notes.dart';
import 'package:cheking/learning_sqlite/coding_orbit/ui/notes/notes_add_page.dart';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple.withOpacity(0.5),
      appBar: AppBar(title: const Text("Notes"),centerTitle: true,backgroundColor: Colors.blue,),
      body: FutureBuilder<List<Notes>?>(
        future: DBHelpers.getAllNotes(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive(),);
          } else if(snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()),);
          } else if(snapshot.hasData) {
            if(snapshot.data != null) {
              return ListView.builder(itemCount: snapshot.data?.length ?? 0,itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => NotesAddPage(notes: snapshot.data?[index],),));

                  },
                  onLongPress: () {
                    DBHelpers.delete( snapshot.data![index]);
                    setState(() {
                      
                    });

                  },
                  child: Padding(padding: const EdgeInsets.all(10),
                  child: Card(

                    color: Colors.white,
                    shape: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(snapshot.data?[index].title ?? ""),
                          const Divider(endIndent: 10,indent: 10,),
                          Text(snapshot.data?[index].description ?? "")
                        ],
                      ),
                    ),
                  ),),
                );
              },);
            } else {
              return const Center(child: Text("Error-1"),);
            }
          } else {
            return  const Center(child: Text("No DATA"),);
          }
        },

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => NotesAddPage(),));
        },
      ),
    );
  }
}
