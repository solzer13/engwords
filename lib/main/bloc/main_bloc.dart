import 'package:bloc/bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> 
{
    int _index = 0;

    MainBloc() : super(const MainInitial()) 
    {
        on<MainStarted>(_onStarted);
        on<MainPageChange>(_onPageChange);
    }

    Future<void> _onStarted(MainStarted event, Emitter<MainState> emit) async 
    {
        emit(MainLoaded(index: _index));
    }

    Future<void> _onPageChange(MainPageChange event, Emitter<MainState> emit) async 
    {
        _index = event.newIndex;
        emit(MainLoaded(index: _index));
    }
}
