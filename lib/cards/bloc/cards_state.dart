part of 'cards_bloc.dart';

abstract class CardsState {
    const CardsState();
}

class CardsInitial extends CardsState {
    const CardsInitial();
}

class CardsLoading extends CardsState {
    const CardsLoading();
}

class CardsLoaded extends CardsState {
    final List<Word> cards;
    const CardsLoaded(this.cards);
}

class CardsError extends CardsState {
    const CardsError();
}