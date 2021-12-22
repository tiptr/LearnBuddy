import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';

void main() {
  group('when inserting a a TimeLoggingObject', () {
    test('the object is inserted and can be retrived', () async {
      // Arrange
      Hive.init('./test/services/time_logging');
      TimeLoggingRepository repo = TimeLoggingRepository();
      await repo.initRepository();
      repo.insert(3);


      // Act
     var actual = await  repo.read(3);
     var expected = const Duration();
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



