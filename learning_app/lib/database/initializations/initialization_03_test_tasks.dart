import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:learning_app/features/tasks/persistence/tasks_dao.dart';
import 'package:learning_app/util/injection.dart';

Future<void> initialization03TestTasks() async {
  // TODO: implement this when working on the associated issue

  var dao = getIt<TasksDao>();
  dao.createEntry("MyTitle");
  dao.createEntry("MyTitle1");
  dao.createEntry("MyTitle2");
  dao.createEntry("MyTitle3");

  // Example code for inspiration:
  // final workId = await into(categories)
  //     .insert(const CategoriesCompanion(description: Value('Work')));
  //
  // await into(todos).insert(TodosCompanion(
  //   content: const Value('A first todo entry'),
  //   targetDate: Value(DateTime.now()),
  // ));
  //
  // await into(todos).insert(
  //   TodosCompanion(
  //     content: const Value('Rework persistence code'),
  //     category: Value(workId),
  //     targetDate: Value(
  //       DateTime.now().add(const Duration(days: 4)),
  //     ),
  //   ),
  // );
}
