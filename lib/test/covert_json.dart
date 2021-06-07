


import 'dart:collection';
import 'dart:convert';


class covertDemo{

  String fromJsonMethod(){
    Map<String,dynamic> map = new Map();
    map["username"] = "ptrtony";
    map["age"] = 27;
    String json = fromJson(map);
    print(json);
    return json;
  }

  void toJsonMethod(){
    Map<String,dynamic> map= toJson(fromJsonMethod());
    print(map);
  }
}

fromJson(Map<String,dynamic> maps){
  return jsonEncode(maps);
}

toJson(String json){
  return jsonDecode(json);
}