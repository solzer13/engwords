
part of 'words_page.dart';

class WordsPageListWidget extends StatelessWidget
{
    final List<Word> words;

    const WordsPageListWidget({Key? key, required this.words}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        if(words.isEmpty)
        {
            return const Center(child: Text("Вы еще не добавили слова!"));
        }

        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: words.length,
            itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    title: Text(words[index].eng),
                    subtitle: Text(words[index].rus),
                    visualDensity: VisualDensity.compact,
                    leading: Text(words[index].repeat.toString() + '/' + context.read<SettingsBloc>().settings.countRepeatWord.toString()),
                    trailing: IconButton(
                        icon: const Icon(Icons.delete),
                        iconSize: 24.0,
                        onPressed: () { context.read<WordsBloc>().add(WordsDeleteItem(words[index])); },
                    ),
                );
            }
        );
    }
}
