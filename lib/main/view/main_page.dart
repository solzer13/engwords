

import 'package:engwords/page_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/main/main.dart';
import 'package:engwords/cards/cards.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';

part 'main_page_bar.dart';
part 'main_page_bottom.dart';

class MainWidget extends StatelessWidget
{
    MainWidget({Key? key}) : super(key: key);

    final List<WidgetPage> pages = [const WordsWidget(), const CardsWidget(), const SettingsWidget()];

    @override
    Widget build(BuildContext context) 
    {
        return MaterialApp(
            home: BlocBuilder<MainBloc, MainState>(
                builder: (context, state) {
                    
                    if (state is MainLoading) 
                    {
                        return const Center(child: CircularProgressIndicator());
                    }
                    if (state is MainLoaded) 
                    {
                        return Scaffold(
                            appBar: MainAppBarWidget(
                                title: pages[state.index].title
                            ),
                            body: pages[state.index] as Widget,
                            bottomNavigationBar: MainBottomNawigationWidget(
                                selectedIndex: state.index, 
                                pages: pages
                            ),
                        );
                    }
                    return const Center(child: Text('Something went wrong!'));
                },
            ),
        );
    }
}