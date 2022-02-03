part of 'repository_words_bloc.dart';

abstract class RepositoryWordsEvent 
{
    const RepositoryWordsEvent();
}

class RepositoryWordsLoad extends RepositoryWordsEvent 
{
    const RepositoryWordsLoad();
}

