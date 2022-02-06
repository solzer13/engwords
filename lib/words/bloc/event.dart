part of 'bloc.dart';

abstract class WordsBlocEvent {
    const WordsBlocEvent();
}

class WordsStarted extends WordsBlocEvent{
    const WordsStarted();
}

class SettingsLoadedState extends WordsBlocEvent{
    final SettingsLoaded stateSettingsLoaded;
    const SettingsLoadedState({required this.stateSettingsLoaded});
}

class WordsCheckboxChange extends WordsBlocEvent
{
    final WordsModel word;
    final bool checked;
    const WordsCheckboxChange({required this.word, required this.checked});
}

class WordsDeleteItem extends WordsBlocEvent
{
    final WordsModel word;
    const WordsDeleteItem(this.word);
}

class WordsEditItem extends WordsBlocEvent
{
    final WordsModel word;
    const WordsEditItem(this.word);
}

class WordsAddItem extends WordsBlocEvent{
    final WordsModel word;
    const WordsAddItem(this.word);
}
