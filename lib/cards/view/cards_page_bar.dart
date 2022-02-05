
part of 'cards_page.dart';


class CardsPageBarWidget extends StatelessWidget
{
    final CardModel card;

    const CardsPageBarWidget({Key? key, required this.card}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
                Text(card.word.repeat.toString() + ' / ' + context.read<SettingsBloc>().settings.countRepeatWord.toString(),
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey.shade900
                    ),),
                IconButton(
                    icon: const Icon(Icons.check),
                    iconSize: 30.0,
                    tooltip: 'Пометить выученым',
                    onPressed: () {  },
                )
            ],
        );
    }
}