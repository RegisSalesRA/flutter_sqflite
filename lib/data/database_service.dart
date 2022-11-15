// ignore_for_file: depend_on_referenced_packages

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/model.dart';

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
    // Run the CREATE {music} TABLE statement on the database.
    await db.execute('''
      CREATE TABLE music (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name VARCHAR, 
            description TEXT,
            isFavorite BOOLEAN DEFAULT 0,
            data DATETIME,
            categoryId INT,
            albumId INT,
            FOREIGN KEY (categoryId) REFERENCES category(id) ON DELETE SET NULL,
            FOREIGN KEY (albumId) REFERENCES album(id) ON DELETE SET NULL
          )
          ''');
    // Run the CREATE {category} TABLE statement on the database.
    await db.execute('''
          CREATE TABLE category (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name STRING NOT NULL,
            data DATETIME
          )
          ''');

    // Run the CREATE {album} TABLE statement on the database.
    await db.execute('''
          CREATE TABLE album (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name STRING NOT NULL,
            data DATETIME
          )
          ''');
  }

// '''''''''''''''''''''''''''' MUSIC SERVICE ''''''''''''''''''''''''''''

  Future<void> insertMusic(Music music) async {
    final db = await _databaseService.database;
    await db.insert(
      'music',
      music.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Music>> musics() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('music');
    return List.generate(maps.length, (index) => Music.fromJson(maps[index]));
  }

  Future<void> updateMusic(Music music) async {
    final db = await _databaseService.database;
    await db.update('music', music.toJson(),
        where: 'id = ?', whereArgs: [music.id]);
  }

  Future<void> updateMusicFavorite(int value, int musicId) async {
    final db = await _databaseService.database;
    await db.rawUpdate(
        'UPDATE music SET isFavorite = ? WHERE id = ?', [value, musicId]);
  }

  Future<void> deleteMusic(int id) async {
    final db = await _databaseService.database;
    await db.delete('music', where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Music>> musicByCategoryId(int id) async {
    final db = await _databaseService.database;
    List<Map<String, dynamic>> maps =
        await db.query('music', where: 'categoryId = ?', whereArgs: [id]);
    return List.generate(maps.length, (index) => Music.fromJson(maps[index]));
  }

  Future<List<Music>> musicFavorite(int value) async {
    final db = await _databaseService.database;
    List<Map<String, dynamic>> maps =
        await db.query('music', where: 'isFavorite = ?', whereArgs: [value]);
    return List.generate(maps.length, (index) => Music.fromJson(maps[index]));
  }

// '''''''''''''''''''''''''''' MUSIC SERVICE END ''''''''''''''''''''''''''''

// '''''''''''''''''''''''''''' CATEGORY SERVICE ''''''''''''''''''''''''''''

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

  // A method that retrieves all the category from the categorys table.
  Future<List<Category>> categories() async {
    // Get a reference to the database.
    final db = await _databaseService.database;
    // Query the table for all the Categorys.
    final List<Map<String, dynamic>> maps = await db.query('category');
    // Convert the List<Map<String, dynamic> into a List<Category>.
    return List.generate(
        maps.length, (index) => Category.fromJson(maps[index]));
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

  Future category(int? id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('category', where: 'id = ?', whereArgs: [id]);

    if (id != 0) {
      return Category.fromJson(maps[0]);
    } else {
      return Category;
    }
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

// '''''''''''''''''''''''''''' CATEGORY SERVICE END ''''''''''''''''''''''''''''

// '''''''''''''''''''''''''''' ALBUM SERVICE ''''''''''''''''''''''''''''

  Future<void> insertAlbum(Album album) async {
    final db = await _databaseService.database;
    await db.insert(
      'album',
      album.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future album(int? id) async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps =
        await db.query('album', where: 'id = ?', whereArgs: [id]);

    if (id != 0) {
      return Album.fromJson(maps[0]);
    } else {
      return Album;
    }
  }

  Future<List<Album>> albums() async {
    final db = await _databaseService.database;
    final List<Map<String, dynamic>> maps = await db.query('album');
    return List.generate(maps.length, (index) => Album.fromJson(maps[index]));
  }

  Future<void> updateAlbum(Album album) async {
    final db = await _databaseService.database;
    await db.update('album', album.toJson(),
        where: 'id = ?', whereArgs: [album.id]);
  }

  Future<void> deleteAlbum(int id) async {
    final db = await _databaseService.database;
    await db.delete('album', where: 'id = ?', whereArgs: [id]);
  }
}

// '''''''''''''''''''''''''''' ALBUM SERVICE END ''''''''''''''''''''''''''''