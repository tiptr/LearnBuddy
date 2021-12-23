import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/services/time_logging/bloc/time_logging_bloc.dart';
import 'package:learning_app/services/time_logging/repository/time_logging_repository.dart';
import 'package:mocktail/mocktail.dart';

class TimeLoggingRepositoryMock extends Mock implements TimeLoggingRepository {}

void main() {
  late TimeLoggingRepository repo;
  late TimeLoggingBloc bloc;

  setUp(() {
    repo = TimeLoggingRepositoryMock();
    bloc = TimeLoggingBloc(repo);
  });


  group('when calling AddTimeLoggingObjectEvent', () {
    blocTest<TimeLoggingBloc, TimeLoggingState>(
      'TimeLoggingObject is active',
      build: () {
        return bloc;
      },
      act: (bloc) {
        bloc.add(const AddTimeLoggingObjectEvent(2));

      },
      expect: () =>  <TimeLoggingState>[TimeLoggingHasObjectState(2)],
    );

  });
  
  group('when AddingTime', () {
    blocTest<TimeLoggingBloc, TimeLoggingState>(
      'Time is added to the id',
      build: () {
        return bloc;
      },
      act: (bloc) {
        bloc.add(const AddTimeLoggingObjectEvent(2));
        bloc.add(const AddDurationEvent(Duration(seconds: 60)));
        bloc.add(const AddDurationEvent(Duration(seconds: 5)));

      },
      expect: () =>  <TimeLoggingState>[TimeLoggingHasObjectState(2)],
      verify: (_) => {
        verify() => 
      },
    );

  });
}
