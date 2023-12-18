import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/sudoku_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:logger/logger.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sudoku/effect/sound_effect.dart';
import 'package:sudoku/page/bootstrap.dart';
import 'package:sudoku/page/sudoku_game.dart';
import 'package:sudoku/state/sudoku_state.dart';

final Logger log = Logger();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  await Get.putAsync(() => SharedPreferences.getInstance());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  _initEffect() async {
    await SoundEffect.init();
  }

  Future<SudokuState> _loadState() async {
    await _initEffect();
    return await SudokuState.resumeFromDB();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SudokuState>(
      future: _loadState(),
      builder: (context, AsyncSnapshot<SudokuState> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
              color: Colors.white,
              alignment: Alignment.center,
              child: Center(
                  child: Text('Sudoku Spectrum is initializing...',
                      style: TextStyle(color: Colors.black),
                      textDirection: TextDirection.ltr)));
        }
        if (snapshot.hasError) {
          log.w("here is builder future throws error you shoud see it");
          log.w(snapshot.error);
        }
        SudokuState sudokuState = snapshot.data ?? SudokuState();
        BootstrapPage bootstrapPage = BootstrapPage(title: "Loading");
        SudokuGamePage sudokuGamePage = SudokuGamePage(title: "Sudoku Spectrum");
        return ScopedModel<SudokuState>(
          model: sudokuState,
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Sudoku Spectrum',
            theme: ThemeData(
              primarySwatch: Colors.pink,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            home: bootstrapPage,
            routes: <String, WidgetBuilder>{
              "/bootstrap": (context) => bootstrapPage,
              "/newGame": (context) => sudokuGamePage,
              "/gaming": (context) => sudokuGamePage
            },
          ),
        );
      },
    );
  }
}
