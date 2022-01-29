
import 'package:engwords/words/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WordsWidget extends StatelessWidget
{
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
                        body: WordsListWidget(
                            bloc: context.read<WordsBloc>(),
                            words: state.words,
                        ),
                        
                        floatingActionButton: FloatingActionButton(
                            onPressed: () {
                                showDialog<void>(
                                    context: context,
                                    barrierDismissible: false, // user must tap button!
                                    builder: (BuildContext context) => WordsAddDialogWidget(
                                        bloc: context.read<WordsBloc>(),
                                    )
                                );
                            },
                            child: const Icon(Icons.add),
                            backgroundColor: Colors.blue,
                        ),
                    );
                }
                return const Text('Something went wrong!');
            },
        );
    }

}

class WordsAddDialogWidget extends StatelessWidget
{
    final Bloc bloc;

    const WordsAddDialogWidget({Key? key, required this.bloc}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        var word = Word();

        return SimpleDialog(
            title: const Text('Add word'),
            contentPadding: const EdgeInsets.all(10),
            children: [
                Column(
                children: [
                    TextField(
                    onChanged: (value) { word.eng = value; },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'English',
                    ),
                    ),
                    Container(height: 10),
                    TextField(
                    onChanged: (value) { word.rus = value; },
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Russian',
                    ),
                    ),
                    Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        TextButton(
                        onPressed: () {
                            bloc.add(WordsAddItem(word));
                            Navigator.pop(context);
                        },
                        child: const Text('Add'),
                        ),
                        TextButton(
                        onPressed: () {
                            Navigator.pop(context);
                        },
                        child: const Text('Chancel'),
                        ),
                    ],
                    ),
                ],
                ),
            ],
        );
    }
}

class WordsListWidget extends StatelessWidget
{
    final Bloc bloc;
    final List<Word> words;

    const WordsListWidget({Key? key, required this.bloc, required this.words}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: words.length,
            itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(words[index].eng),
                    subtitle: Text(words[index].rus),
                    visualDensity: VisualDensity.compact,
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        iconSize: 24.0,
                        onPressed: () { bloc.add(WordsDeleteItem(words[index])); },
                    ),
                );
            }
        );
    }
}