import 'package:cheking/learning_sqlite/coding_orbit/model/notes.dart';
import 'package:cheking/learning_sqlite/coding_orbit/ui/notes/notes_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../db_helper/db_helpers.dart';

class NotesAddPage extends StatefulWidget {
  final Notes? notes;
  const NotesAddPage({super.key, this.notes});

  @override
  State<NotesAddPage> createState() => _NotesAddPageState();
}

class _NotesAddPageState extends State<NotesAddPage> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.notes != null) {
      titleController.text = widget.notes!.title;
      desController.text = widget.notes!.description;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(child: Text("What are you thinking about?")),
            20.verticalSpace,
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)
                ),
                labelText: "Title"
              ),
            ),
            20.verticalSpace,
            TextFormField(
              controller: desController,
              maxLines: 5,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  labelText: "Title"
              ),
            ),
            20.verticalSpace,
            const Spacer(),
            SizedBox(
              width: double.maxFinite,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  if(titleController.text.isEmpty || desController.text.isEmpty) {
                    return;
                  }
                  final Notes notes = Notes(title: titleController.text, description: desController.text,id: widget.notes?.id);
                  if(widget.notes == null) {
                    await DBHelpers.addNote(notes);
                  } else {

                    print(" ++++++++${notes.id}+++++++${notes.title}++${notes.description}");
                    await DBHelpers.update(notes);
                  }
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const NotesPage(),));
                },
                child: Text("Save"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
