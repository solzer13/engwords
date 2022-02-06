part of 'bloc.dart';

abstract class CardsBlocState {
    const CardsBlocState();
}

class CardsInitial extends CardsBlocState {
    const CardsInitial();
}

class CardsLoading extends CardsBlocState {
    const CardsLoading();
}

class CardsLoaded extends CardsBlocState {
    final CardsModel card;
    const CardsLoaded({required this.card});
}

class CardsError extends CardsBlocState {
    final String message;
    const CardsError({required this.message});
}
