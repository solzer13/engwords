
part of 'main_page.dart';

class MainBottomNawigationWidget extends StatelessWidget
{
    const MainBottomNawigationWidget({Key? key}) : super(key: key);

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
            currentIndex: 0,
            selectedItemColor: Colors.blue,
            onTap: (int index) {}
        );
    }
}