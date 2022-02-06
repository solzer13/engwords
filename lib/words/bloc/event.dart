part of 'bloc.dart';

abstract class WordsBlocEvent {
    const WordsBlocEvent();
}

class WordsBlocEventStarted extends WordsBlocEvent{
    const WordsBlocEventStarted();
}

class WordsBlocEventSettingsLoaded extends WordsBlocEvent{
    final SettingsLoaded stateSettingsLoaded;
    const WordsBlocEventSettingsLoaded({required this.stateSettingsLoaded});
}

class WordsBlocEventSortAbc extends WordsBlocEvent{
    const WordsBlocEventSortAbc();
}

class WordsBlocEventSortRepeat extends WordsBlocEvent{
    const WordsBlocEventSortRepeat();
}

class WordsBlocEventChangeLearned extends WordsBlocEvent{
    final bool learned;
    const WordsBlocEventChangeLearned({required this.learned});
}

class WordsBlocEventCheckboxChange extends WordsBlocEvent{
    final WordsModel word;
    final bool checked;
    const WordsBlocEventCheckboxChange({required this.word, required this.checked});
}

class WordsBlocEventCheckboxChangeAll extends WordsBlocEvent{
    final bool checked;
    const WordsBlocEventCheckboxChangeAll({required this.checked});
}

class WordsBlocEventDelete extends WordsBlocEvent{
    const WordsBlocEventDelete();
}

class WordsBlocEventAddItem extends WordsBlocEvent{
    final WordsModel word;
    const WordsBlocEventAddItem(this.word);
}
