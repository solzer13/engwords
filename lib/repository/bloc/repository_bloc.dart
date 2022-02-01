import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'repository_event.dart';
part 'repository_state.dart';

class RepositoryBloc extends Bloc<RepositoryEvent, RepositoryState> {
  RepositoryBloc() : super(RepositoryInitial()) {
    on<RepositoryEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
