
part of 'cards_page.dart';

class CardsPageWordWidget extends StatelessWidget
{
    final CardModel card;

    const CardsPageWordWidget({Key? key, required this.card}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return Container(
            padding: const EdgeInsets.only(top: 30, bottom: 30),
            child: Text(card.word.eng, 
                    style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900
                    ),
            ),
        );
    }
}