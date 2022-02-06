

import 'package:engwords/words/words.dart';

class CardsModelVariant extends WordsModel
{
    bool? verified;

    CardsModelVariant(WordsModel word) :super.fromMap(word.toMap());
}