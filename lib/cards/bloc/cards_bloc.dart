import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:engwords/words/words.dart';
import 'package:engwords/cards/cards.dart';
import 'package:engwords/settings/settings.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> 
{
    WordsBloc wordsBloc;
    SettingsBloc settingsBloc;

    List<Word>? words;
    Settings? settings;

    List<Word>? learnWords;
    Word? learnWord;
    List<Word>? variants;

    CardsBloc({required this.wordsBloc, required this.settingsBloc}) : super(const CardsInitial())
    {
        on<CardsStarted>(_onStarted);
        on<CardsPressVariant>(_onPressVariant);
    }
    
    void _onStarted(CardsStarted event, Emitter<CardsState> emit) async 
    {
        emit(const CardsLoading());

        wordsBloc.stream.listen((state) { 
            if (state is WordsLoaded) 
            {
                words = state.words;
                _init();
            }
        });

        settingsBloc.stream.listen((state) {
            if (state is SettingsLoaded) 
            {
                settings = state.settings;
                _init();
            }
        });
    }

    FutureOr<void> _onPressVariant(CardsPressVariant event, Emitter<CardsState> emit) 
    {
    }

    Future<List<Word>> _getLearnWords() async
    {
        List<Word> _learnWords = [];

        var _countWordsLern = settings!.countWordsLern.toInt() + 1;

        if(_learnWords.isEmpty || _learnWords.length < _countWordsLern)
        {
            for (var word in words!) 
            { 
                if(!word.lerned)
                {
                    _learnWords.add(word);
                    if(_learnWords.length == _countWordsLern)
                    {
                        break;
                    }
                }
            }
        }

        return _learnWords;
    }

    Future<List<Word>> _getVariants(Word _learnWord, List<Word> _words) async
    {
        List<Word> _variants = [];

        _variants.add(_learnWord);

        for (var word in _words) 
        { 
            if(word != _learnWord)
            {
                _variants.add(word);
                if(_variants.length == settings!.counVarians)
                {
                    break;
                }
            }
        
        }

        return _variants..shuffle();
    }

    void _init() async 
    {
        if(words != null && settings != null)
        {
            try 
            {
                learnWords = await _getLearnWords();
                learnWord = (learnWords!..shuffle()).first;
                variants = await _getVariants(learnWord!, learnWords!);

                var card = Card(word: learnWord!, variants: variants!);

                emit(CardsLoaded(card));
            } 
            catch (_) 
            {
                emit(const CardsError());
            }
        }
    }

}


// class Cards
// {
//     List<Word> _learnWords = [];
//     List<Word> get learnWords 
//     {
//         if(_learnWords.isEmpty || _learnWords.length < _settings.countWordsLern.toInt())
//         {
//             for (var word in _wordRepository.words) 
//             { 
//                 if(!word.lerned)
//                 {
//                     _learnWords.add(word);
//                     if(_learnWords.length == _settings.countWordsLern.toInt())
//                     {
//                         break;
//                     }
//                 }
//             }
//         }

//         print(_learnWords.length);

//         return _learnWords;
//     }
// }