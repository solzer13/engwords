import 'dart:developer';
import 'package:engwords/repository/providers/file_data_provider.dart';
import 'package:engwords/repository/repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/repository.dart';
import 'package:engwords/words/words.dart';
import 'package:engwords/cards/cards.dart';
import 'package:engwords/settings/settings.dart';


void main() 
{
    BlocOverrides.runZoned(
        () => runApp(App()),
        blocObserver: SimpleBlocObserver(),
    );
}

class App extends StatelessWidget 
{
    App({Key? key}) : super(key: key);

    late final RepositorySettingsBloc settings = RepositorySettingsBloc(FileDataProvider("settings.txt"));

    @override
    Widget build(BuildContext context) 
    {
        var settingsBloc = SettingsBloc(repository: repository)..add(const SettingsStarted());
        var wordsBloc = WordsBloc(repository: repository, settingsBloc: settingsBloc)..add(const WordsStarted());
        var cardsBloc = CardsBloc(wordsBloc: wordsBloc, settingsBloc: settingsBloc)..add(const CardsStarted());

        return MultiBlocProvider(
            providers: 
            [
                BlocProvider(
                    lazy: false,
                    create: (_) => wordsBloc,
                ),
                BlocProvider(
                    lazy: false,
                    create: (_) => cardsBloc,
                ),
                BlocProvider(
                    lazy: false,
                    create: (_) => settingsBloc,
                ),
            ],
            child: const MaterialApp(
                home: MainWidget(),
            ),
        );
    }
}
class MainWidget extends StatefulWidget 
{
    const MainWidget({Key? key}) : super(key: key);

    @override
    State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> 
{
    int _selectedIndex = 0;

    static Map<String, Widget> pages = 
    {
        'Words'    : WordsWidget(),
        'Cards'    : const CardsWidget(),
        'Settings' : const SettingsWidget(),
    };

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(pages.keys.toList()[_selectedIndex]),
            ),
            body: Center(
                child: pages.values.toList()[_selectedIndex]
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>
                [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: 'Words',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.featured_play_list_outlined),
                        label: 'Cards',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                    ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                onTap: (int index) 
                {
                    setState(() {
                        _selectedIndex = index;
                    });
                }
            ),
        );
    }
}

class SimpleBlocObserver extends BlocObserver {
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