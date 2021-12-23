import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/services/time_logging/models/time_logging_object.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';

void main() {
  group('when inserting a a TimeLoggingObject', () {
    test('the object is inserted and can be retrived', () async {
      // Arrange
      Hive.init('./test/services/time_logging');
      Hive.registerAdapter(TimeLoggingObjectAdapter());
      TimeLoggingRepository repo = TimeLoggingRepository();
      await repo.initRepository();
      repo.update(0, const Duration(seconds: 30));


      // Act
     var actual =  repo.read(0);
     var expected = const Duration(seconds: 30);
     expect(actual, expected);
    });

    test('Duration can be overwritten', () async {
      // Arrange
      Hive.init('./test/services/time_logging');
      Hive.registerAdapter(TimeLoggingObjectAdapter());
      TimeLoggingRepository repo = TimeLoggingRepository();
      await repo.initRepository();
      repo.update(3, const Duration(seconds: 30));
      repo.update(3, const Duration(minutes: 2));

      // Act
     var actual =  repo.read(3);
     var expected = const Duration(minutes: 2);
     expect(actual, expected);
    });
  });

  group('when using Hive', () {
    test('Hive works', () async {
      // Arrange
      Hive.init('./test/services/time_logging');
      var box = await Hive.openBox('testBox');

      box.put('name', 'David');
      
      print('Name: ${box.get('name')}');
    });
  });
  
}


