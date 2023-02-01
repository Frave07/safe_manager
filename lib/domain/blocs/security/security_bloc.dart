import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_manager/data/secure_storage/local_secure_storage.dart';

part 'security_event.dart';
part 'security_state.dart';

class SecurityBloc extends Bloc<SecurityEvent, SecurityState> {

  SecurityBloc() : super(const SecurityState()) {

    on<SelectNumberVerifyPinEvent>(_selectNumberVerifyPin);
    on<SelectNumberNewPinEvent>(_selectNumberNewPin);
    on<ClearLastNumberVerifyPinEvent>(_clearLastNumberVerifyPin);
    on<ClearLastNumberNewPinEvent>(_clearLastNumberNewPin);
    on<VerifyPinEvent>(_verifyPin);
    on<SaveNewPinEvent>(_saveNewPin);
    on<ClearAllPinEvent>(_clearAllPin);

  }


  Future<void> _selectNumberVerifyPin(SelectNumberVerifyPinEvent event, Emitter<SecurityState> emit) async {
  
    if(state.numbers.length <= 5){

      emit(state.copyWith(numbers: List.of(state.numbers)..add(event.number)));

      if(state.numbers.length == 6){
        await Future.delayed(const Duration(milliseconds: 150));
        add(VerifyPinEvent());
      }
    }
  }


  Future<void> _selectNumberNewPin(SelectNumberNewPinEvent event, Emitter<SecurityState> emit) async {
  
    if(state.newNumbers.length <= 5){

      emit(state.copyWith(newNumbers: List.of(state.newNumbers)..add(event.number)));

      if(state.newNumbers.length == 6){
        await Future.delayed(const Duration(milliseconds: 150));
        add(SaveNewPinEvent());
      }
    }
  
  }


  Future<void> _clearLastNumberVerifyPin(ClearLastNumberVerifyPinEvent event, Emitter<SecurityState> emit) async {
  
    if(state.numbers.isNotEmpty){
      return emit(state.copyWith(
        numbers: List.of(state.numbers)..removeAt(event.index - 1),
        isFailurePassword: false
      ));
    }
  
  }


  Future<void> _clearLastNumberNewPin(ClearLastNumberNewPinEvent event, Emitter<SecurityState> emit) async {
  
    if(state.newNumbers.isNotEmpty){
      return emit(state.copyWith(newNumbers: List.of(state.newNumbers)..removeAt(event.index - 1)));
    }

    if(state.newNumbers.length == 6){
      add(SaveNewPinEvent());
    }
  
  }


  Future<void> _verifyPin(VerifyPinEvent event, Emitter<SecurityState> emit) async {
  
    final pass = await localSecureStorage.readToken();

    final listPass = pass!.replaceAll('[', '').replaceAll(']', '').split(',').map((e) => int.tryParse(e)).toList();

    final isEquals = listEquals(listPass, state.numbers);

    if(isEquals){
      return emit(state.copyWith(
        isSuccessPassword: true, 
        isFailurePassword: false,
        numbers: const [],
        newNumbers: const []
      ));
    }else{
      return emit(state.copyWith(isFailurePassword: true, isSuccessPassword: false));
    }
  
  }


  Future<void> _saveNewPin(SaveNewPinEvent event, Emitter<SecurityState> emit) async {
  
    await localSecureStorage.setToken('${state.newNumbers}');

    return emit(state.copyWith(
      successNewPassword: true,
      isFailurePassword: false,
      isSuccessPassword: false,
      newNumbers: const [],
      numbers: const [],
    ));
  
  }


  Future<void> _clearAllPin(ClearAllPinEvent event, Emitter<SecurityState> emit) async {
  
    return emit(state.copyWith(
      successNewPassword: false,
      isFailurePassword: false,
      isSuccessPassword: false,
      newNumbers: const [],
      numbers: const [],
    ));
  }



}
