
part of 'main_page.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget
{
    const MainAppBarWidget({Key? key}) : super(key: key);

    @override
    Size get preferredSize => Size.fromHeight(100);

    @override
    Widget build(BuildContext context) 
    {
        return AppBar(
            centerTitle: true,
            title: Text("Example"),
        );
        
    }

}