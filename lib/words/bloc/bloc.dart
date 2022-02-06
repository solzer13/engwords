
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

    WordsBloc({required this.provider, required this.settingsBloc}) : super(const WordsBlocStateInitial()) {
        on<WordsBlocEventStarted>(_onStarted);
        on<WordsBlocEventSettingsLoaded>(_onSettingsLoadedState);
        on<WordsBlocEventCheckboxChange>(_onCheckboxChange);
        on<WordsBlocEventCheckboxChangeAll>(_onCheckboxChangeAll);
        on<WordsBlocEventSortAbc>(_onSortAbc);
        on<WordsBlocEventSortRepeat>(_onSortRepeat);
        on<WordsBlocEventChangeLearned>(_onChangeLearned);
        on<WordsBlocEventAddItem>(_onAddItem);
        on<WordsBlocEventDelete>(_onDelete);
    }
    
    FutureOr<void> _onStarted(WordsBlocEventStarted event, Emitter<WordsBlocState> emit) async 
    {
        try
        {
            emit(const WordsBlocStateLoading());
            settingsBloc.stream.listen((state) async { 
                if(state is SettingsLoaded){
                    add(WordsBlocEventSettingsLoaded(stateSettingsLoaded: state));
                }
            });
        }
        catch(e)
        {
            addError(Exception('increment error!'), StackTrace.current);
        }
    }

    FutureOr<void> _onSettingsLoadedState(WordsBlocEventSettingsLoaded event, Emitter<WordsBlocState> emit) async 
    {
        try
        {
            words.clear();
            var data = await provider.getAllData();
            for (var wordMap in data["words"]??[]) {
                words.add(WordsModel.fromMap(wordMap));
            }
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(e)
        {
            addError(e, StackTrace.current);
        }
    }

    FutureOr<void> _onCheckboxChange(WordsBlocEventCheckboxChange event, Emitter<WordsBlocState> emit) 
    {
        try
        {
            event.word.checked = event.checked;
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(e)
        {
            addError(e, StackTrace.current);
        }
    }

    FutureOr<void> _onCheckboxChangeAll(WordsBlocEventCheckboxChangeAll event, Emitter<WordsBlocState> emit) 
    {
        try
        {
            for (var word in words) {
                word.checked = event.checked;
            }
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(e)
        {
            addError(e, StackTrace.current);
        }
    }

    FutureOr<void> _onSortAbc(WordsBlocEventSortAbc event, Emitter<WordsBlocState> emit) 
    {
        try
        {
            words.sort((a, b) {
                return a.eng.compareTo(b.eng);
            });
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(e)
        {
            addError(e, StackTrace.current);
        }
    }

    FutureOr<void> _onSortRepeat(WordsBlocEventSortRepeat event, Emitter<WordsBlocState> emit) 
    {
        try
        {
            words.sort((a, b) {
                return a.repeat.compareTo(b.repeat);
            });
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(e)
        {
            addError(e, StackTrace.current);
        }
    }

    FutureOr<void> _onChangeLearned(WordsBlocEventChangeLearned event, Emitter<WordsBlocState> emit) async
    {
        try
        {
            for (var word in words) {
                if(word.checked)
                {
                    word.repeat = event.learned ? settingsBloc.settings.countRepeatWord : 0;
                    word.checked = false;
                }
            }
            await provider.writeAllData(toMap());
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(exception)
        {
            addError(exception, StackTrace.current);
        }
    }
    
    FutureOr<void> _onAddItem(WordsBlocEventAddItem event, Emitter<WordsBlocState> emit) async 
    {
        try
        {
            words.add(event.word);
            await provider.writeAllData(toMap());
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(exception)
        {
            addError(exception, StackTrace.current);
        }
    }

    FutureOr<void> _onDelete(WordsBlocEventDelete event, Emitter<WordsBlocState> emit) async 
    {
        try
        {
            for (var word in words.toList()) {
                if(word.checked)
                {
                    words.remove(word);
                }
            }
            await provider.writeAllData(toMap());
            emit(WordsBlocStateLoaded(words: words));
        }
        catch(exception)
        {
            addError(exception, StackTrace.current);
        }
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
