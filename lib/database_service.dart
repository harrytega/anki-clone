import 'package:anki_clone/feature/card-deck/models/card_deck.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseService {
  static Isar? _isar;

  static Future<Isar> get instance async {
    if (_isar != null) return _isar!;

    _isar = await _initDatabase();
    return _isar!;
  }

  static Future<Isar> _initDatabase() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([CardDeckSchema], directory: dir.path, name: 'anki_clone_db');
  }
}
