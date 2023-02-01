part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class GetPasswordAndStadisticHomeEvent extends HomeEvent {}

class SearchBrowserPasswordEvent extends HomeEvent {
  final String text;
  const SearchBrowserPasswordEvent(this.text);
}

class SearchAppPasswordEvent extends HomeEvent {
  final String text;
  const SearchAppPasswordEvent(this.text);
}

class ClearSearchBrowserPasswordEvent extends HomeEvent {}

class ClearSearchAppPasswordEvent extends HomeEvent {}

class GetCardsHomeEvent extends HomeEvent {}
