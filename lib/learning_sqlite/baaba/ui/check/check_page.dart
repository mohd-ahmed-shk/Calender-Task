import 'package:cheking/learning_sqlite/baaba/db_helper/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CheckPage extends StatefulWidget {
  const CheckPage({super.key});

  @override
  State<CheckPage> createState() => _CheckPageState();
}

class _CheckPageState extends State<CheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("SQLite"),backgroundColor: Colors.green,),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(onPressed: () async {
                await DBHelper.instance.insertRecord({DBHelper.columnName: 'BABA'});

              }, child: const Text("Insert")),
              10.verticalSpace,
              ElevatedButton(onPressed: () async {
                var dbQuery = await  DBHelper.instance.queryRecord();
                print(dbQuery);
              }, child: const Text("Read")),
              10.verticalSpace,
              ElevatedButton(onPressed: () async {
                await DBHelper.instance.deleteRecord(1);

              }, child: const Text("Delete")),
              10.verticalSpace,
              ElevatedButton(onPressed: () async {
                await DBHelper.instance.updateRecord({
                  DBHelper.columnId: 1,
                  DBHelper.columnName: "Ahmed"
                });

              }, child: const Text("Update")),
            ],
          ),
        ),
      ),
    );
  }
}
