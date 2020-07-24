import 'dart:async';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text_provider.dart';

import '../helpers/locator.dart';
import '../screens/word_screen.dart';

class SpeechToTextWidget extends StatefulWidget {
  const SpeechToTextWidget();

  @override
  _SpeechToTextState createState() => new _SpeechToTextState();
}

class _SpeechToTextState extends State<SpeechToTextWidget> {
  String transcription = '';

  String locale = "pl_PL";

  bool initializationAsked = false;

  Future<void> initSpeechState() async {
    if (initializationAsked) return;
    var init = await locator<SpeechToTextProvider>().initialize();

    if (init)
      locator<SpeechToTextProvider>().addListener(() {
        var speechProvider = locator<SpeechToTextProvider>();
        if (speechProvider.hasResults)
          locator<GlobalKey<WordScreenState>>()
              ?.currentState
              ?.setWord(speechProvider.lastResult.recognizedWords);
      });

    // print( locator<SpeechToTextProvider>()
    //     .locales
    //     .map((e) => e.localeId)
    //     .toList());
    initializationAsked = true;
  }

  @override
  Widget build(BuildContext context) {
    var speechProvider = Provider.of<SpeechToTextProvider>(context);
    if (speechProvider.isNotListening)
      return Padding(
        padding: const EdgeInsets.all(12.0),
        child: FloatingActionButton(
          key: ValueKey("speech_to_text"),
          heroTag: "speech_to_text",
          child: Icon(speechProvider.isAvailable || !initializationAsked
              ? Icons.mic
              : Icons.mic_off),
          onPressed: speechProvider.isAvailable || !initializationAsked
              ? () {
                  locator<GlobalKey<WordScreenState>>()
                      ?.currentState
                      ?.hideKeyboard();
                  _startRecognition();
                }
              : () {
                  toast(
                      "Rozpoznawanie mowy niedostępne, brakuje uprawnień lub jest niedostępne na urządzeniu.");
                },
          backgroundColor: Colors.indigo,
        ),
      );
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Stack(
        children: [
          Container(
            child: FloatingActionButton(
              key: ValueKey("speech_to_text"),
              heroTag: "speech_to_text",
              child: Icon(
                Icons.mic,
                color: Colors.yellow,
              ),
              onPressed:
                  speechProvider.isListening ? speechProvider.stop : null,
              backgroundColor: Colors.indigoAccent,
            ),
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(
                  color: Colors.indigo[100],
                  blurRadius: speechProvider.lastLevel > 0
                      ? speechProvider.lastLevel
                      : 0,
                  spreadRadius: speechProvider.lastLevel > 0
                      ? speechProvider.lastLevel
                      : 0)
            ]),
          ),
        ],
      ),
    );
  }

  Future _startRecognition() async {
    await initSpeechState();
    locator<SpeechToTextProvider>()
        .listen(partialResults: true, soundLevel: true);
  }
}
