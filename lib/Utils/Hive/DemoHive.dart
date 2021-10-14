import 'package:hive/hive.dart';

part 'DemoHive.g.dart';

@HiveType(typeId: 0)
class DemoHive extends HiveObject{
  @HiveField(0)
  late String demo;
  @HiveField(1)
  late String model;
}

