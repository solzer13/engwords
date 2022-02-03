import 'package:bloc/bloc.dart';
import 'package:engwords/repository/repository.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> 
{
    RepositorySettingsBloc settings;
    
    SettingsBloc({required this.settings}) : super(const SettingsInitial()) 
    {
        on<SettingsStarted>(_onStarted);
        on<SettingsChange>(_onChange);
        on<SettingsChangeEnd>(_onChangeEnd);
    }
    
    void _onStarted(SettingsStarted event, Emitter<SettingsState> emit) async 
    {
        emit(const SettingsLoading());

        settings.stream.listen((event) { });

        try 
        {
            settings = Settings.fromMap(await repository.getSettings());
            emit(SettingsLoaded(settings));
        } 
        catch (_) 
        {
            emit(const SettingsError());
        }
    }
    
    void _onChange(SettingsChange event, Emitter<SettingsState> emit) async 
    {
        emit(SettingsLoaded(event.settings));
    }

    void _onChangeEnd(SettingsChangeEnd event, Emitter<SettingsState> emit) async 
    {
        try 
        {
            await repository.setSettings(event.settings.toMap());
            emit(SettingsLoaded(settings));
        } 
        catch (_) 
        {
            emit(const SettingsError());
        }
    }
}
