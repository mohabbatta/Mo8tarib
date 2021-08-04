import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


abstract class SharedAPi{
  static const String onBoarding = "onBoarding";
}
class SharedHelper {

 SharedHelper._();

  static SharedPreferences sharedPreferences;
  static init()async{
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static void putString({@required String key,@required String value})async{
    await sharedPreferences.setString(key, value);
  }
  static String getString({@required String key}){
     return sharedPreferences.getString(key);
  }
  static void putBool({@required String key,@required bool value})async{
    await sharedPreferences.setBool(key, value);
  }
  static bool getBool({@required String key}){
    return sharedPreferences.getBool(key);
  }
}
