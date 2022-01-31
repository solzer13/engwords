import 'package:engwords/cards/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsWidget extends StatelessWidget
{
  const CardsWidget({Key? key}) : super(key: key);
 
    Widget buttonVariant(BuildContext context, Variant variant)
    {
        var bgColor = MaterialStateProperty.all<Color>(Colors.grey);

        if(variant.checked != null)
        {
            bgColor = variant.checked! ? MaterialStateProperty.all<Color>(Colors.green) :MaterialStateProperty.all<Color>(Colors.red) ;
        }

        return TextButton(
            style: ButtonStyle(
                backgroundColor: bgColor,
            ),
            onPressed: () { context.read<CardsBloc>().add(CardsPressVariant(variant)); },
            child: Text(variant.rus, 
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900
                ),
            )
        );
    }

    Widget _listWords(List<Variant> variants)
    {
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: variants.length,
            itemBuilder: (BuildContext context, int index) {
                return buttonVariant(context, variants[index]);
            }
        );
    }

    @override
    Widget build(BuildContext context) 
    {
        return BlocBuilder<CardsBloc, CardsState>(
            builder: (context, state) {
                if (state is CardsLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is CardsLoaded) 
                {
                    return 
                    Column(
                        children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                    Text(state.card.word.repeat.toString() + ' / ' + context.read<SettingsBloc>().settings.countRepeatWord.round().toString(),
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
                                child: _listWords(state.card.variants),
                            ),
                            
                        ],
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );
    }

}
