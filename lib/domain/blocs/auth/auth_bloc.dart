
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:safe_manager/data/secure_storage/local_secure_storage.dart';
import 'package:safe_manager/domain/models/password_model.dart';

import '../../models/card_model/card_model.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  AuthBloc() : super(const AuthState()) {

    on<VerifyAccountEvent>(_verifyAccount);
    on<SelectNumberEvent>(_selectNumber);
    on<ClearLastNumberEvent>(_clearLastNumber);
    on<ClearAllNumbersEvent>(_clearAllNumbers);
    on<VerifyPasswordEvent>(_verifyPassword);
    on<VerifyAccountForDeleteEvent>(_verifyAccountForDelete);
    on<ClearAllEvent>(_clearAll);

  }


  Future<void> _verifyAccount(VerifyAccountEvent event, Emitter<AuthState> emit) async {
  
    if(await localSecureStorage.readToken() != null){
      return emit(state.copyWith(
        existAccount: true
      ));
    }

    return emit(state.copyWith(
      existAccount: false
    ));
  
  }


  Future<void> _selectNumber(SelectNumberEvent event, Emitter<AuthState> emit) async {
  
    if(state.numbers.length <= 5){
      return emit(state.copyWith(numbers: List.of(state.numbers)..add(event.number)));
    }
  
  }


  Future<void> _clearLastNumber(ClearLastNumberEvent event, Emitter<AuthState> emit) async {
  
    if(state.numbers.isNotEmpty){
      return emit(state.copyWith(
        numbers: List.of(state.numbers)..removeAt(event.index - 1),
        isFailPassword: false
      ));
    }
  
  }


  Future<void> _clearAllNumbers(ClearAllNumbersEvent event, Emitter<AuthState> emit) async {
  
    return emit(state.copyWith(numbers: []));
  
  }


  Future<void> _verifyPassword(VerifyPasswordEvent event, Emitter<AuthState> emit) async {
  
    final pass = await localSecureStorage.readToken();

    final listPass = pass!.replaceAll('[', '').replaceAll(']', '').split(',').map((e) => int.tryParse(e)).toList();

    final isEquals = listEquals(listPass, state.numbers);

    if(isEquals){
      return emit(state.copyWith(isSuccessPassword: true, isFailPassword: false));
    }else{
      return emit(state.copyWith(isFailPassword: true, isSuccessPassword: false));
    }
  
  }


  Future<void> _verifyAccountForDelete(VerifyAccountForDeleteEvent event, Emitter<AuthState> emit) async {
  
    final pass = await localSecureStorage.readToken();

    final listPass = pass!.replaceAll('[', '').replaceAll(']', '').split(',').map((e) => int.tryParse(e)).toList();

    final isEquals = listEquals(listPass, state.numbers);

    if(isEquals){
      await localSecureStorage.deleteSecureStorage();
      return emit(state.copyWith(isSuccessPassword: true, isFailPassword: false, existAccount: false, numbers: []));
    }else{
      return emit(state.copyWith(isFailPassword: true, isSuccessPassword: false));
    }
  
  }


  Future<void> _clearAll(ClearAllEvent event, Emitter<AuthState> emit) async {

    await localSecureStorage.deleteSecureStorage();

    await Hive.box<CardModel>('encrypt-card-wallet-fraved').deleteFromDisk();

    await Hive.box<PasswordModel>('encrypt-password-fraved').deleteFromDisk();
  
    return emit(const AuthState());
  }



}
