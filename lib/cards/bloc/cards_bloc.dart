
import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:engwords/cards/cards.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> 
{
    SettingsBloc settingsBloc;
    WordsBloc wordsBloc;
    
    Card card = Card(learnWords: [], counVarians: 0);

    get _loadedState
    {
        return CardsLoaded(settings: settingsBloc.settings, card: card);
    }

    CardsBloc({required this.settingsBloc, required this.wordsBloc}) : super(const CardsInitial())
    {
        on<CardsStarted>(_onStarted);
        on<CardsPressVariant>(_onPressVariant);
        on<CardsNextCard>(_onCardsNextCard);
    }
    
    Future<void> _onStarted(CardsStarted event, Emitter<CardsState> emit) async
    {
        emit(const CardsLoading());

        wordsBloc.stream.listen((state) { 
            if(state is WordsLoaded) {
                
                card = Card(
                    learnWords: _getLearnWords(), 
                    counVarians: state.settings.counVariants,
                );
                
                emit(_loadedState);
            } 
        });
    }

    FutureOr<void> _onCardsNextCard(CardsNextCard event, Emitter<CardsState> emit) 
    {
        card.word.repeat++;
        wordsBloc.add(WordsEditItem(card.word));
        
        card = Card(
            learnWords: card.learnWords, 
            counVarians: settingsBloc.settings.counVariants,
        );

        emit(_loadedState);
    }

    FutureOr<void> _onPressVariant(CardsPressVariant event, Emitter<CardsState> emit) async
    {
        card.checkVariant(event.variant);
        
        emit(_loadedState);
    }

    List<Word> _getLearnWords()
    {
        List<Word> _learnWords = [];

        var _countWordsLern = settingsBloc.settings.countWordsLearn + 1;

        if(_learnWords.isEmpty || _learnWords.length < _countWordsLern)
        {
            for (var word in wordsBloc.words) 
            { 
                if(!word.learned)
                {
                    _learnWords.add(word);
                    if(_learnWords.length == _countWordsLern) break;
                }
            }
        }

        return _learnWords;
    }

}