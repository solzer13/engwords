
import 'package:bloc/bloc.dart';
import 'package:engwords/repository.dart';
import 'package:engwords/words/words.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

    final Repository repository;

    final List<Word> words = [];

    WordsBloc({required this.repository}) : super(const WordsInitial()) {
        on<WordsStarted>(_onStarted);
        on<WordsAddItem>(_onAddItem);
        on<WordsDeleteItem>(_onDeleteItem);
    }
    
    void _onStarted(WordsStarted event, Emitter<WordsState> emit) async {
        emit(const WordsLoading());
        try 
        {
            List<dynamic> wordsMap = await repository.getWords();

            for (var wordMap in wordsMap) {
                words.add(Word.fromMap(wordMap));
            }

            emit(WordsLoaded(words));
        } 
        catch (_) 
        {
            emit(const WordsError());
        }
    }

    void _onAddItem(WordsAddItem event, Emitter<WordsState> emit) async {
        try 
        {
            words.add(event.word);
            repository.setWords(toMap());
            emit(WordsLoaded(words));
        } 
        catch (_) 
        {
            emit(const WordsError());
        }
    }

    void _onDeleteItem(WordsDeleteItem event, Emitter<WordsState> emit) async {
        try 
        {
            words.remove(event.word);
            repository.setWords(toMap());
            emit(WordsLoaded(words));
        } 
        catch (_) 
        {
            emit(const WordsError());
        }
    }

    List<Map> toMap()
    {
        List<Map> map = [];
        
        for (var word in words) {
            map.add(word.toMap());
        }

        return map;
    }
}
