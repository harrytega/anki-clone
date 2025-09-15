import 'package:isar/isar.dart';
part 'card_deck.g.dart';

@collection
class CardDeck {
  Id id = Isar.autoIncrement;
  late String name;
}