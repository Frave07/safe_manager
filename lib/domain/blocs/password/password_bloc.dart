import 'package:bloc/bloc.dart';
import 'package:encrypt/encrypt.dart' as encrypted;
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:safe_manager/data/icons/icons.dart';
import 'package:safe_manager/data/secure_storage/encrypt_data.dart';
import 'package:safe_manager/data/secure_storage/local_secure_storage.dart';
import 'package:safe_manager/domain/models/password_model.dart';
import 'package:uuid/uuid.dart';

part 'password_event.dart';
part 'password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {

  PasswordBloc() : super(const PasswordState()) {

    on<SelectTypePasswordEvent>(_selectTypePassword);
    on<SelectIconLogoPasswordEvent>(_selectIconLogoPassword);
    on<ClearIconPasswordEvent>(_clearIconPassword);
    on<SavePasswordEvent>(_savePassword);
    on<CopyPasswordEvent>(_copyPassword);
    on<DeletePasswordEvent>(_deletePassword);

  }


  Future<void> _selectTypePassword(SelectTypePasswordEvent event, Emitter<PasswordState> emit) async {
  
    return emit(state.copyWith(typePassword: event.type));
  
  }
  

  Future<void> _selectIconLogoPassword(SelectIconLogoPasswordEvent event, Emitter<PasswordState> emit) async {
  
    return emit(state.copyWith(iconLogo: event.logo));
  
  }


  Future<void> _clearIconPassword(ClearIconPasswordEvent event, Emitter<PasswordState> emit) async {
  
    return emit(state.copyWith(iconLogo: null));
  
  }


  Future<void> _savePassword(SavePasswordEvent event, Emitter<PasswordState> emit) async {
    
    final token = await localSecureStorage.readTokenEncrypt();

    final encryptPass = EncryptData.encryptPassword(event.password, token!);

    final box = Hive.box<PasswordModel>('encrypt-password-fraved');

    const uuid = Uuid();

    final newPass = PasswordModel(
      uid: uuid.v4(), 
      nickname: event.nickname, 
      type: event.type, 
      pathLogo: event.logo, 
      password: encryptPass,
      email: event.email,
      website: event.website ?? '',
      isFavorite: false,
      date: DateTime.now()
    );

    box.add(newPass);

    return emit(SuccessCreatePasswordStatus());
  }


  Future<void> _copyPassword(CopyPasswordEvent event, Emitter<PasswordState> emit) async {

    final token = await localSecureStorage.readTokenEncrypt();

    final iv  = encrypted.IV.fromLength(16);
    
    final encrypter = encrypted.Encrypter(encrypted.AES(encrypted.Key.fromUtf8('$token')));

    final decrypted = encrypter.decrypt(encrypted.Encrypted.fromBase64(event.password.password), iv: iv);
    
    Clipboard.setData(ClipboardData(text: decrypted));
  }


  Future<void> _deletePassword(DeletePasswordEvent event, Emitter<PasswordState> emit) async {
  
    final box = Hive.box<PasswordModel>('encrypt-password-fraved');
    box.deleteAt(event.index);

    return emit(SuccessFailurePasswordStatus());
  }



}
