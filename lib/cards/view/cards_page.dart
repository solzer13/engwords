import 'package:engwords/cards/cards.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsWidget extends StatelessWidget
{
  const CardsWidget({Key? key}) : super(key: key);
 
    Widget _button()
    {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.grey,
                border: Border.all(color: Colors.grey.shade900)
            ),
            child: Text('test', 
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900
                ),
            ),
        );
    }

    Widget _buttonSuccess()
    {
        return Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(color: Colors.grey.shade900)
            ),
            child: Text('test', 
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.grey.shade900
                ),
            ),
        );
    }

    Widget _listWords(List<Word> _words)
    {
        return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: _words.length,
            itemBuilder: (BuildContext context, int index) {
                return TextButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
                    ),
                    onPressed: () { context.read<CardsBloc>().add(CardsPressVariant(_words[index])); },
                    child: Text(_words[index].rus, 
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey.shade900
                        ),
                    )
                        
                );
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
