
import 'package:engwords/interface_view_page.dart';
import 'package:engwords/settings/bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/cards/cards.dart';

part 'bar.dart';
part 'word.dart';
part 'list_variants.dart';

class CardsViewPage extends StatelessWidget implements ViewPageInterface
{
    @override
    String get title => "Cards";
 
    @override
    BottomNavigationBarItem get button => const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Cards',
    );

    @override
    List<IconButton> get actions => [];

    const CardsViewPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return BlocBuilder<CardsBloc, CardsBlocState>(
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
                            CardsViewPageBar(card: state.card,),
                            CardsViewPageWord(card: state.card),
                            CardsViewPageListVariants(card: state.card),
                        ],
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );
    }

}
