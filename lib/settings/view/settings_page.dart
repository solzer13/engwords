
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/settings/settings.dart';

class SettingsWidgetList extends StatelessWidget 
{
    final SettingsBloc settings;

    const SettingsWidgetList({Key? key, required this.settings}) : super(key: key);

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
                    style: TextStyle(fontSize: 20)
                ),
                Slider(
                    value: settings.countRepeatWord.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: settings.countRepeatWord.round().toString(),
                    onChanged: (double value) {
                        settings.countRepeatWord = value.toInt();
                        settings.add(const SettingsChange());
                    },
                    onChangeEnd: (double val) => settings.add(const SettingsChangeEnd()),
                ),
            ],
        );
    }

    Widget counVarians(){
        return Column(
            children: [
                Container(height: 10,),
                const Text("Колличество вариантов на странице",
                    style: TextStyle(fontSize: 20)
                ),
                Slider(
                    value: settings.counVariants.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: settings.counVariants.toString(),
                    onChanged: (double value) {
                        settings.counVariants = value.toInt();
                        settings.add(const SettingsChange());
                    },
                    onChangeEnd: (double val) => settings.add(const SettingsChangeEnd()),
                ),
            ]
        );
    }

    Widget countWordsLern(){
        return Column(
            children: [
                Container(height: 10,),
                const Text("Колличество изучаемых слов",
                    style: TextStyle(fontSize: 20)
                ),
                Slider(
                    value: settings.countWordsLearn.toDouble(),
                    min: 5,
                    max: 100,
                    divisions: 19,
                    label: settings.countWordsLearn.toString(),
                    onChanged: (double value) {
                        settings.countWordsLearn = value.toInt();
                        settings.add(const SettingsChange());
                    },
                    onChangeEnd: (double val) => settings.add(const SettingsChangeEnd()),
                ),
            ],
        );
    }
}

class SettingsWidget extends StatelessWidget
{
    const SettingsWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return BlocBuilder<SettingsBloc, SettingsState>(
            builder: (context, state) {
                if (state is SettingsLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is SettingsLoaded) 
                {
                    return SettingsWidgetList(
                        settings: state.settings,
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );

    }
}
