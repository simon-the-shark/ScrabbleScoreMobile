import '../helpers/scrabble_helper.dart';
import 'user_input_widget.dart';
import 'package:flutter/material.dart';

class AddUserWidget extends StatelessWidget {
  AddUserWidget(this.number, this.parentAddFunction);

  final int number;
  final Function(int) parentAddFunction;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      color: ScrabbleHelper.DIRTY_WHITE,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        onTap: () => parentAddFunction(number),
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border:
                  Border.all(width: 1, color: UserInputWidget.colors[number])),
          child: Padding(
              padding: const EdgeInsets.all(8.5),
              child: Icon(
                Icons.add,
                color: UserInputWidget.colors[number],
              )),
        ),
        title: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            'Dodaj ${UserInputWidget.adjectives[number]} gracza',
            style: TextStyle(color: Colors.black54),
          ),
        ),
      ),
    );
  }
}
