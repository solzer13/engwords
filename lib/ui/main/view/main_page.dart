
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/repository/providers/file_data_provider.dart';
import 'package:engwords/repository/repository.dart';
import 'package:engwords/ui/main/main.dart';
import 'package:engwords/ui/words/words.dart';
import 'package:engwords/ui/cards/cards.dart';
import 'package:engwords/ui/settings/settings.dart';

part 'app_bar.dart';
part 'body.dart';
part 'bottom_navigation.dart';

class MainWidget extends StatelessWidget
{
    MainWidget({Key? key}) : super(key: key);

    late final RepositorySettingsBloc settings = RepositorySettingsBloc(FileDataProvider("settings.txt"));

    @override
    Widget build(BuildContext context) 
    {
        return MultiBlocProvider(
            providers: [
                BlocProvider<WordsBloc>(
                    create: (BuildContext context) => WordsBloc(),
                ),
                BlocProvider<CardsBloc>(
                    create: (BuildContext context) => CardsBloc(),
                ),
                BlocProvider<SettingsBloc>(
                    create: (BuildContext context) => SettingsBloc(),
                ),
            ], 
            child:  BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                    if (state is MainLoading) 
                    {
                        return const Center(child: CircularProgressIndicator());
                    }
                    if (state is MainLoaded) 
                    {
                        return Scaffold(
                            appBar: const MainAppBarWidget(),
                            body: const MainBodyWidget(),
                            bottomNavigationBar: MainBottomNawigationWidget(),
                        );
                    }
                    return const Center(child: Text('Something went wrong!'));
                },
            ),
        );

    }
}