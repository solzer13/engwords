part of 'main_bloc.dart';

abstract class MainEvent {
    const MainEvent();
}

class MainStarted extends MainEvent {
    const MainStarted();
}
