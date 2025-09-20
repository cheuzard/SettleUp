// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $PersonsTable extends Persons with TableInfo<$PersonsTable, Person> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PersonsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _moneyOwedMeta = const VerificationMeta(
    'moneyOwed',
  );
  @override
  late final GeneratedColumn<double> moneyOwed = GeneratedColumn<double>(
    'money_owed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  static const VerificationMeta _moneyPayedMeta = const VerificationMeta(
    'moneyPayed',
  );
  @override
  late final GeneratedColumn<double> moneyPayed = GeneratedColumn<double>(
    'money_payed',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0.0),
  );
  @override
  List<GeneratedColumn> get $columns => [id, name, moneyOwed, moneyPayed];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'persons';
  @override
  VerificationContext validateIntegrity(
    Insertable<Person> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('money_owed')) {
      context.handle(
        _moneyOwedMeta,
        moneyOwed.isAcceptableOrUnknown(data['money_owed']!, _moneyOwedMeta),
      );
    }
    if (data.containsKey('money_payed')) {
      context.handle(
        _moneyPayedMeta,
        moneyPayed.isAcceptableOrUnknown(data['money_payed']!, _moneyPayedMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Person map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Person(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      moneyOwed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}money_owed'],
      )!,
      moneyPayed: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}money_payed'],
      )!,
    );
  }

  @override
  $PersonsTable createAlias(String alias) {
    return $PersonsTable(attachedDatabase, alias);
  }
}

class Person extends DataClass implements Insertable<Person> {
  final int id;
  final String name;
  final double moneyOwed;
  final double moneyPayed;
  const Person({
    required this.id,
    required this.name,
    required this.moneyOwed,
    required this.moneyPayed,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['money_owed'] = Variable<double>(moneyOwed);
    map['money_payed'] = Variable<double>(moneyPayed);
    return map;
  }

  PersonsCompanion toCompanion(bool nullToAbsent) {
    return PersonsCompanion(
      id: Value(id),
      name: Value(name),
      moneyOwed: Value(moneyOwed),
      moneyPayed: Value(moneyPayed),
    );
  }

  factory Person.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Person(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      moneyOwed: serializer.fromJson<double>(json['moneyOwed']),
      moneyPayed: serializer.fromJson<double>(json['moneyPayed']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'moneyOwed': serializer.toJson<double>(moneyOwed),
      'moneyPayed': serializer.toJson<double>(moneyPayed),
    };
  }

  Person copyWith({
    int? id,
    String? name,
    double? moneyOwed,
    double? moneyPayed,
  }) => Person(
    id: id ?? this.id,
    name: name ?? this.name,
    moneyOwed: moneyOwed ?? this.moneyOwed,
    moneyPayed: moneyPayed ?? this.moneyPayed,
  );
  Person copyWithCompanion(PersonsCompanion data) {
    return Person(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      moneyOwed: data.moneyOwed.present ? data.moneyOwed.value : this.moneyOwed,
      moneyPayed: data.moneyPayed.present
          ? data.moneyPayed.value
          : this.moneyPayed,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Person(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('moneyOwed: $moneyOwed, ')
          ..write('moneyPayed: $moneyPayed')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, moneyOwed, moneyPayed);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Person &&
          other.id == this.id &&
          other.name == this.name &&
          other.moneyOwed == this.moneyOwed &&
          other.moneyPayed == this.moneyPayed);
}

class PersonsCompanion extends UpdateCompanion<Person> {
  final Value<int> id;
  final Value<String> name;
  final Value<double> moneyOwed;
  final Value<double> moneyPayed;
  const PersonsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.moneyOwed = const Value.absent(),
    this.moneyPayed = const Value.absent(),
  });
  PersonsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.moneyOwed = const Value.absent(),
    this.moneyPayed = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Person> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<double>? moneyOwed,
    Expression<double>? moneyPayed,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (moneyOwed != null) 'money_owed': moneyOwed,
      if (moneyPayed != null) 'money_payed': moneyPayed,
    });
  }

  PersonsCompanion copyWith({
    Value<int>? id,
    Value<String>? name,
    Value<double>? moneyOwed,
    Value<double>? moneyPayed,
  }) {
    return PersonsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      moneyOwed: moneyOwed ?? this.moneyOwed,
      moneyPayed: moneyPayed ?? this.moneyPayed,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (moneyOwed.present) {
      map['money_owed'] = Variable<double>(moneyOwed.value);
    }
    if (moneyPayed.present) {
      map['money_payed'] = Variable<double>(moneyPayed.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PersonsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('moneyOwed: $moneyOwed, ')
          ..write('moneyPayed: $moneyPayed')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $PersonsTable persons = $PersonsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [persons];
}

typedef $$PersonsTableCreateCompanionBuilder =
    PersonsCompanion Function({
      Value<int> id,
      required String name,
      Value<double> moneyOwed,
      Value<double> moneyPayed,
    });
typedef $$PersonsTableUpdateCompanionBuilder =
    PersonsCompanion Function({
      Value<int> id,
      Value<String> name,
      Value<double> moneyOwed,
      Value<double> moneyPayed,
    });

class $$PersonsTableFilterComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get moneyOwed => $composableBuilder(
    column: $table.moneyOwed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get moneyPayed => $composableBuilder(
    column: $table.moneyPayed,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PersonsTableOrderingComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get moneyOwed => $composableBuilder(
    column: $table.moneyOwed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get moneyPayed => $composableBuilder(
    column: $table.moneyPayed,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PersonsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PersonsTable> {
  $$PersonsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<double> get moneyOwed =>
      $composableBuilder(column: $table.moneyOwed, builder: (column) => column);

  GeneratedColumn<double> get moneyPayed => $composableBuilder(
    column: $table.moneyPayed,
    builder: (column) => column,
  );
}

class $$PersonsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PersonsTable,
          Person,
          $$PersonsTableFilterComposer,
          $$PersonsTableOrderingComposer,
          $$PersonsTableAnnotationComposer,
          $$PersonsTableCreateCompanionBuilder,
          $$PersonsTableUpdateCompanionBuilder,
          (Person, BaseReferences<_$AppDatabase, $PersonsTable, Person>),
          Person,
          PrefetchHooks Function()
        > {
  $$PersonsTableTableManager(_$AppDatabase db, $PersonsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PersonsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PersonsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PersonsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<double> moneyOwed = const Value.absent(),
                Value<double> moneyPayed = const Value.absent(),
              }) => PersonsCompanion(
                id: id,
                name: name,
                moneyOwed: moneyOwed,
                moneyPayed: moneyPayed,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String name,
                Value<double> moneyOwed = const Value.absent(),
                Value<double> moneyPayed = const Value.absent(),
              }) => PersonsCompanion.insert(
                id: id,
                name: name,
                moneyOwed: moneyOwed,
                moneyPayed: moneyPayed,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$PersonsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PersonsTable,
      Person,
      $$PersonsTableFilterComposer,
      $$PersonsTableOrderingComposer,
      $$PersonsTableAnnotationComposer,
      $$PersonsTableCreateCompanionBuilder,
      $$PersonsTableUpdateCompanionBuilder,
      (Person, BaseReferences<_$AppDatabase, $PersonsTable, Person>),
      Person,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$PersonsTableTableManager get persons =>
      $$PersonsTableTableManager(_db, _db.persons);
}

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(appDatabase)
const appDatabaseProvider = AppDatabaseProvider._();

final class AppDatabaseProvider
    extends $FunctionalProvider<AppDatabase, AppDatabase, AppDatabase>
    with $Provider<AppDatabase> {
  const AppDatabaseProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appDatabaseProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appDatabaseHash();

  @$internal
  @override
  $ProviderElement<AppDatabase> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppDatabase create(Ref ref) {
    return appDatabase(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppDatabase value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppDatabase>(value),
    );
  }
}

String _$appDatabaseHash() => r'fc30bd194c5eb2088ae8f4001dfacaf74d135976';
