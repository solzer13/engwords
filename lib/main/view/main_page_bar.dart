
part of 'main_page.dart';

class MainAppBarWidget extends StatelessWidget implements PreferredSizeWidget
{
    final ViewPageInterface page;

    const MainAppBarWidget({Key? key, required this.page}) : super(key: key);

    @override
    Size get preferredSize => const Size.fromHeight(60);

    @override
    Widget build(BuildContext context) 
    {
        return AppBar(
            centerTitle: false,
            title: Text(page.title),
            actions: page.actions,
        );
        
    }

}