import 'package:app/helpers/scrabble_helper.dart';
import 'package:flutter/material.dart';

class UserWidget extends StatelessWidget {
  UserWidget(this.number, this.parentValues, this.parentDeleteFunction,
      {this.textController});

  final int number;
  final List<String> parentValues;
  final Function(int) parentDeleteFunction;
  final TextEditingController textController;

  static const adjectives = {
    1: "pierwszego",
    2: "drugiego",
    3: "trzeciego",
    4: "czwartego",
  };
  static const colors = {
    1: Colors.green,
    2: Colors.orange,
    3: Colors.blue,
    4: Colors.pink,
  };
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: ScrabbleHelper.DIRTY_WHITE,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1, color: UserWidget.colors[number])),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              number.toString(),
              style: ScrabbleHelper.textStyle
                  .copyWith(color: UserWidget.colors[number]),
            ),
          ),
        ),
        title: TextField(
          controller: textController,
          decoration: InputDecoration(
            labelText: 'Imię ${UserWidget.adjectives[number]} gracza',
          ),
          onChanged: (value) => parentValues[number] = value,
        ),
        contentPadding: const EdgeInsets.only(left: 16),
        trailing: Opacity(
          opacity: parentDeleteFunction != null ? 1 : 0,
          child: IconButton(
            padding: const EdgeInsets.all(0),
            icon: const Icon(Icons.close),
            iconSize: 20,
            onPressed: () => parentDeleteFunction(number),
          ),
        ),
      ),
    );
  }
}
