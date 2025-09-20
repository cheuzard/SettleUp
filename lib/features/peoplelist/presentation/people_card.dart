import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/legacy.dart';
import 'package:rendlargent/core/services/data/database.dart';
import '../../person_sheet/presentation/sheet_and_button.dart';

final selectedPersonProvider = StateProvider<int?>((ref) => null);

bool _isPayed(Person p) {
  return p.moneyPayed >= p.moneyOwed;
}

class PersonCard extends ConsumerWidget {
  final Person person;

  const PersonCard(this.person, {super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final db = ref.watch(appDatabaseProvider);

    // Only rebuild this card when its selection state changes
    final isSelected = ref.watch(
      selectedPersonProvider.select((selectedId) => selectedId == person.id),
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.delete, color: Colors.white),
                ),
              ),
            ),
          ),
          Dismissible(
            key: Key(person.name),
            direction: DismissDirection.endToStart,

            onDismissed: (direction) => db.deletePerson(person.id),
            child: GestureDetector(
              onLongPress: () => _onPersonLongPress(ref),
              child: AnimatedScale(
                scale: isSelected ? 1.03 : 1.0,
                duration: const Duration(milliseconds: 140),
                child: Container(
                  height: 122,
                  decoration: ShapeDecoration(
                    color: theme.colorScheme.surfaceDim,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 2,
                        color: isSelected
                            ? theme.colorScheme.primary
                            : theme.colorScheme.outline,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadows: [
                      BoxShadow(
                        color: theme.shadowColor.withValues(alpha: 0.25),
                        blurRadius: 4,
                        offset: const Offset(4, 4),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Text(
                              person.name,
                              style: theme.textTheme.headlineSmall,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Owes: \$${person.moneyOwed.toStringAsFixed(2)}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Paid: \$${person.moneyPayed.toStringAsFixed(2)}',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              _isPayed(person)
                                  ? 'Change Due: \$${(person.moneyPayed - person.moneyOwed).toStringAsFixed(2)}'
                                  : 'Still Owes: \$${(person.moneyOwed - person.moneyPayed).toStringAsFixed(2)}',
                              style: theme.textTheme.titleMedium?.copyWith(
                                color: _getStatusColorFromTheme(
                                  context,
                                  person,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onPersonLongPress(WidgetRef ref) {
    final currentSelected = ref.read(selectedPersonProvider);

    if (currentSelected != person.id) {
      // Select this person (deselects any other)
      ref.read(selectedPersonProvider.notifier).state = person.id;
    }
    showPersonSheet(ref.context);
  }

  Color _getStatusColorFromTheme(BuildContext context, Person person) {
    if (_isPayed(person)) {
      return Theme.of(context).colorScheme.primary; // For paid status
    } else {
      return Theme.of(context).colorScheme.error; // For owing status
    }
  }
}
