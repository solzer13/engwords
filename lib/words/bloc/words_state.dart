part of 'words_bloc.dart';

abstract class WordsState {
    const WordsState();
}

class WordsInitial extends WordsState {
    const WordsInitial();
}

class WordsLoading extends WordsState {
    const WordsLoading();
}

class WordsLoaded extends WordsState {
    final SettingsBloc settings;
    final WordsBloc words;
    const WordsLoaded({required this.settings, required this.words});
}

class WordsError extends WordsState {
    const WordsError();
}