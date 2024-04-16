import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotesDetailsPage extends StatefulWidget {
  final String title;
  const NotesDetailsPage({super.key, required this.title});

  @override
  State<NotesDetailsPage> createState() => _NotesDetailsPageState();
}

class _NotesDetailsPageState extends State<NotesDetailsPage> {
  static final List<String> _priorities = ['High', 'Low'];
  String selectedValue = _priorities.elementAt(0);

  final titleController = TextEditingController();
  final desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.titleMedium;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ListTile(
              title: DropdownButton(
                value: selectedValue,
                items: _priorities.map((e) {
                  return DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  );
                }).toList(),
                style: textStyle,
                onChanged: (value) {
                  setState(() {
                    selectedValue = value!;
                  });
                },
              ),
            ),
            TextFormField(
              controller: titleController,
              onChanged: (value) {},
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Enter Title'),
              style: textStyle,
            ),
            10.verticalSpace,
            TextFormField(
              controller: desController,
              onChanged: (value) {},
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5)),
                  hintText: 'Enter Description'),
              style: textStyle,
            ),
            10.verticalSpace,
            Row(
              children: [
                Expanded(
                    child: ElevatedButton(
                  child: const Text('Save'),
                  onPressed: () {},
                )),
                10.horizontalSpace,
                Expanded(
                    child: ElevatedButton(
                      child: const Text('Delete'),
                      onPressed: () {},
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }
}
