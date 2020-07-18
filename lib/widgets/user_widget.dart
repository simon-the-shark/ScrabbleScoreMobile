import 'package:flutter/material.dart';

import '../helpers/scrabble_helper.dart';

class UserWidget extends StatelessWidget {
  UserWidget(this.player);

  final MapEntry<int, String> player;

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
              border:
                  Border.all(width: 1, color: UserWidget.colors[player.key])),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Text(
              player.key.toString(),
              style: ScrabbleHelper.textStyle
                  .copyWith(color: UserWidget.colors[player.key]),
            ),
          ),
        ),
        title: Text(player.value),
        // trailing: Opacity(
        //   opacity: parentDeleteFunction != null ? 1 : 0,
        //   child: IconButton(
        //     padding: const EdgeInsets.all(0),
        //     icon: const Icon(Icons.close),
        //     iconSize: 20,
        //     onPressed: () => parentDeleteFunction(number),
        //   ),
        // ),
      ),
    );
  }
}
