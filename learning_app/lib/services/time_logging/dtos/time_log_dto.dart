import 'package:learning_app/services/time_logging/models/time_log.dart';

class TimeLogDto {
  final int taskId;
  final DateTime beginTime;
  final Duration duration;

  TimeLogDto({
    required this.taskId,
    required this.beginTime,
    required this.duration,
  });


  static TimeLogDto fromTimeLog(TimeLog timeLog){
    return TimeLogDto(
      taskId: timeLog.taskId, 
      beginTime: timeLog.beginTime, 
      duration: timeLog.duration,
      );
  }

}