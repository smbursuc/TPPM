import "dart:convert";
import "dart:io";

Map<String, dynamic> jsonSubJson(String jsonPath1, String jsonPath2) {
  String json1_txt = File(jsonPath1).readAsStringSync();
  String json2_txt = File(jsonPath2).readAsStringSync();
  var json1 = jsonDecode(json1_txt);
  var json2 = jsonDecode(json2_txt);
  Map<String, dynamic> json3 = {};
  Map<String, int> allKeys = {};
  for (String key in json1.keys) {
    if (allKeys.containsKey(key))
      allKeys.update(key, (value) => value + 1);
    else
      allKeys[key] = 1;
  }

  for (String key in json2.keys) {
    if (allKeys.containsKey(key))
      allKeys.update(key, (value) => value + 1);
    else
      allKeys[key] = 1;
  }

  List<String> uncommonKeys = [];

  for (String key in allKeys.keys) {
    if (allKeys[key] == 1) uncommonKeys.add(key);
  }

  for (String key in uncommonKeys) {
    if (json1.containsKey(key)) json3[key] = json1[key];
    if (json2.containsKey(key)) json3[key] = json2[key];
  }

  return json3;
}
