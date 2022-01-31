import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:engwords/cards/cards.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> 
{
    WordsBloc wordsBloc;
    SettingsBloc settingsBloc;

    List<Word>? words;
    Settings? settings;

    Card? card;

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
                    if(_learnWords.length == _countWordsLern) break;
                }
            }
        }

        return _learnWords;
    }

    void _init() async 
    {
        if(words != null && settings != null)
        {
            try 
            {
                card = Card(
                    learnWords: await _getLearnWords(), 
                    counVarians: settings!.counVarians.toInt(),
                );
                
                emit(CardsLoaded(card!));
            } 
            catch (_) 
            {
                emit(const CardsError());
            }
        }
    }

}