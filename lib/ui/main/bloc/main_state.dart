part of 'main_bloc.dart';

abstract class MainState {
    const MainState();
}

class MainInitial extends MainState {
    const MainInitial();
}

class MainLoading extends MainState {
    const MainLoading();
}

class MainLoaded extends MainState {
    const MainLoaded();
}
