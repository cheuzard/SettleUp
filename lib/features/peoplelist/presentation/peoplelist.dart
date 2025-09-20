import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rendlargent/core/services/data/database.dart';
import 'package:rendlargent/core/services/providers/app_database_provider.dart';
import 'package:rendlargent/features/peoplelist/presentation/people_card.dart';

class PeopleList extends StatelessWidget {
  const PeopleList({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        border: BorderDirectional(top: BorderSide(width: 4)),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: Consumer(
          builder: (BuildContext context, WidgetRef ref, Widget? child) {
            final people = ref.watch(watchAllPeopleProvider);

            return people.when(
              data: (people) {
                return people.isNotEmpty
                    ? ListView.builder(
                        padding: const EdgeInsets.only(top: 6),
                        itemCount: people.length,
                        itemBuilder: (context, index) {
                          final p = people[index];

                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 5,
                            ),
                            child: Stack(
                              alignment: Alignment.centerRight,
                              children: [
                                Positioned.fill(
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(20),
                                      ),
                                    ),
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                        padding: EdgeInsets.only(right: 20.0),
                                        child: Icon(Icons.delete),
                                      ),
                                    ),
                                  ),
                                ),
                                PersonCard(p),
                              ],
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.person_outline, size: 70),
                            Text(
                              'No people added yet.\nTap the + button to add someone.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      );
              },
              error: (error, stackTrace) {
                logger.e(
                  'Error loading people',
                  error: error,
                  stackTrace: stackTrace,
                );
                return Center(child: Text('Error: $error'));
              },
              loading: () => const Center(child: CircularProgressIndicator()),
            );
          },
        ),
      ),
    );
  }
}
