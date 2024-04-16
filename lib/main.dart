import 'package:cheking/learning_sqlite/baaba/ui/check/check_page.dart';
import 'package:cheking/learning_sqlite/ui/note_list/note_list_page.dart';
import 'package:cheking/model/bank_model/bank_hive.dart';
import 'package:cheking/model/meeting.dart';
import 'package:cheking/model/use_model/use_hive.dart';
import 'package:cheking/ui/home/home_page.dart';
import 'package:cheking/using_sqlite/calender_home/calender_home_page.dart';
import 'package:cheking/using_sqlite/model/calender_model/calender_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hive_flutter/adapters.dart';

import 'learning_sqlite/coding_orbit/ui/notes/notes_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MeetingAdapter());
  Hive.registerAdapter(UseHiveAdapter());
  Hive.registerAdapter(BankHiveAdapter());

  await Hive.openBox<Meeting>('meeting');
  await Hive.openBox<UseHive>('use');
  await Hive.openBox<BankHive>('bank');

  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_ , child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: child,
        );
      },
      child: const CalenderHomePage(),
    );
  }
}

List<Meeting> meetings = <Meeting>[];

// SQLite is an in-process library that implements a self-contained, serverless, zero-configuration, transaction SQL database engine
// self-contained - Minimal support from external libraries
// Serverless - Reads and writes directly from the database files on disk
// Zero-configuration - No installation, no setup
// Transaction - All changes in a transaction occur completely or not at all



// SQLite plugins saves map objects to your SQLite database
// SQLite plugins retrieve map objects from SQLite database


// it deals with map objects only
