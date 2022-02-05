
import 'package:engwords/page_interface.dart';
import 'package:engwords/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/cards/cards.dart' as cards;

class CardsWidget extends StatelessWidget implements WidgetPage
{
    const CardsWidget({Key? key}) : super(key: key);

    @override
    final String title = "Cards";
 
    @override
    final button = const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Cards',
    );

    Widget buttonVariant(BuildContext context, cards.Card card, cards.Variant variant)
    {
        var bgColor = MaterialStateProperty.all<Color>(Colors.grey);

        if(variant.checked != null)
        {
            bgColor = variant.checked! ? MaterialStateProperty.all<Color>(Colors.green) :MaterialStateProperty.all<Color>(Colors.red) ;
        
            if(variant.checked!)
            {
                Future.delayed(const Duration(seconds: 1), (){context.read<cards.CardsBloc>().add(cards.CardsNextCard(oldCard: card));});
            }
        }

        return TextButton(
            style: ButtonStyle(
                backgroundColor: bgColor,
            ),
            onPressed: () { context.read<cards.CardsBloc>().add(cards.CardsPressVariant(variant:variant)); },
            child: Text(variant.rus, 
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900
                ),
            )
        );
    }

    Widget _listWords(cards.Card card)
    {
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: card.variants.length,
            itemBuilder: (BuildContext context, int index) {
                return buttonVariant(context, card, card.variants[index]);
            }
        );
    }

    @override
    Widget build(BuildContext context) 
    {
        return BlocBuilder<cards.CardsBloc, cards.CardsState>(
            builder: (context, state) {
                if (state is cards.CardsLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is cards.CardsError) 
                {
                    return Center(child: Text(state.message));
                }
                if (state is cards.CardsLoaded) 
                {
                    return 
                    Column(
                        children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    Text(state.card.word.repeat.toString() + ' / ' + context.read<SettingsBloc>().settings.countRepeatWord.toString(),
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
                            ),
                            Container(
                                padding: const EdgeInsets.only(top: 30, bottom: 30),
                                child: Text(state.card.word.eng, 
                                        style: TextStyle(
                                            fontSize: 40,
                                            color: Colors.grey.shade900
                                        ),
                                ),
                            ),
                            Expanded(
                                child: _listWords(state.card),
                            ),
                            
                        ],
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );
    }

}
