import 'package:flutter/material.dart';
import 'package:global_state/gs.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SafeArea(child: MyHomePage()),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(left: 100, bottom: 24),
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
            width: MediaQuery.of(context).size.width * 0.8,
            height: 80,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Color.fromARGB(255, 36, 39, 61),
            ),
            child: TaskEntry(),
          ),
          const SizedBox(width: 1, height: 30,), //margin
          Tasks(),
          const SizedBox(width: 1, height: 30,), //margin
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

class Todo {
  var id;
  var content;

  Todo(this.id, this.content);
}

class TaskEntry extends GSWidget {
  @override
  initGSMap() {
    gsmap[#id] = 0;
    List<Todo> todos = [];
    gsmap[#todos] = todos;
    gsmap[#count] = 0;
  }

  void _addTodo(content) {
    gsmap[#todos].add(Todo(gsmap[#id], content));
    gsmap[#id]++;
    gsmap[#count]++;
  }


  @override
  Widget build(BuildContext context) {
    final cards = [];
    for (int i = 0; i < gsmap[#todos].length; i++) {
      cards.add("a");
    }

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
          onTap: () => _addTodo("Hello World!"),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: const SizedBox(
            height: 30,
            width: 300,
            child: Material(
              color: Color.fromARGB(255, 36, 39, 61),
              child: Center(
                child: TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration.collapsed(
                    hintText: "Create a new todo...",
                    hintStyle: TextStyle(
                      color: Colors.white38,
                    ),
                    fillColor: Color.fromARGB(255, 36, 39, 61),
                    filled: true,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}


class Tasks extends GSWidget {
  void _taskDone(task) {
    // do thing
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tasks = [];

    BorderRadius _generateBorderRadius(int index, int lastIndex) {
      if (index == 0) {
        return const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10));
      }
      if (index == lastIndex) {
        return const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10));
      }

      return const BorderRadius.all(Radius.circular(0));
    }

    for (int i = 0; i < 6; i++) {
      tasks.add(
          Container(
            margin: i == 0 ? const EdgeInsets.only(top: 20) : const EdgeInsets.only(top: 0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: 80,
            decoration: BoxDecoration(
              borderRadius: _generateBorderRadius(i, 5),
              color: const Color.fromARGB(255, 36, 39, 61),
            ),
            child: Row(
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
                  onTap: () => _taskDone("Hello World! $i"),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: const SizedBox(
                    width: 300,
                    child: Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(
                          "Hello World",
                          style: TextStyle(
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
              ],
            ),
          )
      );
    }

    print("salut");
    print(GSList);


    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: tasks,
        ),
      ),
    );
  }
}
