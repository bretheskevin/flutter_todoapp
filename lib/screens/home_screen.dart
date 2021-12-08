import 'package:flutter/material.dart';
import 'package:todo_app/components/task_entry.dart';
import "package:provider/provider.dart";
import 'package:todo_app/components/tasks.dart';
import "package:todo_app/providers/todo_provider.dart";
import 'package:shared_preferences/shared_preferences.dart';
import "dart:convert";

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? todos = prefs.getString("todos");
    if (todos != null) {
      List<dynamic> json = jsonDecode(todos);
      context.read<TodoProvider>().initTodo(json);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            padding: const EdgeInsets.only(bottom: 24),
            margin: const EdgeInsets.only(top: 50),
            child: const Text(
              "TODO",
              style: TextStyle(
                  fontSize: 40,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                  letterSpacing: 23,
                  fontWeight: FontWeight.bold,
                  fontFamily: "RobotMono"),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                left: MediaQuery.of(context).size.width * 0.1,
                right: MediaQuery.of(context).size.width * 0.1),
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 36, 39, 61),
            ),
            child: const TaskEntry(),
          ),
          const SizedBox(
            width: 1,
            height: 30,
          ), //margin
          // const Tasks(),
          const Expanded(
            child: Tasks(),
          ),
          const SizedBox(
            width: 1,
            height: 30,
          ), //margin
        ],
      ),
      decoration: buildBackground(),
    );
  }

  BoxDecoration buildBackground() {
    return const BoxDecoration(
      color: Color.fromARGB(255, 22, 22, 32),
      image: DecorationImage(
        image: AssetImage("assets/backgroundLandscape.jpg"),
        fit: BoxFit.fitWidth,
        scale: 0.5,
        alignment: Alignment.topCenter,
      ),
    );
  }
}
