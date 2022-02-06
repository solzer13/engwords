part of 'bloc.dart';

abstract class CardsBlocEvent {
    const CardsBlocEvent();
}

class CardsStarted extends CardsBlocEvent {
    const CardsStarted();
}

class WordsLoadedState extends CardsBlocEvent{
    final WordsBlocStateLoaded stateWordsLoaded;
    const WordsLoadedState({required this.stateWordsLoaded});
}

class CardsNextCard extends CardsBlocEvent{
    final CardsModel oldCard;
    const CardsNextCard({required this.oldCard});
}

class CardsPressVariant extends CardsBlocEvent{
    final CardsModelVariant variant;
    const CardsPressVariant({required this.variant});
}
