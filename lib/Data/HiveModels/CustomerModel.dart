import 'package:hive/hive.dart';

part 'CustomerModel.g.dart';

@HiveType(typeId: 0)
class CustomerModel extends HiveObject {
  @HiveField(0)
  late String name;
  @HiveField(1)
  late String mobile;
  @HiveField(2)
  late String email;
  @HiveField(3)
  late String id;
  @HiveField(4)
  late String dob;
  @HiveField(5)
  late String type;
  @HiveField(6)
  late String address;
}
