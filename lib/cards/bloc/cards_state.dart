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
    final Card card;
    const CardsLoaded(this.card);
}

class CardsError extends CardsState {
    final String message;
    const CardsError(this.message);
}