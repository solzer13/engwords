part of 'bloc.dart';

abstract class WordsBlocState {
    const WordsBlocState();
}

class WordsInitial extends WordsBlocState {
    const WordsInitial();
}

class WordsLoading extends WordsBlocState {
    const WordsLoading();
}

class WordsLoaded extends WordsBlocState {
    final List<WordsModel> words;
    const WordsLoaded({required this.words});
}

class WordsError extends WordsBlocState {
    const WordsError();
}