import 'package:drift/drift.dart' hide Column;
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:logger/logger.dart';
import 'package:rendlargent/core/services/data/database.dart';
import 'package:rendlargent/core/services/providers/app_database_provider.dart';
import 'package:rendlargent/features/peoplelist/presentation/people_card.dart';

Logger logger = Logger();

Future<void> showPersonSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (_) {
      return PersonSheetContent();
    },
  ).whenComplete(() {
    // When bottom sheet is closed (by any means), reset the selected person
    ProviderScope.containerOf(
      context,
    ).read(selectedPersonProvider.notifier).state = null;
  });
}

class PersonSheetContent extends ConsumerStatefulWidget {
  const PersonSheetContent({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PersonSheetContentState createState() => _PersonSheetContentState();
}

class _PersonSheetContentState extends ConsumerState<PersonSheetContent> {
  late final TextEditingController nameController;
  late final TextEditingController owesController;
  late final TextEditingController paidController;
  final formKey = GlobalKey<FormState>();
  Person? person;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    owesController = TextEditingController();
    paidController = TextEditingController();

    // Initialize controllers with data if editing
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final personIndex = ref.read(selectedPersonProvider);
      if (personIndex != null) {
        final people = ref.read(watchAllPeopleProvider);
        people.whenOrNull(
          data: (peopleList) {
            try {
              person = peopleList.firstWhere((p) => p.id == personIndex);
              nameController.text = person!.name;
              owesController.text = person!.moneyOwed.toString();
              paidController.text = person!.moneyPayed.toString();
              if (mounted) setState(() {});
            } catch (e) {
              logger.e('Person not found with id: $personIndex', error: e);
              // Reset the selected person if not found
              ref.read(selectedPersonProvider.notifier).state = null;
            }
          },
          error: (error, stack) {
            logger.e('Error loading person', error: error, stackTrace: stack);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error loading person: $error')),
              );
            }
          },
        );
      }
    });
  }

  @override
  void dispose() {
    // Properly dispose of controllers when the widget is removed
    nameController.dispose();
    owesController.dispose();
    paidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final db = ref.watch(appDatabaseProvider);
    final personIndex = ref.read(selectedPersonProvider);

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 24,
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              personIndex == null ? "Add Person" : "Edit Person",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            TextFormField(
              textInputAction: TextInputAction.next,
              autofocus: true,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter a name';
                }
                return null;
              },
              controller: nameController,
              decoration: InputDecoration(labelText: "Name"),
            ),
            SizedBox(height: 8),
            TextFormField(
              textInputAction: TextInputAction.next,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount owed';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              controller: owesController,
              decoration: InputDecoration(labelText: "Owes"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 8),
            TextFormField(
              textInputAction: TextInputAction.done,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an amount paid';
                }
                if (double.tryParse(value) == null) {
                  return 'Please enter a valid number';
                }
                return null;
              },
              controller: paidController,
              decoration: InputDecoration(labelText: "Paid"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (formKey.currentState!.validate()) {
                    final newPerson = PersonsCompanion(
                      name: Value(nameController.text),
                      moneyOwed: Value(
                        double.tryParse(owesController.text) ?? 0.0,
                      ),
                      moneyPayed: Value(
                        double.tryParse(paidController.text) ?? 0.0,
                      ),
                    );

                    if (personIndex == null) {
                      await db.insertPerson(newPerson);
                    } else {
                      // Make sure person is not null before using it
                      if (person != null) {
                        await db.updatePerson(
                          newPerson.copyWith(id: Value(person!.id)),
                        );
                      } else {
                        throw Exception('Person data not loaded for update');
                      }
                    }

                    ref.read(selectedPersonProvider.notifier).state = null;

                    if (context.mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                } catch (e) {
                  logger.e('Error saving person', error: e);
                  if (context.mounted) {
                    ScaffoldMessenger.of(
                      context,
                    ).showSnackBar(SnackBar(content: Text('Error: $e')));
                  }
                }
              },
              child: Text("Save"),
            ),
            SizedBox(height: 22),
          ],
        ),
      ),
    );
  }
}

class AddButton extends StatelessWidget {
  const AddButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 20,
      bottom: 20,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(17),
        ),
        child: FloatingActionButton(
          onPressed: () => showPersonSheet(context),
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
