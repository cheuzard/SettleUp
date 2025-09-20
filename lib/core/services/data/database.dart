import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

Logger logger = Logger();

class Persons extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  RealColumn get moneyOwed => real().withDefault(const Constant(0.0))();
  RealColumn get moneyPayed => real().withDefault(const Constant(0.0))();
}

@DriftDatabase(tables: [Persons])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  // Insert new person
  Future<int> insertPerson(PersonsCompanion person) {
    logger.i('Inserting person: $person');
    return into(persons).insert(person);
  }

  // Get all people in stream
  Stream<List<Person>> watchAllPeople() {
    logger.i('Watching all people');
    return select(persons).watch();
  }

  // Update a person's info
  Future<bool> updatePerson(PersonsCompanion person) {
    logger.i('Updating person: $person');
    return update(persons).replace(person);
  }

  // Delete all people
  Future<int> deleteAllPeople() {
    logger.i('Deleting all people');
    return delete(persons).go();
  }

  // Delete a specific person by id
  Future<int> deletePerson(int id) {
    logger.i('Deleting person with id: $id');
    return (delete(persons)..where((tbl) => tbl.id.equals(id))).go();
  }

  // Get a single person by id
  Future<Person?> getPersonById(int id) {
    logger.i('Getting person with id: $id');
    return (select(
      persons,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }
}

//get amount of money owed by all people

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.sqlite'));
    logger.i('Opening database at ${file.path}');
    return NativeDatabase(file);
  });
}

// Riverpod provider for the database
@riverpod
AppDatabase appDatabase(Ref ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
}
