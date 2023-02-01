import 'package:encrypt/encrypt.dart' as encrypted;

class EncryptData {

  static String encryptPassword(String password, String token){

    final key = encrypted.Key.fromUtf8(token);

    final iv  = encrypted.IV.fromLength(16);

    final encrypter = encrypted.Encrypter(encrypted.AES(key));

    final encrypt = encrypter.encrypt(password, iv: iv);

    return encrypt.base64;
  }

}