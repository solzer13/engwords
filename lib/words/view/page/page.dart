
import 'package:engwords/interface_view_page.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'list.dart';
part 'add_dialog.dart';
part 'pop_menu_buttons.dart';

class WordsViewPage extends StatelessWidget implements ViewPageInterface
{
    @override
    String get title => "Words";

    @override
    BottomNavigationBarItem get button => const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Words',
    );

    @override
    List<Widget> get actions => [
        const PopMenuButtonSort(),
        const PopMenuButtonMore(),
    ];

    const WordsViewPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        
        return BlocBuilder<WordsBloc, WordsBlocState>(
            builder: (context, state) {
                if (state is WordsBlocStateLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is WordsBlocStateLoaded) 
                {
                    return Scaffold(
                        body: WordsViewPageList(
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
                    builder: (BuildContext context) => const WordsViewPageAddDialog()
                );
            },
            child: const Icon(Icons.add),
            backgroundColor: Colors.blue,
        );
    }

}

