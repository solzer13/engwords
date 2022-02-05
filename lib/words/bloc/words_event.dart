part of 'words_bloc.dart';

abstract class WordsEvent {
    const WordsEvent();
}

class WordsStarted extends WordsEvent{
    const WordsStarted();
}

class SettingsLoadedState extends WordsEvent{
    final SettingsLoaded stateSettingsLoaded;
    const SettingsLoadedState({required this.stateSettingsLoaded});
}

class WordsDeleteItem extends WordsEvent
{
    final Word word;
    const WordsDeleteItem(this.word);
}

class WordsEditItem extends WordsEvent
{
    final Word word;
    const WordsEditItem(this.word);
}

class WordsAddItem extends WordsEvent{
    final Word word;
    const WordsAddItem(this.word);
}
