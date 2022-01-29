part of 'cards_bloc.dart';

abstract class CardsEvent 
{
    const CardsEvent();
}

class CardsStarted extends CardsEvent
{
    const CardsStarted();
}
