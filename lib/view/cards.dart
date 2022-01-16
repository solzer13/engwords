import 'package:flutter/material.dart';

class CardsWidget extends StatelessWidget 
{
    const CardsWidget({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) 
    {
        return const Scaffold(
            body: Center(
                child: Text('Press the button with a label below!'),
            ),
        );
    }
}