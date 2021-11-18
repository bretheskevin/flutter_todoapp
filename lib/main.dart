import 'package:flutter/material.dart';

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
                fontFamily: "RobotMono"
              ),
            ),
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: 80,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color.fromARGB(255, 36, 39, 61),
              ),
              child: const TaskEntry(),
          )
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
                border: Border.all(width: 2, color: Colors.white30)
            ),
          ),
          onTap: () {
            // done function
          },
        ),
        const SizedBox(
          height: 30,
          width: 30,
          child: Material(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Create a new todo...",
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                fillColor: Color.fromARGB(255, 36, 39, 61),
                filled: true,
              ),
            ),
          ),
        ),
       ],
    );
  }
}
