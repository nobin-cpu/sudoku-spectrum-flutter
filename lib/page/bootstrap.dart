import 'dart:async';
import 'dart:isolate';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/sudoku_localizations.dart';
import 'package:logger/logger.dart' hide Level;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sudoku/state/sudoku_state.dart';
import 'package:sudoku/util/localization_util.dart';
import 'package:sudoku_dart/sudoku_dart.dart';

final Logger log = Logger();

class BootstrapPage extends StatefulWidget {
  BootstrapPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BootstrapPageState createState() => _BootstrapPageState();
}

Widget _buttonWrapper(
    BuildContext context, Widget childBuilder(BuildContext content)) {
  return Container(
      margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
      width: 300,
      height: 60,
      child: childBuilder(context));
}

Widget _scanButton(BuildContext context) {
  return Offstage(
      offstage: true,
      child: _buttonWrapper(
          context,
          (content) => CupertinoButton(
                color: Colors.orange,
                child: Text("扫独解题"),
                onPressed: () {
                  log.d("scan");
                },
              )
              )
              );
}

Widget _continueGameButton(BuildContext context) {
  return ScopedModelDescendant<SudokuState>(builder: (context, child, state) {
    String buttonLabel = AppLocalizations.of(context)!.menuContinueGame;
    String continueMessage =
        "${LocalizationUtils.localizationLevelName(context, state.level ?? Level.easy)} - ${state.timer}";
    return Offstage(
        offstage: state.status != SudokuGameStatus.pause,
        child: Container(
         
          child: CupertinoButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                 
                  Container(
                      child:
                          Text(continueMessage, style: TextStyle(fontSize: 13))),
                          SizedBox(height: 5),
                           Container(
                    padding: EdgeInsets.all(5),
                    
decoration: BoxDecoration(color: Colors.pink,borderRadius: BorderRadius.circular(10)),
                      child: Text(buttonLabel,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold))),
                ],
              ),
              onPressed: () {
                Navigator.pushNamed(context, "/gaming");
              }),
        ));
  });
}

void _internalSudokuGenerate(List<dynamic> args) {
  Level level = args[0];
  SendPort sendPort = args[1];

  Sudoku sudoku = Sudoku.generate(level);
  log.d("数独生成完毕");
  sendPort.send(sudoku);
}

Future _sudokuGenerate(BuildContext context, Level level) async {
  String sudokuGenerateText = AppLocalizations.of(context)!.sudokuGenerateText;
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
          child: Container(
              padding: EdgeInsets.all(10),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                CircularProgressIndicator(),
                Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(sudokuGenerateText))
              ]))));

  ReceivePort receivePort = ReceivePort();

  Isolate isolate = await Isolate.spawn(
      _internalSudokuGenerate, [level, receivePort.sendPort]);
  var data = await receivePort.first;
  Sudoku sudoku = data;
  SudokuState state = ScopedModel.of<SudokuState>(context);
  state.initialize(sudoku: sudoku, level: level);
  state.updateStatus(SudokuGameStatus.pause);
  receivePort.close();
  isolate.kill(priority: Isolate.immediate);
  log.d("receivePort.listen done!");

  // dismiss dialog
  Navigator.pop(context);
}

Widget _newGameButton(BuildContext context) {
  return _buttonWrapper(
      context,
      (_) => CupertinoButton(
          color: Colors.pink,
          child: Text(
            // AppLocalizations.of(context)!.menuNewGame,
            "Tap to start new game",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          onPressed: () {
           
            Widget cancelButton = SizedBox(
                height: 60,
                width: MediaQuery.of(context).size.width,
                child: Container(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: CupertinoButton(
                      child: Text(AppLocalizations.of(context)!.levelCancel),
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                    )));

          
            List<Widget> buttons = [];
            Level.values.forEach((Level level) {
              String levelName = LocalizationUtils.localizationLevelName(context, level);
              buttons.add(SizedBox(
                  height: 60,
                  width: MediaQuery.of(context).size.width,
                  child: Container(
                      margin: EdgeInsets.all(2.0),
                      child: CupertinoButton(
                        child: Text(
                          levelName,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () async {
                          log.d(
                              "begin generator Sudoku with level : $levelName");
                          await _sudokuGenerate(context, level);
                          Navigator.popAndPushNamed(context, "/gaming");

                        },
                      ))));
            });
            buttons.add(cancelButton);

            showCupertinoModalBottomSheet(
              context: context,
              builder: (context) {
                return SafeArea(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Material(
                        child: Container(
                            height: 300,
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: buttons))),
                  ),
                );
              },
            );
          }));
}

class _BootstrapPageState extends State<BootstrapPage> {
  @override
  Widget build(BuildContext context) {
    Widget body = Container(
        color: Colors.white,
        padding: EdgeInsets.all(20.0),
        child:Column(
          children: <Widget>[
           Image.asset("assets/image/homeBg.jpg",),
           Wrap(
            children: List.generate(
              "Unleash Your Logical Brilliance with Sudoku Spectrum".length,
              (index) => Container(
                width: 21, 
                height: 21, 
                margin: EdgeInsets.all(4), 
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    "Unleash Your Logical Brilliance with Sudoku Spectrum"[index],
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ),),
           
            Expanded(
                flex: 1,
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end, children: [
                  
                  _continueGameButton(context),
                  // new game
                  _newGameButton(context),
                  // scanner ?
                  _scanButton(context),
                ]))
          ],
        ));

    return ScopedModelDescendant<SudokuState>(
        builder: (context, child, model) => Scaffold(body: body));
  }
}
