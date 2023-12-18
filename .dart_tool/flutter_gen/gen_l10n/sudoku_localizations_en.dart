import 'sudoku_localizations.dart';

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get menuNewGame => 'New Game';

  @override
  String get menuContinueGame => 'Continue Game';

  @override
  String get levelCancel => 'Cancel';

  @override
  String get levelEasy => 'Easy';

  @override
  String get levelMedium => 'Medium';

  @override
  String get levelHard => 'Hard';

  @override
  String get levelExpert => 'Expert';

  @override
  String get sudokuGenerateText => 'Waiting for sudoku generated...';

  @override
  String get gameStatusInitialize => 'Initialize';

  @override
  String get gameStatusGaming => 'Gaming';

  @override
  String get gameStatusPause => 'Pause';

  @override
  String get gameStatusFailure => 'Failure';

  @override
  String get gameStatusVictory => 'Victory';

  @override
  String get wrongInputAlertText => 'Wrong Input\nYou can\'t afford %attempts% more turnovers';

  @override
  String get gotItText => 'Got It';

  @override
  String get levelText => 'Level';

  @override
  String get tipsText => 'Random Tips';

  @override
  String get enableMarkText => 'Enable Note';

  @override
  String get closeMarkText => 'Close Note';

  @override
  String get exitGameText => 'Exit Game';

  @override
  String get exitGameContentText => 'Whether to end this round of Sudoku ?';

  @override
  String get openText => 'Open';

  @override
  String get cancelText => 'Cancel';

  @override
  String get pauseText => 'Pause Game';

  @override
  String get markText => 'Mark';

  @override
  String get pauseGameText => 'Paused';

  @override
  String get elapsedTimeText => 'Elapsed time';

  @override
  String get continueGameContentText => 'Double click the screen to continue playing';

  @override
  String get winnerConclusionText => 'Congratulations on completing the [%level%] Sudoku challenge!';

  @override
  String get failureConclusionText => 'Unfortunately, this round of [%level%] Sudoku errors too many times, challenge failed!';
}
