
part of 'main_page.dart';

class MainBottomNawigationWidget extends StatelessWidget
{
    //MainWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return BottomNavigationBar(
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
        );
    }
}