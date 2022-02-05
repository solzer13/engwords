
import 'package:engwords/page_interface.dart';
import 'package:engwords/settings/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/cards/cards.dart';

part 'cards_page_bar.dart';
part 'cards_page_word.dart';
part 'cards_page_list_variants.dart';

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

    @override
    Widget build(BuildContext context) 
    {
        return BlocBuilder<CardsBloc, CardsState>(
            builder: (context, state) {
                if (state is CardsLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is CardsError) 
                {
                    return Center(child: Text(state.message));
                }
                if (state is CardsLoaded) 
                {
                    return 
                    Column(
                        children: [
                            CardsPageBarWidget(card: state.card,),
                            CardsPageWordWidget(card: state.card),
                            CardsPageListVariantsWidget(card: state.card),
                        ],
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );
    }

}
