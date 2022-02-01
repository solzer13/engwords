import 'package:bloc/bloc.dart';

import 'package:engwords/repository/repository.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> 
{
    late Settings settings;

    RepositoryBloc() : super(RepositoryInitial()) 
    {
        on<RepositoryEvent>((event, emit) {
        // TODO: implement event handler
        });
    }
}
