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
        on<CardsNextCard>(_onCardsNextCard);
        on<CardsWordsLoaded>(_onCardsWordsLoaded);
        on<CardsSettingsLoaded>(_onCardsSettingsLoaded);
    }
    
    FutureOr<void> _onCardsWordsLoaded(CardsWordsLoaded event, Emitter<CardsState> emit) 
    {
        words = event.words;
        _init(emit);
    }

    FutureOr<void> _onCardsSettingsLoaded(CardsSettingsLoaded event, Emitter<CardsState> emit) 
    {
        settings = event.settings;
        _init(emit);
    }
    
    Future<void> _onStarted(CardsStarted event, Emitter<CardsState> emit) async
    {
        emit(const CardsLoading());

        wordsBloc.stream.listen((state) { 
            if(state is WordsLoaded) {
                add(CardsWordsLoaded(state.words));
            } 
        });

        settingsBloc.stream.listen((state) { 
            if (state is SettingsLoaded) {
                add(CardsSettingsLoaded(state.settings));
            } 
        });
    }

    FutureOr<void> _onCardsNextCard(CardsNextCard event, Emitter<CardsState> emit) 
    {
        card?.word.repeat++;
        
    }

    FutureOr<void> _onPressVariant(CardsPressVariant event, Emitter<CardsState> emit) async
    {
        card!.checkVariant(event.variant);
        
        emit(CardsLoaded(card!));
    }

    List<Word> _getLearnWords()
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

    void _init(Emitter<CardsState> emit)  
    {
        if(words != null && settings != null)
        {
            try 
            {
                card = Card(
                    learnWords: _getLearnWords(), 
                    counVarians: settings!.counVarians.toInt(),
                );
                
                emit(CardsLoaded(card!));
            } 
            catch (e) 
            {
                emit(CardsError('Error:' + e.toString()));
            }
        }
    }

}