

import 'package:engwords/words/models/word.dart';

class Variant extends Word
{
    bool? checked;

    Variant(Word word) :super.fromMap(word.toMap());
}