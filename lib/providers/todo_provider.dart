import "package:flutter/material.dart";
import "package:todo_app/models/todo.dart";


class TodoProvider with ChangeNotifier {
  int _count = 0;
  List<Todo> _todos = [];

  int get count => _count;
  List<Todo> get todos => _todos;

  void _incrementCount() {
    _count++;
  }

  void addTodo(String content) {
    _todos.add(Todo(_count, content));
    _incrementCount();
    notifyListeners();
  }
}