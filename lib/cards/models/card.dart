

import 'package:engwords/cards/cards.dart';
import 'package:engwords/words/words.dart';

class Card
{
    final List<Word> learnWords;
    final int counVariants;

    Word word = Word();
    List<Variant> variants = [];

    Card({required this.learnWords, required this.counVariants})
    {
        word = (learnWords..shuffle()).first;

        variants.add(Variant(word));

        for (var learnWord in learnWords) 
        { 
            if(learnWord != word)
            {
                variants.add(Variant(learnWord));
                if(variants.length == counVariants) break;
            }
        }

        variants.shuffle();
    }

    void checkVariant(Variant variant)
    {
        variant.checked = variant.eng == word.eng;
    }
}