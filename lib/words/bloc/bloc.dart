
import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:engwords/interface_data_provider.dart';
import 'package:engwords/words/words.dart';
import 'package:engwords/settings/settings.dart';

part 'event.dart';
part 'state.dart';

class WordsBloc extends Bloc<WordsBlocEvent, WordsBlocState> {

    final DataProviderInterface provider;
    final SettingsBloc settingsBloc;

    final List<WordsModel> words = [];


    WordsBloc({required this.provider, required this.settingsBloc}) : super(const WordsInitial()) {
        on<WordsStarted>(_onStarted);
        on<SettingsLoadedState>(_onSettingsLoadedState);
        on<WordsCheckboxChange>(_onCheckboxChange);
        on<WordsAddItem>(_onAddItem);
        on<WordsEditItem>(_onEditItem);
        on<WordsDeleteItem>(_onDeleteItem);
    }
    
    void _onStarted(WordsStarted event, Emitter<WordsBlocState> emit) async 
    {
        emit(const WordsLoading());

        try
        {
            settingsBloc.stream.listen((state) async { 
                if(state is SettingsLoaded){
                    add(SettingsLoadedState(stateSettingsLoaded: state));
                }
            });
        }
        catch(e)
        {
            addError(Exception('increment error!'), StackTrace.current);
        }
    }

    void _onSettingsLoadedState(SettingsLoadedState event, Emitter<WordsBlocState> emit) async 
    {
        try
        {
            words.clear();
            var data = await provider.getAllData();
            for (var wordMap in data["words"]??[]) {
                words.add(WordsModel.fromMap(wordMap));
            }
            emit(WordsLoaded(words: words));
        }
        catch(e)
        {
            addError(e, StackTrace.current);
        }
    }

    FutureOr<void> _onCheckboxChange(WordsCheckboxChange event, Emitter<WordsBlocState> emit) 
    {
        event.word.checkbox = event.checked;
        emit(WordsLoaded(words: words));
    }

    void _onAddItem(WordsAddItem event, Emitter<WordsBlocState> emit) async 
    {
        try
        {
            words.add(event.word);
            await provider.writeAllData(toMap());
            emit(WordsLoaded(words: words));
        }
        catch(e)
        {
            addError(e, StackTrace.current);
        }
    }

    FutureOr<void> _onEditItem(WordsEditItem event, Emitter<WordsBlocState> emit) async
    {
        await provider.writeAllData(toMap());
        emit(WordsLoaded(
            words: words,
        ));
    }

    void _onDeleteItem(WordsDeleteItem event, Emitter<WordsBlocState> emit) async 
    {
        words.remove(event.word);
        await provider.writeAllData(toMap());
        emit(WordsLoaded(
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
