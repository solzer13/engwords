
part of 'main_page.dart';

class MainBodyWidget extends StatelessWidget
{
    const MainBodyWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return Center(
            child: WordsWidget()
        );
        
    }
}