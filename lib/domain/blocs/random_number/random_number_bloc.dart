import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'random_number_event.dart';
part 'random_number_state.dart';

class RandomNumberBloc extends Bloc<RandomNumberEvent, RandomNumberState> {


  RandomNumberBloc() : super(const RandomNumberState()) {

    on<GenerateRandomNumberCreateEvent>(_generateRandomNumberCreate);


  }


  Future<void> _generateRandomNumberCreate(GenerateRandomNumberCreateEvent event, Emitter<RandomNumberState> emit) async {
    
    emit(state.copyWith(listNumberByCreate: []));

    List<int> list = [1,2,3,4,5,6,7,8,9,0];

    list.shuffle();

    return emit(state.copyWith(listNumberByCreate: list));
  }




}
