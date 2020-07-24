// import 'dart:io';
// import 'dart:typed_data';
// import 'dart:ui' as ui;

import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:path_provider/path_provider.dart';

import 'scrabble_tile.dart';

class Logo extends StatelessWidget {
  Logo({this.rKey});
  final GlobalKey rKey;

  // Future screnshot() async {
  //   RenderRepaintBoundary boundary = rKey?.currentContext?.findRenderObject();
  //   ui.Image image =
  //       await boundary.toImage(pixelRatio: ui.window.devicePixelRatio);
  //   ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  //   Uint8List pngBytes = byteData.buffer.asUint8List();
  //   var tempDir = await getExternalStorageDirectory();
  //   String tempPath = '${tempDir.path}/logo.png';
  //   var i = File(tempPath);
  //   bool isExist = await i.exists();
  //   if (isExist) await i.delete();
  //   await File(tempPath).writeAsBytes(pngBytes);
  //   print(tempPath);
  // }

  @override
  Widget build(BuildContext context) {
    // Future.delayed(Duration(seconds: 5), screnshot);
    return RepaintBoundary(
      key: rKey,
      child: RotationTransition(
        child: ScrabbleTile(
          letter: "S",
          points: 1,
        ),
        turns: AlwaysStoppedAnimation(-10 / 360),
      ),
    );
  }
}
