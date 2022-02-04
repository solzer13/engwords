part of 'words_bloc.dart';

abstract class WordsEvent {
    const WordsEvent();
}

class WordsStarted extends WordsEvent
{
    final SettingsBloc settings;
    const WordsStarted(this.settings);
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

class WordsAddItem extends WordsEvent
{
    final Word word;
    const WordsAddItem(this.word);
}
