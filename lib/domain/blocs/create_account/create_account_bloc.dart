import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:safe_manager/data/secure_storage/local_secure_storage.dart';

part 'create_account_event.dart';
part 'create_account_state.dart';

class CreateAccountBloc extends Bloc<CreateAccountEvent, CreateAccountState> {

  CreateAccountBloc() : super(const CreateAccountState()) {

    on<SelectNumberByCreateAccountEvent>(_selectNumberByCreateAccount);
    on<ClearLastNumberByCreateAccountEvent>(_clearLastNumberByCreateAccount);
    on<ResetValuesCreateAccountEvent>(_resetValuesCreateAccount);
    on<SelectNumberRepeatByCreateAccountEvent>(_selectNumberRepeatByCreateAccount);
    on<ClearLastNumberRepeatByCreateAccountEvent>(_clearLastNumberRepeatByCreateAccount);
    on<ClearNumberRepeatByCreateAccountEvent>(_clearNumberRepeatByCreateAccount);

    on<VerifyPasswordsByCreateAccountEvent>(_verifyPasswordsByCreateAccount);

  }


  Future<void> _selectNumberByCreateAccount(SelectNumberByCreateAccountEvent event, Emitter<CreateAccountState> emit) async {
    

    if(state.numbersCreate.length <= 5){
      return emit(state.copyWith(numbersCreate: List.of(state.numbersCreate)..add(event.number)));
    }
  
  }


  Future<void> _clearLastNumberByCreateAccount(ClearLastNumberByCreateAccountEvent event, Emitter<CreateAccountState> emit) async {
  
    if(state.numbersCreate.isNotEmpty){
      return emit(state.copyWith(numbersCreate: List.of(state.numbersCreate)..removeAt(event.index - 1)));
    }
  
  }


  Future<void> _resetValuesCreateAccount(ResetValuesCreateAccountEvent event, Emitter<CreateAccountState> emit) async {
  
    return emit(state.copyWith(numbersCreate: []));
  
  }


  // REPEAT PASSWORD 
  Future<void> _selectNumberRepeatByCreateAccount(SelectNumberRepeatByCreateAccountEvent event, Emitter<CreateAccountState> emit) async {
  
    if(state.verifyNumbersCreate.length <= 5){
      return emit(state.copyWith(verifyNumbersCreate: List.of(state.verifyNumbersCreate)..add(event.number)));
    }
  
  }


  Future<void> _clearLastNumberRepeatByCreateAccount(ClearLastNumberRepeatByCreateAccountEvent event, Emitter<CreateAccountState> emit) async {
  
    if(state.verifyNumbersCreate.isNotEmpty){
      return emit(state.copyWith(
        verifyNumbersCreate: List.of(state.verifyNumbersCreate)..removeAt(event.index - 1),
        isFailurePassword: false
      ));
    }
  
  }


  Future<void> _clearNumberRepeatByCreateAccount(ClearNumberRepeatByCreateAccountEvent event, Emitter<CreateAccountState> emit) async {
  
    return emit(state.copyWith(verifyNumbersCreate: []));
  
  }


  // Verify Passwords
  Future<void> _verifyPasswordsByCreateAccount(VerifyPasswordsByCreateAccountEvent event, Emitter<CreateAccountState> emit) async {

    if(state.numbersCreate.isNotEmpty && state.verifyNumbersCreate.isNotEmpty){

      final isEquals = listEquals(state.numbersCreate, state.verifyNumbersCreate);

      if(isEquals){
        await localSecureStorage.setToken('${state.verifyNumbersCreate}');

        final ran = Random();

        const char = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';

        String code = List.generate(22, (_) => char[ran.nextInt(char.length)]).join();

        await localSecureStorage.setTokenEncrypt(code+='+=');

        return emit(state.copyWith(isSuccessCreateAccount: true, isFailurePassword: false));
      }else{
        return emit(state.copyWith(isFailurePassword: true, isSuccessCreateAccount: false));
      }

    }
  
  }




}
