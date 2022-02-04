

import 'package:engwords/cards/cards.dart';
import 'package:engwords/words/words.dart';

class Card
{
    final List<Word> learnWords;
    final int counVarians;

    Word word = Word();
    List<Variant> variants = [];

    Card({required this.learnWords, required this.counVarians})
    {
        word = (learnWords..shuffle()).first;

        variants.add(Variant(word));

        for (var learnWord in learnWords) 
        { 
            if(learnWord != word)
            {
                variants.add(Variant(learnWord));
                if(variants.length == counVarians) break;
            }
        }

        variants.shuffle();
    }

    void checkVariant(Variant variant)
    {
        variant.checked = variant.eng == word.eng;
    }
}