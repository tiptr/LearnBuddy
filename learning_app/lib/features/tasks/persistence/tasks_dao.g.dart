// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tasks_dao.dart';

// **************************************************************************
// DaoGenerator
// **************************************************************************

mixin _$TasksDaoMixin on DatabaseAccessor<Database> {
  Tasks get tasks => attachedDatabase.tasks;
  Selectable<Task> getAll() {
    return customSelect('SELECT * FROM tasks', variables: [], readsFrom: {
      tasks,
    }).map(tasks.mapFromRow);
  }

  Selectable<Task> getById(int id) {
    return customSelect('SELECT * FROM tasks WHERE id = :id', variables: [
      Variable<int>(id)
    ], readsFrom: {
      tasks,
    }).map(tasks.mapFromRow);
  }

  Future<int> createEntry(String title) {
    return customInsert(
      'INSERT INTO tasks (title) VALUES (:title)',
      variables: [Variable<String>(title)],
      updates: {tasks},
    );
  }

  Future<int> deleteById(int id) {
    return customUpdate(
      'DELETE FROM tasks WHERE id = :id',
      variables: [Variable<int>(id)],
      updates: {tasks},
      updateKind: UpdateKind.delete,
    );
  }

  Future<int> toggleDoneById(int id) {
    return customUpdate(
      'UPDATE tasks SET done = (not done) WHERE id = :id',
      variables: [Variable<int>(id)],
      updates: {tasks},
      updateKind: UpdateKind.update,
    );
  }
}
