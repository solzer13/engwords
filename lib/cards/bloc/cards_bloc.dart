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
    
    Future<void> _onStarted(CardsStarted event, Emitter<CardsState> emit) async
    {
        emit(const CardsLoading());

        wordsBloc.stream.listen((state) async { 
            if (state is WordsLoaded) 
            {
                words = state.words;
                await _init(emit);
            }
        });

        settingsBloc.stream.listen((state) async {
            if (state is SettingsLoaded) 
            {
                settings = state.settings;
                await _init(emit);
            }
        });
    }

    FutureOr<void> _onPressVariant(CardsPressVariant event, Emitter<CardsState> emit) async
    {
        card!.checkVariant(event.variant);
        
        emit(CardsLoaded(card!));
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

    Future<void> _init(Emitter<CardsState> emit) async 
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