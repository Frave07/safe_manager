import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

part 'generate_password_event.dart';
part 'generate_password_state.dart';

class GeneratePasswordBloc extends Bloc<GeneratePasswordEvent, GeneratePasswordState> {

  final ran = Random();
  final charsAll = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890!"#\$%&/()=?¡¿+{}-¡';
  final charsUppercase = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  final charsLowercase = 'abcdefghijklmnopqrstuvwxyz';
  final charsNumbers = '0123456789';
  final charsSpecial = '!"#\$%&/()=?¡¿+{}-¡';

  GeneratePasswordBloc() : super(const GeneratePasswordState()) {

    on<GeneratePasswordFirstEvent>(_generatePasswordFirst);
    on<GeneratePasswordUppercaseEvent>(_generatePasswordUppercase);
    on<GeneratePasswordLowercaseEvent>(_generatePasswordLowercase);
    on<GeneratePasswordNumbersEvent>(_generatePasswordNumbers);
    on<GeneratePasswordSpecialEvent>(_generatePasswordSpecial);
    on<LengthPasswordEvent>(_lengthPassword);
    on<RefreshPasswordEvent>(_refreshPassword);
    on<CopyPasswordGenerateEvent>(_copyPasswordGenerate);

  }

  
  Future<void> _generatePasswordFirst(GeneratePasswordFirstEvent event, Emitter<GeneratePasswordState> emit) async {

    emit(state.copyWith(password: ''));
  
    final code = List.generate(8, (_) => charsAll[ran.nextInt(charsAll.length)]).join();

    return emit(state.copyWith(password: code));
  }


  Future<void> _generatePasswordUppercase(GeneratePasswordUppercaseEvent event, Emitter<GeneratePasswordState> emit) async {
  
    if(event.isuppercase){

      String chars = charsUppercase;

      state.specialCharacters ? chars += charsSpecial : chars +='';
      state.lowercase ? chars += charsLowercase : chars += '';
      state.numbers ? chars += charsNumbers : chars += '';

      final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

      return emit(state.copyWith(password: code, uppercase: event.isuppercase));
    }

    String chars = '';
    
    state.numbers ? chars += charsNumbers : chars += '';
    state.lowercase ? chars += charsLowercase : chars += '';
    state.specialCharacters ? chars += charsSpecial : chars += '';

    final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

    return emit(state.copyWith(password: code, uppercase: event.isuppercase));
  }


  Future<void> _generatePasswordLowercase(GeneratePasswordLowercaseEvent event, Emitter<GeneratePasswordState> emit) async {
  
    if(event.isLowercase){

      String chars = charsLowercase;

      state.numbers ? chars += charsNumbers : chars += '';
      state.specialCharacters ? chars += charsSpecial : chars += '';
      state.uppercase ? chars += charsUppercase : chars += '';

      final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

      return emit(state.copyWith(password: code, lowercase: event.isLowercase));
    }

    String chars = '';

    state.numbers ? chars += charsNumbers : chars += '';
    state.specialCharacters ? chars += charsSpecial : chars += '';
    state.uppercase ? chars += charsUppercase : chars += '';

    final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

    return emit(state.copyWith(password: code, lowercase: event.isLowercase));
  }


  Future<void> _generatePasswordNumbers(GeneratePasswordNumbersEvent event, Emitter<GeneratePasswordState> emit) async {

    if(event.isNumbers){

      String chars = charsNumbers;

      state.lowercase ? chars += charsLowercase : chars += '';
      state.uppercase ? chars += charsUppercase : chars += '';
      state.specialCharacters ? chars += charsSpecial : chars +='';

      final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

      return emit(state.copyWith(password: code, numbers: event.isNumbers));
    }

    String chars = '';
    
    state.uppercase ? chars += charsUppercase : chars += '';
    state.specialCharacters ? chars += charsSpecial : chars += '';
    state.lowercase ? chars += charsLowercase : chars += '';

    final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

    return emit(state.copyWith(password: code, numbers: event.isNumbers));
  }


  Future<void> _generatePasswordSpecial(GeneratePasswordSpecialEvent event, Emitter<GeneratePasswordState> emit) async {
  
    if(event.isSpecial){

      String chars = charsSpecial;

      state.uppercase ? chars += charsUppercase : chars += '';
      state.lowercase ? chars += charsLowercase : chars += '';
      state.numbers ? chars += charsNumbers : chars += '';

      final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

      return emit(state.copyWith(password: code, specialCharacters: event.isSpecial));
    }

    String chars = '';
    
    state.uppercase ? chars += charsUppercase : chars += '';
    state.lowercase ? chars += charsLowercase : chars += '';
    state.numbers ? chars += charsNumbers : chars += '';

    final code = List.generate(state.length, (_) => chars[ran.nextInt(chars.length)]).join();

    return emit(state.copyWith(password: code, specialCharacters: event.isSpecial));
  }


  Future<void> _lengthPassword(LengthPasswordEvent event, Emitter<GeneratePasswordState> emit) async {

    String chars = '';

    state.lowercase ? chars += charsLowercase : chars += '';
    state.specialCharacters ? chars += charsSpecial : chars +='';
    state.uppercase ? chars += charsUppercase : chars += '';
    state.numbers ? chars += charsNumbers : chars += '';

    final code = List.generate(event.length.toInt(), (_) => chars[ran.nextInt(chars.length)]).join();
  
    return emit(state.copyWith(length: event.length.toInt(), password: code));
  }

  
  Future<void> _refreshPassword(RefreshPasswordEvent event, Emitter<GeneratePasswordState> emit) async {
  
    String chars = '';

    state.lowercase ? chars += charsLowercase : chars += '';
    state.specialCharacters ? chars += charsSpecial : chars +='';
    state.uppercase ? chars += charsUppercase : chars += '';
    state.numbers ? chars += charsNumbers : chars += '';

    final code = List.generate(state.length.toInt(), (_) => chars[ran.nextInt(chars.length)]).join();
  
    return emit(state.copyWith(password: code));
  
  }


  Future<void> _copyPasswordGenerate(CopyPasswordGenerateEvent event, Emitter<GeneratePasswordState> emit) async {
  
    Clipboard.setData(ClipboardData(text: event.password));
  
  }



}
