import 'package:bloc/bloc.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> 
{
    MainBloc() : super(const MainInitial()) {
        on<MainStarted>((event, emit) {});
    }
}
