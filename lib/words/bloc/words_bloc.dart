
import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:engwords/repository.dart';
import 'package:engwords/words/words.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

    final Repository repository;
    final SettingsBloc settingsBloc;

    final List<Word> words = [];

    Settings? settings;
    
    WordsBloc({required this.repository, required this.settingsBloc}) : super(const WordsInitial()) {
        on<WordsStarted>(_onStarted);
        on<WordsSettingsLoaded>(_onSettingsLoaded);
        on<WordsAddItem>(_onAddItem);
        on<WordsEditItem>(_onEditItem);
        on<WordsDeleteItem>(_onDeleteItem);
    }
    
    FutureOr<void> _onSettingsLoaded(WordsSettingsLoaded event, Emitter<WordsState> emit) async
    {
        settings = event.settings;

        try 
        {
            words.clear();
            
            List<dynamic> wordsMap = await repository.getWords();

            for (var wordMap in wordsMap) {
                words.add(Word.fromMap(wordMap));
            }

            emit(_loadedState);
        } 
        catch (_) 
        {
            emit(const WordsError());
        }
    }
    
    void _onStarted(WordsStarted event, Emitter<WordsState> emit) async 
    {
        emit(const WordsLoading());
        
        settingsBloc.stream.listen((state) { 
            if (state is SettingsLoaded) {
                add(WordsSettingsLoaded(state.settings));
            } 
        });
    }

    void _onAddItem(WordsAddItem event, Emitter<WordsState> emit) async 
    {
        try 
        {
            words.add(event.word);
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

    get _loadedState
    {
        return WordsLoaded(words, settings!);
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
