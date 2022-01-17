import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:learning_app/constants/page_ids.dart';

class NavCubit extends Cubit<int> {
  NavCubit() : super(PageId.dashboard);

  Future<void> navigateTo(int pageId) async {
    emit(pageId);
  }
}
