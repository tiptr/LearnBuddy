import 'package:hive/hive.dart';
import 'package:learning_app/services/time_logging/models/time_logging_object.dart';

class TimeLoggingRepository {



  Future<void> initRepository() async {
    await Hive.openBox('TimeLoggingBox');
  }

  void disposeRepository() {
    var box = Hive.box('TimeLoggingBox');
    box.close();
  }

  

  //Sets the duration of id. Does not add the duration!!
  void update(int id, Duration duration)  {
    var box = Hive.box('TimeLoggingBox');
    box.add(TimeLoggingObject(id, duration.inSeconds));
  }

  
  Duration read(int id)  {
    var box = Hive.box('TimeLoggingBox');
    TimeLoggingObject object = box.get(id);
    return Duration(seconds: object.seconds);
  }

}






