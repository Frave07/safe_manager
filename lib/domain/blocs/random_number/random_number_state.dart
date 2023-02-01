part of 'random_number_bloc.dart';

@immutable
class RandomNumberState extends Equatable {

  final List<int> listNumberByCreate;


  const RandomNumberState({
    this.listNumberByCreate = const [],
  });


  RandomNumberState copyWith({
    List<int>? listNumberByCreate, 
  }) => RandomNumberState(
    listNumberByCreate: listNumberByCreate ?? this.listNumberByCreate,
  );
  

  @override
  List<Object> get props => [
    listNumberByCreate,
  ];



}
