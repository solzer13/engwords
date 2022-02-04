part of 'cards_bloc.dart';

abstract class CardsEvent {
    const CardsEvent();
}

class CardsStarted extends CardsEvent {
    const CardsStarted();
}

class CardsNextCard extends CardsEvent
{
    final Card oldCard;
    const CardsNextCard(this.oldCard);
}

class CardsPressVariant extends CardsEvent
{
    final Variant variant;
    const CardsPressVariant(this.variant);
}
