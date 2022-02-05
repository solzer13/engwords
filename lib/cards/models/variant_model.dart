

import 'package:engwords/words/models/word.dart';

class VariantModel extends Word
{
    bool? checked;

    VariantModel(Word word) :super.fromMap(word.toMap());
}