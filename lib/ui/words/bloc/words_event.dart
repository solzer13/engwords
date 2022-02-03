part of 'words_bloc.dart';

abstract class WordsEvent {
    const WordsEvent();
}

class WordsStarted extends WordsEvent
{
    const WordsStarted();
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

class WordsSettingsLoaded extends WordsEvent
{
    final Settings settings;
    const WordsSettingsLoaded(this.settings);
}