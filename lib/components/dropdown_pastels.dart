import "package:flutter/material.dart";

/// This is the stateful widget that the main application instantiates.
class DropdownPastels extends StatefulWidget {
  const DropdownPastels({Key? key}) : super(key: key);

  @override
  State<DropdownPastels> createState() => _DropdownPastelsState();
}

/// This is the private State class that goes with MyStatefulWidget.
class _DropdownPastelsState extends State<DropdownPastels> {
  final items = ["Transparent", "Red", "Pink", "White"];
  String dropdownValue = "";

  Container buildCircle(String color) {
    Color pastelColor = Colors.transparent;
    switch (color) {
      case "Red":
        pastelColor = Colors.red;
        break;
      case "Pink":
        pastelColor = Colors.pink;
        break;
      case "White":
        pastelColor = Colors.white;
        break;
    }

    return Container(
            height: 30,
            width: 30,
            margin: const EdgeInsets.only(left: 30),
            decoration: BoxDecoration(
                color: pastelColor,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(width: 2, color: Colors.white30)),
          );
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton<String>(
          value: dropdownValue,
          items: items.map(buildMenuItems).toList(),
          onChanged: (value) => setState(() => value == null ? dropdownValue = "Transparent" : dropdownValue = value),
          icon: buildCircle(dropdownValue),
          style: const TextStyle(
              color: Colors.grey,
              fontSize: 18,
          ),
        alignment: Alignment.centerRight,
        ),
    );
  }

  DropdownMenuItem<String> buildMenuItems(String item) => DropdownMenuItem(
    value: item,
    child: Text(
      item
    )
  );
}
