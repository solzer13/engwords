
import 'package:bloc/bloc.dart';
import 'package:engwords/data_provider.dart';

part 'repository_settings_event.dart';
part 'repository_settings_state.dart';

class RepositorySettingsBloc extends Bloc<RepositorySettingsEvent, RepositorySettingsState> 
{
    final DataProvider _provider;

    RepositorySettingsBloc(this._provider) : super(RepositorySettingsInitial()) 
    {
    }
}
