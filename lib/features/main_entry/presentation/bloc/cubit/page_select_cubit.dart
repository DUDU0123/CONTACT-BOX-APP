import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'page_select_state.dart';

class PageSelectCubit extends Cubit<PageSelectState> {
  PageSelectCubit() : super(PageSelectInitial());

  void selectIndex({required int selectedIndex}){
    emit(state.copyWith(currentIndex: selectedIndex));
  }
}
