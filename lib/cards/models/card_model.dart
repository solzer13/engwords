

import 'package:engwords/cards/cards.dart';
import 'package:engwords/words/words.dart';

class CardModel
{
    final List<Word> learnWords;
    final int counVariants;

    Word word = Word();
    List<VariantModel> variants = [];

    CardModel({required this.learnWords, required this.counVariants})
    {
        word = (learnWords..shuffle()).first;

        variants.add(VariantModel(word));

        for (var learnWord in learnWords) 
        { 
            if(learnWord != word)
            {
                variants.add(VariantModel(learnWord));
                if(variants.length == counVariants) break;
            }
        }

        variants.shuffle();
    }

    void checkVariant(VariantModel variant)
    {
        variant.checked = variant.eng == word.eng;
    }
}