import 'dart:ui';
import 'package:shared_preferences/shared_preferences.dart';
import 'language.dart';

class languageControler{

   Future<Locale> SetLocale(String langCode) async{
    SharedPreferences _shard=await SharedPreferences.getInstance();
    await _shard.setString("langCode",langCode);

   return _locale(langCode);
  }

  Locale _locale (String langCode){

    Locale _temp;
    switch(langCode){
      case "en":_temp=Locale(langCode, 'UK');break;
      case "ar":_temp=Locale(langCode, 'SA');break;
      case "fr":_temp=Locale(langCode);break;
      default:_temp=Locale(langCode, 'UK');
    }
    return _temp;
  }
  Future<Locale> getLocale() async{
    SharedPreferences _shard=await SharedPreferences.getInstance();
    String langCode= _shard.getString("langCode")??"en";
   return _locale(langCode);

  }
}