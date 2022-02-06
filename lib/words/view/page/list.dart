
part of 'page.dart';

class WordsViewPageList extends StatelessWidget
{
    final List<WordsModel> words;

    const WordsViewPageList({Key? key, required this.words}) : super(key: key);

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
            itemBuilder: _itemWord,
        );
    }

    Widget _itemWord(BuildContext context, int index)
    {
        return ListTile(
            title: Text(words[index].eng),
            subtitle: Text(words[index].rus),
            visualDensity: VisualDensity.compact,
            leading: Text(words[index].repeat.toString() + '/' + context.read<SettingsBloc>().settings.countRepeatWord.toString()),
            trailing: Checkbox(
                value: words[index].checked, 
                onChanged: (value) => context.read<WordsBloc>().add(WordsBlocEventCheckboxChange(
                    word: words[index], 
                    checked: value ?? false,
                ))),
            // trailing: IconButton(
            //     icon: const Icon(Icons.delete),
            //     iconSize: 24.0,
            //     onPressed: () { context.read<WordsBloc>().add(WordsDeleteItem(words[index])); },
            // ),
        );
    }
}
