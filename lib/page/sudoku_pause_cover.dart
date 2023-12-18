import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:sudoku/state/sudoku_state.dart';
import 'package:sudoku/util/localization_util.dart';
import 'package:flutter_gen/gen_l10n/sudoku_localizations.dart';

class SudokuPauseCoverPage extends StatefulWidget {
  SudokuPauseCoverPage({Key? key}) : super(key: key);

  @override
  _SudokuPauseCoverPageState createState() => _SudokuPauseCoverPageState();
}

class _SudokuPauseCoverPageState extends State<SudokuPauseCoverPage> {
  SudokuState get _state => ScopedModel.of<SudokuState>(context);

  @override
  Widget build(BuildContext context) {
    TextStyle pageTextStyle = TextStyle(color: Colors.white);

  
    final String levelText = AppLocalizations.of(context)!.levelText;
    final String pauseGameText = AppLocalizations.of(context)!.pauseGameText;
    final String elapsedTimeText = AppLocalizations.of(context)!.elapsedTimeText;
    final String continueGameContentText = AppLocalizations.of(context)!.continueGameContentText;
    
    Widget titleView =
        Align(child: Text(pauseGameText, style: TextStyle(fontSize: 26)));
    Widget bodyView = Align(
        child: Column(
          children: [
            Expanded(
          flex: 1,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 80),
            Text("$levelText : ${LocalizationUtils.localizationLevelName(context, _state.level!)} ",style: TextStyle(fontSize: 20),),
            Text("$elapsedTimeText : ${_state.timer} ",style: TextStyle(fontSize: 17),),
          ])),
      Expanded(flex: 3, child: titleView),
      
      Expanded(
        flex: 1,
        child: Align(alignment: Alignment.center, child: Text(continueGameContentText)),
      )
    ]));

    var onDoubleTap = () {
      log.d("double click : leave this stack");
      Navigator.pop(context);
    };
    var onTap = () {
      log.d("single click , do nothing");
    };
    return GestureDetector(
        child: Scaffold(
            backgroundColor: Colors.pink,
            body: DefaultTextStyle(child: bodyView, style: pageTextStyle)),
        onTap: onTap,
        onDoubleTap: onDoubleTap);
  }
}
