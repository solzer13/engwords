
import 'package:engwords/page_interface.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'words_page_list.dart';
part 'words_add_dialog.dart';

class WordsWidget extends StatelessWidget implements WidgetPage
{
    @override
    final title = "Words";

    @override
    final button = const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Words',
    );

    const WordsWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return BlocBuilder<WordsBloc, WordsState>(
            builder: (context, state) {
                if (state is WordsLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is WordsLoaded) 
                {
                    return Scaffold(
                        body: WordsPageListWidget(
                            words: state.words,
                        ),
                        floatingActionButton: _floatingButton(context),
                    );
                }
                return const Text('Something went wrong!');
            },
        );
    }

    FloatingActionButton _floatingButton(BuildContext context)
    {
        return FloatingActionButton(
            onPressed: () {
                showDialog<void>(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) => const WordsAddDialogWidget()
                );
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
        );
    }

}

