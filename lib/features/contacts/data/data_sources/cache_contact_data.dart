import 'package:contact_box/core/constants/db_field_name_constants.dart';
import 'package:contact_box/features/contacts/data/models/contact_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

abstract class CacheContactData {
  Future<List<ContactModel>> getAllContacts();
  Future<void> addContact(ContactModel contact);
}

class CacheContactDataImpl implements CacheContactData {
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
    final path = join(dbPath, 'contacts.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE contacts(
        $dbContactId TEXT PRIMARY KEY,
        $dbContactPersonAddress TEXT,
        $dbContactPersonImage TEXT,
        $dbContactPersonFName TEXT,
        $dbContactPersonLName TEXT,
        $dbContactPersonNumber TEXT
        $dbContactCountry TEXT
        $dbContactFullName TEXT
        )
      ''');
      },
    );
  }

  @override
  Future<void> addContact(ContactModel contact) async {
    final db = await database;
    await db.insert(
      'contacts',
      contact.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<List<ContactModel>> getAllContacts() async {
    final db = await database;
    final contacts = await db.query('contacts');
    return contacts.map((json) => ContactModel.fromJson(json)).toList();
  }
}
