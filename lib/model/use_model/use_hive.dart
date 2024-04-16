
import 'package:hive/hive.dart';

part 'use_hive.g.dart';
@HiveType(typeId: 1)
class UseHive extends HiveObject {
  UseHive(this.addUse,);

  @HiveField(0)
  String addUse;
}
