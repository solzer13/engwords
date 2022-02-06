

import 'package:engwords/words/words.dart';

class CardsModelVariant extends WordsModel
{
    bool? checked;

    CardsModelVariant(WordsModel word) :super.fromMap(word.toMap());
}