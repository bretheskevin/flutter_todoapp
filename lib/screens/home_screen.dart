import 'package:flutter/material.dart';
import '../models/todo.dart';
import "package:provider/provider.dart";
import "package:todo_app/providers/todo_provider.dart";
import 'package:flutter_svg/flutter_svg.dart';
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

class TaskEntry extends StatefulWidget {
  const TaskEntry({Key? key}) : super(key: key);

  @override
  _TaskEntryState createState() => _TaskEntryState();
}

class _TaskEntryState extends State<TaskEntry> {
  final myController = TextEditingController();

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  void updateText() {
    context.read<TodoProvider>().addTodo(myController.text);
    myController.text = "";

    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus) {
      currentFocus.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [
        GestureDetector(
          child: Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2, color: Colors.white30)),
          ),
          onTap: () {
            updateText();
          },
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: SizedBox(
            height: 30,
            width: MediaQuery.of(context).size.width * 0.5,
            child: Material(
              color: const Color.fromARGB(255, 36, 39, 61),
              child: Center(
                child: TextField(
                  controller: myController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration.collapsed(
                    hintText: "Create a new todo...",
                    hintStyle: TextStyle(
                      color: Colors.white38,
                    ),
                    fillColor: Color.fromARGB(255, 36, 39, 61),
                    filled: true,
                  ),
                  onSubmitted: (text) {
                    updateText();
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

  void _taskDone(String content) {}

  BorderRadius _generateBorderRadius(int index, int lastIndex) {

    if (index == lastIndex - 1 && index == 0) {
      return const BorderRadius.all(Radius.circular(10));
    }

    if (index == 0) {
      return const BorderRadius.only(
          topLeft: Radius.circular(10), topRight: Radius.circular(10));
    }
    if (index == lastIndex - 1) {
      return const BorderRadius.only(
          bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
    }

    return const BorderRadius.all(Radius.circular(0));
  }

  @override
  Widget build(BuildContext context) {
    List<Todo> tasks = context.watch<TodoProvider>().todos;

    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return Container(
          margin: index == 0
              ? EdgeInsets.only(
                  top: 20,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1)
              : EdgeInsets.only(
                  top: 0,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1),
          height: 80,
          decoration: BoxDecoration(
            borderRadius: _generateBorderRadius(index, tasks.length),
            color: const Color.fromARGB(255, 36, 39, 61),
          ),
          child: Row(
            children: [
              Container(
                height: 30,
                width: 30,
                margin: const EdgeInsets.only(left: 30),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 2, color: Colors.white30)),
              ),
              Container(
                width: MediaQuery.of(context).size.width > 400 ? MediaQuery.of(context).size.width * 0.6 : MediaQuery.of(context).size.width * 0.4,
                margin: const EdgeInsets.only(left: 20),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.5,
                  child: Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Text(
                        tasks[index].content,
                        style: const TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.none,
                          fontSize: 15,
                          fontWeight: FontWeight.w100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: const EdgeInsets.only(left: 10),
                child: GestureDetector(
                  child: SvgPicture.asset("assets/icon-cross.svg", semanticsLabel: "Delete todo"),
                  onTap: () => context.read<TodoProvider>().removeTodo(tasks[index].id),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
