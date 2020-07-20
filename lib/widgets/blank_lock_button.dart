import 'package:flutter/material.dart';

import '../helpers/scrabble_helper.dart';
import 'keyboard_button.dart';

class BlankLockButton extends StatefulWidget {
  BlankLockButton(this.width, this.height, this.update, {key})
      : super(key: key);
  final double width;
  final double height;
  final Function update;
  @override
  BlankLockButtonState createState() => BlankLockButtonState();
}

class BlankLockButtonState extends State<BlankLockButton> {
  bool isActive = false;

  void unpresss() => setState(() {
        isActive = false;
      });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      height: widget.height,
      child: Padding(
        padding: KeyboardButton.buttonPadding,
        child: GestureDetector(
          onTap: !isActive
              ? null
              : () => setState(() {
                    isActive = false;
                  }),
          child: RaisedButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.all(0),
            child: RotationTransition(
              turns: AlwaysStoppedAnimation(-15 / 360),
              child: Icon(Icons.check_box_outline_blank),
            ),
            onPressed: isActive
                ? null
                : () => setState(() {
                      isActive = true;
                      widget.update("(");
                    }),
            color: ScrabbleHelper.DIRTY_WHITE,
            textColor: ScrabbleHelper.darkGreen,
            disabledColor: ScrabbleHelper.darkGreen,
            disabledTextColor: ScrabbleHelper.DIRTY_WHITE,
            animationDuration: Duration.zero,
          ),
        ),
      ),
    );
  }
}
