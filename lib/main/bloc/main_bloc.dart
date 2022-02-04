import 'package:bloc/bloc.dart';
import 'package:engwords/cards/cards.dart';
import 'package:engwords/file_data_provider.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> 
{
    SettingsBloc blocSettings = SettingsBloc(FileDataProvider("settings.txt"));
    WordsBloc blocWords = WordsBloc(FileDataProvider("words.txt"));
    CardsBloc blocCards = CardsBloc();

    MainBloc() : super(const MainInitial()) 
    {
        on<MainStarted>(_onStarted);
    }

    Future<void> _onStarted(event, emit) async 
    {
        blocSettings.add(const SettingsStarted());
        blocSettings.stream.listen((state) {
            if(state is SettingsLoaded){
                blocWords.add(WordsStarted(blocSettings));
                blocWords.stream.listen((state) { 
                    if(state is WordsLoaded){
                        blocCards.add(CardsStarted(blocSettings, blocWords));
                        emit(const MainLoaded());
                    }
                });
            }
        });
    }
}
