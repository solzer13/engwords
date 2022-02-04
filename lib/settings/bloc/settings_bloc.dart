import 'package:bloc/bloc.dart';
import 'package:engwords/data_provider.dart';
import 'package:engwords/settings/settings.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> 
{
    final DataProvider provider;

    Settings settings = Settings.fromMap({});

    SettingsBloc({required this.provider}) : super(const SettingsInitial()) 
    {
        on<SettingsStarted>(_onStarted);
        on<SettingsChange>(_onChange);
        on<SettingsChangeEnd>(_onChangeEnd);
    }
    
    void _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async 
    {
        emit(const SettingsLoading());
        settings = Settings.fromMap(await provider.getAllData());
        emit(SettingsLoaded(settings: settings));
    }
    
    void _onChange(SettingsChange event, Emitter<SettingsState> emit) async 
    {
        emit(SettingsLoaded(settings: settings));
    }

    void _onChangeEnd(SettingsChangeEnd event, Emitter<SettingsState> emit) async 
    {
        await provider.writeAllData(settings.toMap());
        emit(SettingsLoaded(settings: settings));
    }
}
