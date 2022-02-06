part of 'bloc.dart';

abstract class WordsBlocState {
    const WordsBlocState();
}

class WordsBlocStateInitial extends WordsBlocState {
    const WordsBlocStateInitial();
}

class WordsBlocStateLoading extends WordsBlocState {
    const WordsBlocStateLoading();
}

class WordsBlocStateLoaded extends WordsBlocState {
    final List<WordsModel> words;
    const WordsBlocStateLoaded({required this.words});
}

class WordsBlocStateError extends WordsBlocState {
    const WordsBlocStateError();
}