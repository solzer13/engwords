import 'package:bloc/bloc.dart';

part 'repository_words_event.dart';
part 'repository_words_state.dart';

class RepositoryWordsBloc extends Bloc<RepositoryWordsEvent, RepositoryWordsState> 
{
    RepositoryWordsBloc() : super(RepositoryInitial()) 
    {
        on<RepositoryWordsEvent>((event, emit) {
        // TODO: implement event handler
        });
    }
}
