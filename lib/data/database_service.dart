import 'package:flutter_sqlite/model/category.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/music.dart';

class DatabaseService {
  // Singleton pattern
  static final DatabaseService _databaseService = DatabaseService._internal();
  factory DatabaseService() => _databaseService;
  DatabaseService._internal();

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database. Note: Using the `join` function from the
    // `path` package is best practice to ensure the path is correctly
    // constructed for each platform.
    final path = join(databasePath, 'musicas_collection.db');

    // Set the version. This executes the onCreate function and provides a
    // path to perform database upgrades and downgrades.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: 1,
    );
  }

  // When the database is first created, create a table to store category
  // and a table to store musics.
  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE {category} TABLE statement on the database.
    await db.execute('''
      CREATE TABLE music (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            title VARCHAR, 
            description TEXT,
            data DATETIME,
            categoryId INT,
            FOREIGN KEY (categoryId) REFERENCES category(id) ON DELETE SET NULL 
          )
          ''');
    // Run the CREATE {musics} TABLE statement on the database.
    await db.execute('''
          CREATE TABLE category (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name STRING NOT NULL,
            data DATETIME
          )
          ''');
  }

  // Define a function that inserts category into the database
  Future<void> insertCategory(Category category) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Insert the Category into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same category is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'category',
      category.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> insertMusic(Music music) async {
    final db = await _databaseService.database;
    await db.insert(
      'music',
      music.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    print("Adicionado com Sucesso");
  }

  // A method that retrieves all the category from the categorys table.
  Future<List<Category>> categorys() async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Query the table for all the Categorys.
    final List<Map<String, dynamic>> maps = await db.query('category');

    // Convert the List<Map<String, dynamic> into a List<Category>.
    return List.generate(
        maps.length, (index) => Category.fromJson(maps[index]));
  }

  Future<Category> category(int id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('category', where: 'id = ?', whereArgs: [id]);
    return Category.fromJson(maps[0]);
  }

  Future<List<Music>> musics() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('music');
    return List.generate(maps.length, (index) => Music.fromJson(maps[index]));
  }

  // A method that updates a category data from the categorys table.
  Future<void> updateCategory(Category category) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Update the given category
    await db.update(
      'category',
      category.toJson(),
      // Ensure that the Category has a matching id.
      where: 'id = ?',
      // Pass the Category's id as a whereArg to prevent SQL injection.
      whereArgs: [category.id],
    );
  }

  Future<void> updateMusic(Music music) async {
    final db = await _databaseService.database;
    await db.update('music', music.toJson(),
        where: 'id = ?', whereArgs: [music.id]);
  }

  // A method that deletes a category data from the categorys table.
  Future<void> deleteCategory(int id) async {
    // Get a reference to the database.
    final db = await _databaseService.database;

    // Remove the Category from the database.
    await db.delete(
      'category',
      // Use a `where` clause to delete a specific category.
      where: 'id = ?',
      // Pass the Category's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }

  Future<void> deleteMusic(int id) async {
    final db = await _databaseService.database;
    await db.delete('music', where: 'id = ?', whereArgs: [id]);
  }
}
