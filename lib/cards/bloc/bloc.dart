
import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:engwords/cards/cards.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';

part 'event.dart';
part 'state.dart';

class CardsBloc extends Bloc<CardsBlocEvent, CardsBlocState> 
{
    SettingsBloc settingsBloc;
    WordsBloc wordsBloc;
    
    late CardsModel card = CardsModel(learnWords: [], counVariants: 0);

    CardsBloc({required this.settingsBloc, required this.wordsBloc}) : super(const CardsInitial())
    {
        on<CardsStarted>(_onStarted);
        on<WordsLoadedState>(_onWordsLoadedState);
        on<CardsPressVariant>(_onPressVariant);
        on<CardsNextCard>(_onCardsNextCard);
    }
    
    Future<void> _onStarted(CardsStarted event, Emitter<CardsBlocState> emit) async
    {
        emit(const CardsLoading());

        try
        {
            wordsBloc.stream.listen((state) { 
                if(state is WordsBlocStateLoaded) {
                    add(WordsLoadedState(stateWordsLoaded: state));
                } 
            });
        }
        catch(exception)
        {
            addError(exception, StackTrace.current);
        }
    }

    FutureOr<void> _onWordsLoadedState(WordsLoadedState event, Emitter<CardsBlocState> emit) 
    {
        try
        {
            if(_checkWords())
            {
                card = CardsModel(
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

    FutureOr<void> _onCardsNextCard(CardsNextCard event, Emitter<CardsBlocState> emit) 
    {
        card.word.repeat++;

        if(card.word.repeat == settingsBloc.settings.countRepeatWord)
        {
            card.learnWords.remove(card.word);
        }

        //wordsBloc.add(WordsBlocEventEditItem(card.word));
        
        if(_checkWords())
        {
            card = CardsModel(
                learnWords: card.learnWords, 
                counVariants: settingsBloc.settings.counVariants,
            );

            emit(CardsLoaded(card: card));
        }
        else
        {
            emit(const CardsError(message: "Нет доступных слов для изучения!"));
        }
    }

    FutureOr<void> _onPressVariant(CardsPressVariant event, Emitter<CardsBlocState> emit) async
    {
        card.checkVariant(event.variant);
        
        emit(CardsLoaded(card: card));
    }

    bool _checkWords()
    {
        if(wordsBloc.words.isNotEmpty)
        {
            if(wordsBloc.words.any((word) => word.repeat < settingsBloc.settings.countRepeatWord))
            {
                return true;
            }
        }

        return false;
    }

    List<WordsModel> _getLearnWords()
    {
        List<WordsModel> _learnWords = [];

        var _countWordsLern = settingsBloc.settings.countWordsLearn + 1;

        for (var word in wordsBloc.words) 
        { 
            if(word.repeat < settingsBloc.settings.countRepeatWord)
            {
                _learnWords.add(word);
                if(_learnWords.length == _countWordsLern) break;
            }
        }
       
        return _learnWords;
    }

}