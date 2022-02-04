
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:engwords/data_provider.dart';
import 'package:engwords/words/words.dart';
import 'package:engwords/settings/settings.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

    final DataProvider _provider;
    Map<String, dynamic> _data = {};
    final List<Word> _words = [];

    WordsBloc(this._provider) : super(const WordsInitial()) {
        on<WordsStarted>(_onStarted);
        on<WordsAddItem>(_onAddItem);
        on<WordsEditItem>(_onEditItem);
        on<WordsDeleteItem>(_onDeleteItem);
    }
    
    void _onStarted(WordsStarted event, Emitter<WordsState> emit) async 
    {
        emit(const WordsLoading());
        
        try 
        {
            _data = await _provider.getAllData();
            
            for (var wordMap in _data["words"]??[]) {
                _words.add(Word.fromMap(wordMap));
            }

            emit(WordsLoaded(
                settings: event.settings,
                words: this,
            ));
        } 
        catch (_) 
        {
            emit(const WordsError());
        }
    }

    void _onAddItem(WordsAddItem event, Emitter<WordsState> emit) async 
    {
        try 
        {
            _words.add(event.word);
            repository.setWords(toMap());
            emit(_loadedState);
        } 
        catch (_) 
        {
            emit(const WordsError());
        }
    }

    FutureOr<void> _onEditItem(WordsEditItem event, Emitter<WordsState> emit) 
    {
        //var wordItem = words.firstWhere((word) => word.id == event.word.id);
        //wordItem = event.word;
        
        repository.setWords(toMap());
    }

    void _onDeleteItem(WordsDeleteItem event, Emitter<WordsState> emit) async 
    {
        try 
        {
            words.remove(event.word);
            repository.setWords(toMap());
            emit(_loadedState);
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
