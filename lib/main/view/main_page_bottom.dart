
part of 'main_page.dart';

class MainBottomNawigationWidget extends StatelessWidget
{
    final int selectedIndex;
    final List<ViewPageInterface> pages;

    const MainBottomNawigationWidget({Key? key, required this.selectedIndex, required this.pages}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return BottomNavigationBar(
            items: _getBarItems(),
            currentIndex: selectedIndex,
            selectedItemColor: Colors.blue,
            onTap: (int index) { 
                context.read<MainBloc>().add(MainPageChange(newIndex: index)); 
            }
        );
    }

    List<BottomNavigationBarItem> _getBarItems()
    {
        List<BottomNavigationBarItem> items = [];
        for (var page in pages) {
            items.add(page.button);
        }
        return items;
    }
}