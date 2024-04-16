
import 'package:hive/hive.dart';

part 'meeting.g.dart';
@HiveType(typeId: 0)
class Meeting extends HiveObject {
  Meeting(this.amount, this.use, this.date, this.frequency, this.title,this.bank);

  @HiveField(0)
  String amount;
  @HiveField(1)
  DateTime date;
  @HiveField(2)
  String title;
  @HiveField(3)
  String frequency;
  @HiveField(4)
  String use;
  @HiveField(5)
  String bank;
}
