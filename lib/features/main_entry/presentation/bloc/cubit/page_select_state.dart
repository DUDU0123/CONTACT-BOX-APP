part of 'page_select_cubit.dart';

class PageSelectState extends Equatable {
  const PageSelectState({
    this.currentIndex = 0,
  });
  final int currentIndex;

  PageSelectState copyWith({
     int? currentIndex,
  }){
    return PageSelectState(currentIndex: currentIndex?? this.currentIndex);
  }

  @override
  List<Object> get props => [currentIndex,];
}

final class PageSelectInitial extends PageSelectState {}
