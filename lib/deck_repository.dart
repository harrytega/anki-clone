import 'package:anki_clone/database_service.dart';
import 'package:anki_clone/feature/card-deck/models/card_deck.dart';
import 'package:isar/isar.dart';

class DeckRepository {
  Future<List<CardDeck>> getAllDecks() async {
    final db = await DatabaseService.instance;
    return db.cardDecks.where().findAll();
  }

  Future<CardDeck> createDeck(String name) async {
    final db = await DatabaseService.instance;
    final deck = CardDeck()..name = name;
    await db.writeTxn(() async {
      await db.cardDecks.put(deck);
    });
    return deck;
  }

  Future<bool> deleteDeck(Id id) async {
    final db = await DatabaseService.instance;
    return await db.writeTxn(() async {
      return await db.cardDecks.delete(id);
    });
  }
}
