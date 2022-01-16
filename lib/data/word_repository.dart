import 'dart:async';
import 'package:engwords/data/dto/json_file.dart' as dto;
import 'package:engwords/model/word.dart';

class WordRepository
{
    Stream<List<Word>> get wordsStream => _streamController.stream;

    List<Word> words = [];

    final _streamController = StreamController<List<Word>>.broadcast();

    void delWord(Word word)
    {
        words.remove(word);
        
        dto.setWords(words);

        _updateWords();
    }

    void addWord(String eng, String rus) async
    {
        words.add(Word(eng, rus));
        
        dto.setWords(words);

        _updateWords();
    }

    void _updateWords() async
    {
        words.clear();
        
        words = await dto.getWords();

        _streamController.add(words);
    }

    static final WordRepository _instance = WordRepository._();
    factory WordRepository() => _instance;

    WordRepository._() : super()
    {
        _updateWords();
    }
}
