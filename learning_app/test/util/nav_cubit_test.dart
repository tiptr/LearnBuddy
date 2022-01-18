import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:learning_app/constants/page_ids.dart';
import 'package:learning_app/util/nav_cubit.dart';

void main() {
  late NavCubit categoriesCubit;

  setUp(() {
    categoriesCubit = NavCubit();
  });

  group('when the app is initialized', () {
    test('the nav cubit should be initialized with the dashboard page index',
        () {
      // Arrange
      var cubit = NavCubit();

      // Assert
      expect(cubit.state, PageId.dashboard);
    });
  });

  group(
    'when calling navigateTo',
    () {
      blocTest<NavCubit, int>(
        'NavCubit should navigate to the correct page',
        build: () => categoriesCubit,
        seed: () => PageId.dashboard,
        act: (cubit) async => await cubit.navigateTo(PageId.timer),
        expect: () => [PageId.timer],
      );
    },
  );
}
