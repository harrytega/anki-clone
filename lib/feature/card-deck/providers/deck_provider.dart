import 'package:anki_clone/deck_repository.dart';
import 'package:anki_clone/feature/card-deck/models/card_deck.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'deck_provider.g.dart';

@riverpod
class AllDecks extends _$AllDecks {
  final deckRepo = DeckRepository();
  @override
  Future<List<CardDeck>> build() async => await deckRepo.getAllDecks();
}
