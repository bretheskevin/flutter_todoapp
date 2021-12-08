import "package:flutter/material.dart";
import "package:todo_app/models/todo.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";

class TodoProvider with ChangeNotifier {

  int _count = 0;
  final List<Todo> _todos = [];

  int get count => _count;
  List<Todo> get todos => _todos;

  void _incrementCount() {
    _count++;
  }

  void addTodo(String content) {
    if (content.isNotEmpty) {
      _todos.add(Todo(_count, content));
      _incrementCount();
      setLocalData();
      notifyListeners();
    }
  }

  Future<void> removeTodo(int id) async {
    _todos.removeWhere((item) => item.id == id);
    setLocalData();
    notifyListeners();
  }


  void initTodo(List<dynamic> localList) {
    for (int i = 0; i < localList.length; i++) {
      addTodo(localList[i]["content"]);
    }
    notifyListeners();
  }

  setLocalData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("todos", jsonEncode(_todos));
  }
}