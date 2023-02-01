
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalSecureStorage {

  final secureStorage = const FlutterSecureStorage();

  // WRITE STORAGE

  Future<void> setToken(String token) async {
    await secureStorage.write(key: 'xxx_token', value: token);
  }
  
  Future<void> setTokenEncrypt(String token) async {
    await secureStorage.write(key: 'fraved_token_encrypt', value: token);
  }


  // READ STORAGE
  Future<String?> readToken() async {
    return await secureStorage.read(key: 'xxx_token');
  }

  Future<String?> readTokenEncrypt() async {
    return await secureStorage.read(key: 'fraved_token_encrypt');
  }


  // DELETE ALL STORAGE
  Future<void> deleteSecureStorage() async {
    await secureStorage.delete(key: 'xxx_token');
    await secureStorage.delete(key: 'fraved_token_encrypt');
  }


}

final localSecureStorage = LocalSecureStorage();