import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'file_data_provider.dart';
import 'main/main.dart';
import 'settings/settings.dart';
import 'words/words.dart';
import 'cards/cards.dart';


void main() 
{
    BlocOverrides.runZoned(
        () => runApp(MultiBlocProvider(
                providers: [
                    BlocProvider(
                        create:(BuildContext context) => MainBloc()..add(const MainStarted()),
                        lazy: false,
                    ),
                    BlocProvider(
                        create:(BuildContext context) => SettingsBloc(
                            provider: FileDataProvider("settings.txt")
                        )..add(const SettingsStarted()),
                        lazy: false,
                    ),
                    BlocProvider(
                        create:(BuildContext context) => WordsBloc(
                            provider: FileDataProvider("words.txt"), 
                            settingsBloc: context.read<SettingsBloc>()
                        )..add(const WordsBlocEventStarted()),
                        lazy: false,
                    ),
                    BlocProvider(
                        create:(BuildContext context) => CardsBloc(
                            settingsBloc: context.read<SettingsBloc>(), 
                            wordsBloc: context.read<WordsBloc>()
                        )..add(const CardsStarted()),
                        lazy: false,
                    ),
                ],
                child: MainWidget(),
            ),),
        blocObserver: SimpleBlocObserver(),
    );
}

class SimpleBlocObserver extends BlocObserver 
{
    @override
    void onEvent(Bloc bloc, Object? event) {
        super.onEvent(bloc, event);
        log('EVENT: ${bloc.runtimeType} $event');
    }

    @override
    void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
        log('ERROR: ${bloc.runtimeType} $error');
        super.onError(bloc, error, stackTrace);
    }

    // @override
    // void onTransition(Bloc bloc, Transition transition) {
    //     super.onTransition(bloc, transition);
    //     log('$transition');
    // }
}