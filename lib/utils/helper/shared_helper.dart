import 'package:shared_preferences/shared_preferences.dart';

class SharedHelper {
  Future<void> setImageList(List<String> image) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList('image', image);
  }
  Future<void> setNameList(List<String> name) async {
    SharedPreferences shr = await SharedPreferences.getInstance();
    await shr.setStringList('name', name);
  }

  Future<List<String>> getNameList() async {
    SharedPreferences shr= await SharedPreferences.getInstance();
    List<String>name= shr.getStringList("name")??[];
    return name;
  }
  Future<List<String>> getImageList() async {
    SharedPreferences shr= await SharedPreferences.getInstance();
    List<String>image= shr.getStringList("image")??[];
    return image;
  }
}

