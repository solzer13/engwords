import 'package:bloc/bloc.dart';
import 'package:engwords/repository/providers/data_provider.dart';

part 'repository_words_event.dart';
part 'repository_words_state.dart';

class RepositoryWordsBloc extends Bloc<RepositoryWordsEvent, RepositoryWordsState> 
{
    final DataProvider _provider;

    RepositoryWordsBloc(this._provider) : super(RepositoryWordsInitial()) 
    {
        on<RepositoryWordsLoad>((event, emit) {});
    }
}
