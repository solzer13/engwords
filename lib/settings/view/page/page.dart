
import 'package:engwords/interface_view_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:engwords/settings/settings.dart';

part 'list.dart';

class SettingsViewPage extends StatelessWidget implements ViewPageInterface
{
    @override
    String get title => "Settings";

    @override
    BottomNavigationBarItem get button => const BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
    );

    @override
    List<IconButton> get actions => [];

    const SettingsViewPage({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return BlocBuilder<SettingsBloc, SettingsBlocState>(
            builder: (context, state) {
                if (state is SettingsLoading) 
                {
                    return const Center(child: CircularProgressIndicator());
                }
                if (state is SettingsLoaded) 
                {
                    return SettingsViewPageList(
                        settingsBloc: context.read<SettingsBloc>(),
                        settings: state.settings,
                    );
                }
                return const Center(child: Text('Something went wrong!'));
            },
        );

    }
}
