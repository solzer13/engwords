
import 'package:bloc/bloc.dart';
import 'package:engwords/repository/providers/data_provider.dart';

part 'repository_settings_event.dart';
part 'repository_settings_state.dart';

class RepositorySettingsBloc extends Bloc<RepositorySettingsEvent, RepositorySettingsState> 
{
    final DataProvider _provider;
    Map<String, dynamic> _data = {};

    /// Колличество слов для изучения
    set countWordsLearn(int value) => add(RepositorySettingsUpdate(key: "countWordsLearn", value: value));
    int get countWordsLearn {
        return _data["countWordsLearn"] ?? 10;
    } 

    /// Колличество вариантов на странице
    set counVariants(int value) => add(RepositorySettingsUpdate(key: "counVariants", value: value));
    int get counVariants { 
        return _data["counVariants"] ??  5;
    }

    /// Колличество повторений для слова
    set countRepeatWord(int value) => add(RepositorySettingsUpdate(key: "countRepeatWord", value: value));
    int get countRepeatWord {
        return _data["countRepeatWord"] ??  5;
    }

    RepositorySettingsBloc(this._provider) : super(RepositorySettingsInitial()) 
    {
        on<RepositorySettingsLoad>((event, emit) async {
            emit(RepositorySettingsLoading());
            _data = await _provider.getAllData();
            emit(RepositorySettingsLoaded());
        });
        
        on<RepositorySettingsUpdate>((event, emit) async {
            _data[event.key] = event.value;
            await _provider.writeAllData(_data);
            emit(RepositorySettingsLoaded());
        });
    }
}
