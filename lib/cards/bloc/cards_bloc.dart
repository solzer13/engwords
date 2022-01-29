import 'package:bloc/bloc.dart';
import 'package:engwords/words/words.dart';

part 'cards_event.dart';
part 'cards_state.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> 
{
    CardsBloc() : super(const CardsInitial())
    {
        on<CardsStarted>(_onStarted);
    }
    
    void _onStarted(CardsStarted event, Emitter<CardsState> emit) async 
    {
        emit(const CardsLoading());

        try 
        {
            emit(const CardsLoaded([]));
        } 
        catch (_) 
        {
            emit(const CardsError());
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