import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_database_provider.g.dart';
// part 'app_database_provider.g.dart';

// @riverpod
// AppDatabase appDatabase(Ref ref) {
//   final db = AppDatabase();
//   ref.onDispose(() {
//     db.close();
//   });
//   return db;
// }

final watchAllPeopleProvider = StreamProvider.autoDispose<List<Person>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.watchAllPeople();
});

@riverpod
Stream<double> totalAmountOwed(Ref ref) {
  final people = ref.watch(watchAllPeopleProvider);
  return people.when(
    data: (people) {
      final totalOwed = people.fold<double>(
        0.0,
        (sum, person) => sum + person.moneyOwed,
      );
      return Stream.value(totalOwed);
    },
    loading: () => Stream.value(0.0),
    error: (e, st) => Stream.value(0.0),
  );
}

@riverpod
Stream<double> totalAmountPayed(Ref ref) {
  final people = ref.watch(watchAllPeopleProvider);
  return people.when(
    data: (people) {
      final totalPayed = people.fold<double>(
        0.0,
        (sum, person) => sum + person.moneyPayed,
      );
      return Stream.value(totalPayed);
    },
    loading: () => Stream.value(0.0),
    error: (e, st) => Stream.value(0.0),
  );
}
