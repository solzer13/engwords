import 'package:engwords/cards/cards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardsWidget extends StatelessWidget
{
  const CardsWidget({Key? key}) : super(key: key);
 
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
                    return Column(
            children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                        Text('3 / 5',
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
                    child: Text('data', 
                            style: TextStyle(
                                fontSize: 40,
                                color: Colors.grey.shade900
                            ),
                    ),
                ),
                Container(
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
                ),
                
                Container(
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
                ),
            ],
        );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );
        
        // if(_cards.learnWords.isEmpty)
        // {
        //     return const Center(child: Text('Вы добавили не достаточно слов для изучения!'));
        // }

        //return ;
    }

}
