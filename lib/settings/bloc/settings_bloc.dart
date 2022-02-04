import 'package:bloc/bloc.dart';
import 'package:engwords/data_provider.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> 
{
    final DataProvider _provider;

    Map<String, dynamic> _data = {};

    /// Колличество слов для изучения
    set countWordsLearn(int value) => add(SettingsUpdate(key: "countWordsLearn", value: value));
    int get countWordsLearn {
        return _data["countWordsLearn"] ?? 10;
    } 

    /// Колличество вариантов на странице
    set counVariants(int value) => add(SettingsUpdate(key: "counVariants", value: value));
    int get counVariants { 
        return _data["counVariants"] ??  5;
    }

    /// Колличество повторений для слова
    set countRepeatWord(int value) => add(SettingsUpdate(key: "countRepeatWord", value: value));
    int get countRepeatWord {
        return _data["countRepeatWord"] ??  5;
    }

    SettingsBloc(this._provider) : super(const SettingsInitial()) 
    {
        on<SettingsStarted>(_onStarted);
        on<SettingsChange>(_onChange);
        on<SettingsChangeEnd>(_onChangeEnd);

        on<SettingsUpdate>((event, emit) async {
            _data[event.key] = event.value;
            await _provider.writeAllData(_data);
            emit(SettingsLoaded(this));
        });
    }
    
    void _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async 
    {
        emit(const SettingsLoading());

        try 
        {
            _data = await _provider.getAllData();
            emit(SettingsLoaded(this));
        } 
        catch (_) 
        {
            emit(const SettingsError());
        }
    }
    
    void _onChange(SettingsChange event, Emitter<SettingsState> emit) async 
    {
        emit(SettingsLoaded(this));
    }

    void _onChangeEnd(SettingsChangeEnd event, Emitter<SettingsState> emit) async 
    {
        try 
        {
            await _provider.writeAllData(_data);
            emit(SettingsLoaded(this));
        } 
        catch (_) 
        {
            emit(const SettingsError());
        }
    }
}
