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
    final Settings settings;
    final List<Word> words;
    const WordsLoaded(this.words, this.settings);
}

class WordsError extends WordsState {
    const WordsError();
}