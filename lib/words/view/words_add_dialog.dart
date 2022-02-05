
part of 'words_page.dart';

class WordsAddDialogWidget extends StatelessWidget
{
    const WordsAddDialogWidget({Key? key}) : super(key: key);

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
                            context.read<WordsBloc>().add(WordsAddItem(word));
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
