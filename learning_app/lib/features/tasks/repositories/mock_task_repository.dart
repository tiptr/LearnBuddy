import 'package:injectable/injectable.dart';
import 'package:learning_app/features/tasks/dtos/create_task_dto.dart';
import 'package:learning_app/features/tasks/dtos/update_task_dto.dart';
import 'package:learning_app/features/tasks/models/task.dart';
import 'package:learning_app/features/tasks/repositories/task_repository.dart';
import 'package:learning_app/util/database.dart';
import 'package:learning_app/util/injection.dart';
import 'package:mocktail/mocktail.dart';



/// Mock repository implementation
@Environment(Environment.test)
@Injectable(as: TaskRepository)
class MockTaskRepository extends Mock implements TaskRepository{
}
