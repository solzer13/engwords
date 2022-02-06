
import 'package:engwords/cards/cards.dart';
import 'package:engwords/words/words.dart';

export 'variant.dart';

class CardsModel
{
    final List<WordsModel> learnWords;
    final int counVariants;

    WordsModel word = WordsModel();
    List<CardsModelVariant> variants = [];

    CardsModel({required this.learnWords, required this.counVariants})
    {
        word = (learnWords..shuffle()).first;

        variants.add(CardsModelVariant(word));

        for (var learnWord in learnWords) 
        { 
            if(learnWord != word)
            {
                variants.add(CardsModelVariant(learnWord));
                if(variants.length == counVariants) break;
            }
        }

        variants.shuffle();
    }

    void checkVariant(CardsModelVariant variant)
    {
        variant.checked = variant.eng == word.eng;
    }
}