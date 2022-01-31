

import 'package:engwords/cards/cards.dart';

class Card
{
    final List<Word> learnWords;
    final int counVarians;

    late Word word;
    late List<Variant> variants;

    Card({required this.learnWords, required this.counVarians})
    {
        word = (learnWords..shuffle()).first;

        variants.add(Variant(word));

        for (var learnWord in learnWords) 
        { 
            if(learnWord != word)
            {
                variants.add(Variant(word));
                if(variants.length == counVarians) break;
            }
        }

        variants.shuffle();
    }

    
}