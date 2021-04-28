import 'dart:html';

import 'package:shared_preferences/shared_preferences.dart';

///缓存管理类
class HiCache {
  SharedPreferences _prefers;

  HiCache._() {
    init();
  }

  static HiCache _instance;

  static HiCache getInstance() {
    if (_instance == null) {
      _instance = HiCache._();
    }
    return _instance;
  }

  void init() async {
    if (_prefers == null) {
      _prefers = await SharedPreferences.getInstance();
    }
  }

  HiCache._pre(SharedPreferences prefers) {
    this._prefers = prefers;
  }

  ///预处理方法
  static Future<HiCache> preInit() async {
    if (_instance == null) {
      var prefers = await SharedPreferences.getInstance();
      _instance = HiCache._pre(prefers);
    }
    return _instance;
  }

  setString(String key, String value) {
    _prefers.setString(key, value);
  }

  setBool(String key, bool value) {
    _prefers.setBool(key, value);
  }

  setInt(String key, int value) {
    _prefers.setInt(key, value);
  }

  setDouble(String key,double value){
    _prefers.setDouble(key, value);
  }

  setStringList(String key, List<String> value) {
    _prefers.setStringList(key, value);
  }

  T get<T>(String key) {
    return _prefers.get(key);
  }
}
