import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/features/contacts/data/models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class CacheFavData {
  Future<List<ContactModel>> getAllFavorites();
  Future<void> addFav(ContactModel contact);
}

class CacheFavDataImpl implements CacheFavData {
  static Database? _database;

  // Initialize and get database
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

// Initialize the database
  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE favorites(
        $dbFavId TEXT PRIMARY KEY,
        $dbFavContactId TEXT,
        )
      ''');
      },
    );
  }

  @override
  Future<void> addFav(ContactModel contact) async {
    final db = await database;
    await db.insert(
      'favorites',
      contact.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<ContactModel>> getAllFavorites() async {
    final db = await database;
    final contacts = await db.query('favorites');
    return contacts.map((json) => ContactModel.fromJson(json)).toList();
  }
}
