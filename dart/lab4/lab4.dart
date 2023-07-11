import 'dart:io';
import "ex4.dart";

List<String>? ex1(String string, List<String> regex) {
  List<String> result = [];
  for (int i = 0; i < regex.length; i++) {
    RegExp exp = new RegExp(regex[i]);
    Iterable<Match> matches = exp.allMatches(string);
    for (Match m in matches) {
      result.add(m.group(0)!);
    }
  }
  return result;
}

class Stack {
  String _file_name;
  Stack(String f_name) : _file_name = f_name {}

  void push(String s) {
    File file = new File(_file_name);
    List<String> lines = file.readAsLinesSync();
    lines.insert(0, s);
    file.writeAsStringSync(lines.join('\n'), flush: true);
  }

  String? pop() {
    File file = new File(_file_name);
    List<String> lines = file.readAsLinesSync();
    if (lines.isEmpty) {
      return null;
    }
    String first = lines.first;
    lines.removeAt(0);

    file.writeAsStringSync(lines.join('\n'), flush: true);
    return first;
  }

  String? peek() {
    File file = new File(_file_name);
    List<String> lines = file.readAsLinesSync();
    if (lines.isEmpty) {
      return null;
    }
    return lines.first;
  }
}

class MathOps<T, G> {
  void check(T obj1, G obj2) {
    if (obj1.runtimeType.toString() != "int" &&
        obj1.runtimeType.toString() != "double" &&
        obj1.runtimeType.toString() != "String") {
      throw Exception("Type not supported");
    }

    if (obj2.runtimeType.toString() != "int" &&
        obj2.runtimeType.toString() != "double" &&
        obj2.runtimeType.toString() != "String")
      throw Exception("Type not supported");

    if (obj1.runtimeType.toString() == "String" &&
            obj2.runtimeType.toString() != "String" ||
        obj1.runtimeType.toString() != "String" &&
            obj2.runtimeType.toString() == "String")
      throw Exception("Can't subtract these types");
  }

  int sub(T obj1, G obj2) {
    check(obj1, obj2);
    if (obj1.runtimeType.toString() == "String" &&
        obj2.runtimeType.toString() == "String") {
      return obj1.toString().length - obj2.toString().length;
    }

    double obj1_int = double.parse(obj1.toString());
    double obj2_int = double.parse(obj2.toString());
    return (obj1_int - obj2_int).toInt();
  }

  int prod(T obj1, G obj2) {
    check(obj1, obj2);
    if (obj1.runtimeType.toString() == "String" &&
        obj2.runtimeType.toString() == "String") {
      return obj1.toString().length * obj2.toString().length;
    }

    double obj1_int = double.parse(obj1.toString());
    double obj2_int = double.parse(obj2.toString());
    return (obj1_int * obj2_int).toInt();
  }

  int mod(T obj1, G obj2) {
    check(obj1, obj2);
    if (obj1.runtimeType.toString() == "String" &&
        obj2.runtimeType.toString() == "String") {
      return obj1.toString().length % obj2.toString().length;
    }

    double obj1_int = double.parse(obj1.toString());
    double obj2_int = double.parse(obj2.toString());
    return (obj1_int % obj2_int).toInt();
  }
}

void main() {
  List<String> regex = ["[a-z]+", "[A-Z]+", "[0-9]+"];
  List<String>? res_ex1 =
      ex1("Astazi am fost la mare. Data este 16 Martie 2023.", regex);
  print(res_ex1);

  Stack s = new Stack("stack.txt");
  s.push("1");
  s.push("2");
  s.push("3");
  print(s.pop());
  print(s.peek());

  MathOps<int, int> mathOps = new MathOps<int, int>();
  print(mathOps.sub(5, 3));

  MathOps<double, double> mathOps2 = new MathOps<double, double>();
  print(mathOps2.sub(5.5, 3.3));

  MathOps<int, double> mathOps3 = new MathOps<int, double>();
  print(mathOps3.sub(5, 3.0));

  print(jsonSubJson("json1.json", "json2.json"));
}
