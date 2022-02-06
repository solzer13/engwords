
part of 'page.dart';

class SettingsViewPageList extends StatelessWidget 
{
    final SettingsBloc settingsBloc;
    final SettingsModel settings;

    const SettingsViewPageList({Key? key, required this.settings, required this.settingsBloc}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return ListView(
            children: [
                countRepeatWord(),
                counVarians(),
                countWordsLern()
            ],
        );
    }

    Widget countRepeatWord(){
        return Column(
            children: [
                Container(height: 10,),
                const Text("Колличество повторений для слова",
                    style: TextStyle(fontSize: 18)
                ),
                Slider(
                    value: settings.countRepeatWord.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: settings.countRepeatWord.toString(),
                    onChanged: (double value) {
                        settings.countRepeatWord = value.toInt();
                        settingsBloc.add(const SettingsChange());
                    },
                    onChangeEnd: (double val) => settingsBloc.add(const SettingsChangeEnd()),
                ),
            ],
        );
    }

    Widget counVarians(){
        return Column(
            children: [
                Container(height: 10,),
                const Text("Колличество вариантов на странице",
                    style: TextStyle(fontSize: 18)
                ),
                Slider(
                    value: settings.counVariants.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: settings.counVariants.toString(),
                    onChanged: (double value) {
                        settings.counVariants = value.toInt();
                        settingsBloc.add(const SettingsChange());
                    },
                    onChangeEnd: (double val) => settingsBloc.add(const SettingsChangeEnd()),
                ),
            ]
        );
    }

    Widget countWordsLern(){
        return Column(
            children: [
                Container(height: 10),
                const Text("Колличество изучаемых слов",
                    style: TextStyle(fontSize: 18)
                ),
                Slider(
                    value: settings.countWordsLearn.toDouble(),
                    min: 5,
                    max: 100,
                    divisions: 19,
                    label: settings.countWordsLearn.toString(),
                    onChanged: (double value) {
                        settings.countWordsLearn = value.toInt();
                        settingsBloc.add(const SettingsChange());
                    },
                    onChangeEnd: (double val) => settingsBloc.add(const SettingsChangeEnd()),
                ),
            ],
        );
    }
}
