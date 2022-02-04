import 'package:bloc/bloc.dart';
import 'package:engwords/cards/cards.dart';
import 'package:engwords/file_data_provider.dart';
import 'package:engwords/settings/settings.dart';
import 'package:engwords/words/words.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> 
{
    late SettingsBloc blocSettings;
    late WordsBloc blocWords;
    late CardsBloc blocCards;

    MainBloc() : super(const MainInitial()) 
    {
        blocSettings = SettingsBloc(
            provider: FileDataProvider("settings.txt")
        );

        blocWords = WordsBloc(
            provider: FileDataProvider("words.txt"), 
            settingsBloc: blocSettings
        );

        blocCards = CardsBloc(
            settingsBloc: blocSettings, 
            wordsBloc: blocWords
        );

        on<MainStarted>(_onStarted);
    }

    Future<void> _onStarted(event, emit) async 
    {
        blocSettings.add(const SettingsStarted());
        blocWords.add(const WordsStarted());
        blocCards.add(const CardsStarted());
    }
}
