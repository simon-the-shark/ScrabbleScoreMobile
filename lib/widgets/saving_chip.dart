import 'package:flutter/material.dart';

class SavingChip extends StatelessWidget {
  const SavingChip();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(top: 60, right: 10),
          child: Material(
            color: Colors.transparent,
            child: Chip(
              backgroundColor: const Color.fromRGBO(108, 117, 125, 1),
              label: const Text(
                "Zapisywanie",
                style: TextStyle(color: Colors.white),
              ),
              avatar: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 3.0,
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      )),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
