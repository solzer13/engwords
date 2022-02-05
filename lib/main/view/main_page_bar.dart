
part of 'main_page.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget
{
    const MainAppBarWidget({Key? key, required this.title}) : super(key: key);

    final String title;

    @override
    Size get preferredSize => const Size.fromHeight(60);

    @override
    Widget build(BuildContext context) 
    {
        return AppBar(
            centerTitle: false,
            title: Text(title),
        );
        
    }

}