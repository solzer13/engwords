part of 'page.dart';

class CardsViewPageListVariants extends StatelessWidget {
  final CardsModel card;

  const CardsViewPageListVariants({Key? key, required this.card})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: card.variants.length,
        itemBuilder: _buttonVariant,
      ),
    );
  }

  Widget _buttonVariant(BuildContext context, int index) {
    var bgColor = MaterialStateProperty.all<Color>(Colors.grey.shade300);

    if (card.variants[index].verified != null) {
      bgColor = card.variants[index].verified!
          ? MaterialStateProperty.all<Color>(Colors.green)
          : MaterialStateProperty.all<Color>(Colors.red);

      if (card.variants[index].verified!) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => context.read<CardsBloc>().add(CardsNextCard(oldCard: card)),
        );
      }
    }

    return Padding(
        padding: const EdgeInsets.all(5),
        child: TextButton(
            style: ButtonStyle(
              backgroundColor: bgColor,
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  const EdgeInsets.all(20)),
            ),
            onPressed: () {
                context
                    .read<CardsBloc>()
                    .add(CardsPressVariant(variant: card.variants[index]));
            },
            child: Text(
              card.variants[index].rus,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey.shade900),
            )));
  }
}
