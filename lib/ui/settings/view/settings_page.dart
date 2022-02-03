
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/settings/settings.dart';

class SettingsWidgetList extends StatelessWidget {
    final Bloc bloc;
    final Settings settings;

    const SettingsWidgetList({Key? key, required this.bloc, required this.settings}) : super(key: key);

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
                    value: settings.countRepeatWord,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: settings.countRepeatWord.round().toString(),
                    onChanged: (double value) {
                        settings.countRepeatWord = value;
                        bloc.add(SettingsChange(settings));
                    },
                    onChangeEnd: (double val) => bloc.add(SettingsChangeEnd(settings)),
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
                    value: settings.counVarians,
                    min: 1,
                    max: 10,
                    divisions: 9,
                    label: settings.counVarians.round().toString(),
                    onChanged: (double value) {
                        settings.counVarians = value;
                        bloc.add(SettingsChange(settings));
                    },
                    onChangeEnd: (double val) => bloc.add(SettingsChangeEnd(settings)),
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
                    value: settings.countWordsLern,
                    min: 5,
                    max: 100,
                    divisions: 19,
                    label: settings.countWordsLern.round().toString(),
                    onChanged: (double value) {
                        settings.countWordsLern = value;
                        bloc.add(SettingsChange(settings));
                    },
                    onChangeEnd: (double val) => bloc.add(SettingsChangeEnd(settings)),
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
                        bloc: context.read<SettingsBloc>(),
                        settings: state.settings,
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );

    }
}
