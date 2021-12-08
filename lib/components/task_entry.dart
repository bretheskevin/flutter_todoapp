import "package:flutter/material.dart";
import "package:provider/provider.dart";
import "package:todo_app/providers/todo_provider.dart";
import "package:todo_app/components/dropdown_pastels.dart";

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
        // GestureDetector(
        //   child:
        //   Container(
        //     height: 30,
        //     width: 30,
        //     margin: const EdgeInsets.only(left: 30),
        //     decoration: BoxDecoration(
        //         color: Colors.transparent,
        //         borderRadius: BorderRadius.circular(100),
        //         border: Border.all(width: 2, color: Colors.white30)),
        //   ),
        //   onTap: () {
        //   },
        // ),
        // const Material(
        //   color: Colors.transparent,
        //   child: DropdownPastels(),
        // ),
        const SizedBox(
          height: 30,
          child: Material(
            color: Colors.transparent,
            child: DropdownPastels(),
          ),
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