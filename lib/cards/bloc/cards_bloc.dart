
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
    
    late Card card = Card(learnWords: [], counVariants: 0);

    CardsBloc({required this.settingsBloc, required this.wordsBloc}) : super(const CardsInitial())
    {
        on<CardsStarted>(_onStarted);
        on<WordsLoadedState>(_onWordsLoadedState);
        on<CardsPressVariant>(_onPressVariant);
        on<CardsNextCard>(_onCardsNextCard);
    }
    
    Future<void> _onStarted(CardsStarted event, Emitter<CardsState> emit) async
    {
        emit(const CardsLoading());

        try
        {
            wordsBloc.stream.listen((state) { 
                if(state is WordsLoaded) {
                    add(WordsLoadedState(stateWordsLoaded: state));
                } 
            });
        }
        catch(exception)
        {
            addError(exception, StackTrace.current);
        }
    }

    FutureOr<void> _onWordsLoadedState(WordsLoadedState event, Emitter<CardsState> emit) 
    {
        try
        {
            if(_checkWords())
            {
                card = Card(
                    learnWords: _getLearnWords(), 
                    counVariants: settingsBloc.settings.counVariants,
                );
                
                emit(CardsLoaded(card: card));
            }
            else
            {
                emit(const CardsError(message: "Нет доступных слов для изучения!"));
            }
        }
        catch(exception)
        {
            addError(exception, StackTrace.current);
        }    
    }

    FutureOr<void> _onCardsNextCard(CardsNextCard event, Emitter<CardsState> emit) 
    {
        card.word.repeat++;
        wordsBloc.add(WordsEditItem(card.word));
        
        card = Card(
            learnWords: card.learnWords, 
            counVariants: settingsBloc.settings.counVariants,
        );

        emit(CardsLoaded(card: card));
    }

    FutureOr<void> _onPressVariant(CardsPressVariant event, Emitter<CardsState> emit) async
    {
        card.checkVariant(event.variant);
        
        emit(CardsLoaded(card: card));
    }

    bool _checkWords()
    {
        if(wordsBloc.words.isNotEmpty)
        {
            if(wordsBloc.words.any((word) => !word.learned))
            {
                return true;
            }
        }

        return false;
    }

    List<Word> _getLearnWords()
    {
        List<Word> _learnWords = [];

        var _countWordsLern = settingsBloc.settings.countWordsLearn + 1;

        for (var word in wordsBloc.words) 
        { 
            if(!word.learned)
            {
                _learnWords.add(word);
                if(_learnWords.length == _countWordsLern) break;
            }
        }
       
        return _learnWords;
    }

}