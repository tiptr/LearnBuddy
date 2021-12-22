import 'package:hive/hive.dart';


part 'time_logging_object.g.dart';

@HiveType(typeId: 0)
class TimeLoggingObject extends HiveObject {

  TimeLoggingObject(this.id, this.seconds);

  @HiveField(0)
  int id;

  @HiveField(1)
  int seconds;


  @override
  String toString() {
    return '$id, $seconds';
    
  }
}
