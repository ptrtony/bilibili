import 'dart:convert';

class TestMo {
  String name;
  int count;

  TestMo(this.name, this.count);

  TestMo.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    count = json["count"];
  }

  String toJson(TestMo testMo) {
    Map<String, dynamic> json = Map();
    json["name"] = testMo.name;
    json["count"] = testMo.count;
    return jsonEncode(json);
  }
}
