
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:engwords/data_provider.dart';
import 'package:engwords/words/words.dart';
import 'package:engwords/settings/settings.dart';

part 'words_event.dart';
part 'words_state.dart';

class WordsBloc extends Bloc<WordsEvent, WordsState> {

    final DataProvider provider;
    final SettingsBloc settingsBloc;

    final List<Word> words = [];


    WordsBloc({required this.provider, required this.settingsBloc}) : super(const WordsInitial()) {
        on<WordsStarted>(_onStarted);
        on<WordsAddItem>(_onAddItem);
        on<WordsEditItem>(_onEditItem);
        on<WordsDeleteItem>(_onDeleteItem);
    }
    
    void _onStarted(WordsStarted event, Emitter<WordsState> emit) async 
    {
        emit(const WordsLoading());

        settingsBloc.stream.listen((state) async { 
            if(state is SettingsLoaded){
                var data = await provider.getAllData();
                for (var wordMap in data["words"]??[]) {
                    words.add(Word.fromMap(wordMap));
                }
                emit(WordsLoaded(
                    settings: state.settings,
                    words: words,
                ));
            }
        });
    }

    void _onAddItem(WordsAddItem event, Emitter<WordsState> emit) async 
    {
        words.add(event.word);
        await provider.writeAllData(toMap());
        emit(WordsLoaded(
            settings: settingsBloc.settings,
            words: words,
        ));
    }

    FutureOr<void> _onEditItem(WordsEditItem event, Emitter<WordsState> emit) async
    {
        await provider.writeAllData(toMap());
        emit(WordsLoaded(
            settings: settingsBloc.settings,
            words: words,
        ));
    }

    void _onDeleteItem(WordsDeleteItem event, Emitter<WordsState> emit) async 
    {
        words.remove(event.word);
        await provider.writeAllData(toMap());
        emit(WordsLoaded(
            settings: settingsBloc.settings,
            words: words,
        ));
    }

    Map<String,dynamic> toMap()
    {
        Map<String,dynamic> map = {"words":[]};
        
        for (var word in words) {
            map["words"].add(word.toMap());
        }

        return map;
    }

}
