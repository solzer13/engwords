import 'package:flutter/material.dart';
import 'view/main.dart';
import 'data/dto/json_file.dart' as dto;

void main() => runApp(const App());


class App extends StatelessWidget 
{
    const App({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        dto.init();
        
        return const MaterialApp(
            home: MainWidget(),
        );
    }
}

