
import 'package:engwords/words/models/word.dart';

class Card
{
    final Word word;
    List<Word> variants;

    Card({required this.word, required this.variants});
}