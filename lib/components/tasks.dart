import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:todo_app/models/todo.dart';
import "package:todo_app/providers/todo_provider.dart";
import 'package:flutter_svg/flutter_svg.dart';

class Tasks extends StatelessWidget {
  const Tasks({Key? key}) : super(key: key);

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
