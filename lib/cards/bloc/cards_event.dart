part of 'cards_bloc.dart';

abstract class CardsEvent {
    const CardsEvent();
}

class CardsStarted extends CardsEvent{
    final SettingsBloc settings;
    final WordsBloc words;
    const CardsStarted(this.settings, this.words);
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

class CardsWordsLoaded extends CardsEvent
{
    final List<Word> words;
    const CardsWordsLoaded(this.words);
}

class CardsSettingsLoaded extends CardsEvent
{
    final Settings settings;
    const CardsSettingsLoaded(this.settings);
}