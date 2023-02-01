part of 'general_bloc.dart';

abstract class GeneralEvent extends Equatable {
  const GeneralEvent();

  @override
  List<Object> get props => [];
}

class SearchLogoEvent extends GeneralEvent {
  final String text;
  const SearchLogoEvent(this.text);
}

class ClearSearchListLogoEvent extends GeneralEvent {}

class IsShowPasswordVaultEvent extends GeneralEvent {
  final bool isShow;
  const IsShowPasswordVaultEvent(this.isShow);
}

