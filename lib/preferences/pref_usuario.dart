import 'package:shared_preferences/shared_preferences.dart';

class PrefUsuario {
  static SharedPreferences?  _prefs;

  static Future<void> init() async{
    _prefs = await SharedPreferences.getInstance();
  }
   String get token {
    if (_prefs == null) {
      throw Exception('SharedPreferences no inicializado. Llama a PrefUsuario.init() primero.');
    }
    return _prefs!.getString('token') ?? '';
  }

  set token(String value) {
    if (_prefs == null) {
      throw Exception('SharedPreferences no inicializado. Llama a PrefUsuario.init() primero.');
    }
    _prefs!.setString('token', value);
  }
  
}