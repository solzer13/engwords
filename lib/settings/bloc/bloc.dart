import 'package:bloc/bloc.dart';
import 'package:engwords/interface_data_provider.dart';
import 'package:engwords/settings/settings.dart';

part 'event.dart';
part 'state.dart';

class SettingsBloc extends Bloc<SettingsBlocEvent, SettingsBlocState> 
{
    final DataProviderInterface provider;

    SettingsModel settings = SettingsModel.fromMap({});

    SettingsBloc({required this.provider}) : super(const SettingsInitial()) 
    {
        on<SettingsStarted>(_onStarted);
        on<SettingsChange>(_onChange);
        on<SettingsChangeEnd>(_onChangeEnd);
    }
    
    void _onStarted(SettingsStarted event, Emitter<SettingsBlocState> emit) async 
    {
        emit(const SettingsLoading());
        settings = SettingsModel.fromMap(await provider.getAllData());
        emit(SettingsLoaded(settings: settings));
    }
    
    void _onChange(SettingsChange event, Emitter<SettingsBlocState> emit) async 
    {
        emit(SettingsLoaded(settings: settings));
    }

    void _onChangeEnd(SettingsChangeEnd event, Emitter<SettingsBlocState> emit) async 
    {
        await provider.writeAllData(settings.toMap());
        emit(SettingsLoaded(settings: settings));
    }
}
