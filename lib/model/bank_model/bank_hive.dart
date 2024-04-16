
import 'package:hive/hive.dart';

part 'bank_hive.g.dart';
@HiveType(typeId: 2)
class BankHive extends HiveObject {
  BankHive(this.addBank,);

  @HiveField(0)
  String addBank;
}
