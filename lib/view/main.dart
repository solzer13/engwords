import 'package:flutter/material.dart';
import 'words.dart';
import 'cards.dart';
import 'settings.dart';

class MainWidget extends StatefulWidget 
{
    const MainWidget({Key? key}) : super(key: key);

    @override
    State<MainWidget> createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> 
{
    int _selectedIndex = 0;

    static Map<String, Widget> pages = 
    {
        'Words'    : const WordsWidget(),
        'Cards'    : const CardsWidget(),
        'Settings' : const SettingsWidget(),
    };

    @override
    Widget build(BuildContext context) 
    {
        return Scaffold(
            appBar: AppBar(
                title: Text(pages.keys.toList()[_selectedIndex]),
            ),
            body: Center(
                child: pages.values.toList()[_selectedIndex]
            ),
            bottomNavigationBar: BottomNavigationBar(
                items: const <BottomNavigationBarItem>
                [
                    BottomNavigationBarItem(
                        icon: Icon(Icons.list),
                        label: 'Words',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.featured_play_list_outlined),
                        label: 'Cards',
                    ),
                    BottomNavigationBarItem(
                        icon: Icon(Icons.settings),
                        label: 'Settings',
                    ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.blue,
                onTap: (int index) 
                {
                    setState(() {
                        _selectedIndex = index;
                    });
                }
            ),
        );
    }
}