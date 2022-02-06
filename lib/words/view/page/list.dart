
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
        Color bgCheckedColor = words[index].checked ? Colors.grey.shade200 : Colors.white;

        return Container(
            color: bgCheckedColor, 
            height: 50, 
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                    Padding(
                        padding: const EdgeInsets.only(left:10, right: 20), 
                        child: WordsViewPageListProgress(size: 30, word: words[index])
                    ),
                    Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                                Text(words[index].eng, style: const TextStyle(fontSize: 16)),
                                Text(words[index].rus, style: const TextStyle(fontSize: 13, color: Colors.grey))
                            ],
                        )
                    ),
                    Checkbox(
                        value: words[index].checked, 
                        onChanged: (value) => context.read<WordsBloc>().add(WordsBlocEventCheckboxChange(
                            word: words[index], 
                            checked: value ?? false,
                        ))
                    )
                ],
            )
        );

    }
}

class WordsViewPageListProgress extends StatelessWidget
{
    final double size;
    final WordsModel word;

    const WordsViewPageListProgress({Key? key, required this.size, required this.word}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        double progress = word.repeat / context.read<SettingsBloc>().settings.countRepeatWord.toDouble();

        return SizedBox(
            height: size,
            width: size,
            child: Stack(
                children: <Widget>[
                    Center(
                        child: SizedBox(
                            width: size,
                            height: size,
                            child: CircularProgressIndicator(
                                backgroundColor: Colors.grey.shade200,
                                strokeWidth: 4,
                                value: progress,
                            ),
                        ),
                    ),
                    Center(
                        child: Text(word.repeat.toString() + "/" + context.read<SettingsBloc>().settings.countRepeatWord.toString(), 
                            textAlign: TextAlign.center, 
                            style: const TextStyle(fontSize: 11)
                        )
                    ),
                ],
            ),
        );
    }
}