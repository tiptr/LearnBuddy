import 'package:bloc/bloc.dart';
import 'package:learning_app/features/leisure/bloc/leisure_category_state.dart';

class LeasureCategoryCubit extends Cubit<LeasureCategoryState> {
  LeasureCategoryCubit() : super(LeasureCategoryState());
}
