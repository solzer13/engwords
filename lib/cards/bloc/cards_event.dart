part of 'cards_bloc.dart';

abstract class CardsEvent {
    const CardsEvent();
}

class CardsStarted extends CardsEvent {
    const CardsStarted();
}

class WordsLoadedState extends CardsEvent{
    final WordsLoaded stateWordsLoaded;
    const WordsLoadedState({required this.stateWordsLoaded});
}

class CardsNextCard extends CardsEvent{
    final Card oldCard;
    const CardsNextCard({required this.oldCard});
}

class CardsPressVariant extends CardsEvent{
    final Variant variant;
    const CardsPressVariant({required this.variant});
}
