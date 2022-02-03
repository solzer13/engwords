import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repository/providers/file_data_provider.dart';
import 'repository/repository.dart';
import 'ui/main/main.dart';
import 'ui/words/words.dart';
import 'ui/cards/cards.dart';
import 'ui/settings/settings.dart';


void main() 
{
    BlocOverrides.runZoned(
        () => runApp(MaterialApp(
            home: MultiRepositoryProvider(
                providers: [
                    RepositoryProvider<RepositorySettingsBloc>(
                        create: (context) => RepositorySettingsBloc(FileDataProvider("settings.txt"))..add(const RepositorySettingsLoad()),
                    ),
                    RepositoryProvider<RepositoryWordsBloc>(
                        create: (context) => RepositoryWordsBloc(FileDataProvider("words.txt"))..add(const RepositoryWordsLoad()),
                    ),
                ], 
                child: MultiBlocProvider(
                    providers: [
                        BlocProvider<MainBloc>(
                            create: (BuildContext context) => MainBloc()..add(const MainStarted()),
                        ),
                        BlocProvider<WordsBloc>(
                            create: (BuildContext context) => WordsBloc(
                                settings: context.read<RepositorySettingsBloc>(),
                                words: context.read<RepositoryWordsBloc>(),
                            )..add(const WordsStarted()),
                        ),
                        BlocProvider<CardsBloc>(
                            create: (BuildContext context) => CardsBloc(
                                settings: context.read<RepositorySettingsBloc>(),
                                words: context.read<RepositoryWordsBloc>(),
                            )..add(const CardsStarted()),
                        ),
                        BlocProvider<SettingsBloc>(
                            create: (BuildContext context) => SettingsBloc(
                                settings: context.read<RepositorySettingsBloc>(),
                            )..add(const SettingsStarted()),
                        ),
                    ], 
                    child: const MainWidget(),
                )
            )
        )),
        blocObserver: SimpleBlocObserver(),
    );
}

class SimpleBlocObserver extends BlocObserver 
{
    @override
    void onEvent(Bloc bloc, Object? event) {
        super.onEvent(bloc, event);
        log('${bloc.runtimeType} $event');
    }

    @override
    void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
        log('${bloc.runtimeType} $error');
        super.onError(bloc, error, stackTrace);
    }

    @override
    void onTransition(Bloc bloc, Transition transition) {
        super.onTransition(bloc, transition);
        //log('$transition');
    }
}