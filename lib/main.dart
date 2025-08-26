import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:money_split/Person.dart';
import 'package:money_split/Theme_info.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SettleUp',
      theme: AppTheme.lightTheme,
      home: const PaymentTracker(),
    );
  }
}

class PaymentTracker extends StatefulWidget {
  const PaymentTracker({super.key});

  @override
  State<StatefulWidget> createState() => _PaymentTrackerState();
}

class _PaymentTrackerState extends State<PaymentTracker> {
  bool extended = true;
  final List<Person> people = [];
  void addPerson(Person p) {
    setState(() => people.add(p));
  }

  void updatePerson(int index, Person p) {
    setState(() => people[index] = p);
  }

  Future<void> _showPersonSheet(
    BuildContext context, {
    Person? person,
    int? index,
  }) async {
    final nameController = TextEditingController(text: person?.name ?? "");
    final owesController = TextEditingController(
      text: person?.owes.toString() ?? "",
    );
    final paidController = TextEditingController(
      text: person?.paid.toString() ?? "",
    );

    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16,
            right: 16,
            top: 24,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                person == null ? "Add Person" : "Edit Person",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: "Name"),
              ),
              SizedBox(height: 8),
              TextField(
                controller: owesController,
                decoration: InputDecoration(labelText: "Owes"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 8),
              TextField(
                controller: paidController,
                decoration: InputDecoration(labelText: "Paid"),
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  final newPerson = Person(
                    nameController.text,
                    double.tryParse(owesController.text) ?? 0,
                    double.tryParse(paidController.text) ?? 0,
                  );

                  Navigator.pop(context, newPerson); // pass data back
                },
                child: Text("Save"),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    ).then((result) {
      if (result is Person) {
        if (person == null) {
          addPerson(result);
        } else if (index != null) {
          updatePerson(index, result);
        }
        _calculateTotals();
      }
    });
  }

  double _totalOwed = 0;
  double _collectedAmount = 0;

  int? selectedIndex; // <-- which card is selected

  @override
  void initState() {
    super.initState();
    _calculateTotals();
  }

  void _calculateTotals() {
    double totalSum = 0;
    double collectedSum = 0;
    for (var person in people) {
      totalSum += person.owes;
      collectedSum += person.paid;
    }
    setState(() {
      _totalOwed = totalSum;
      _collectedAmount = collectedSum;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _PaymentSummaryHeader(
                extended: extended,
                totalOwed: _totalOwed,
                collectedAmount: _collectedAmount,
                onTap: () {
                  setState(() {
                    extended = !extended;
                  });
                },
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _PeopleList(
                  people: people,
                  selectedIndex: selectedIndex,
                  onPersonDismissed: (index) {
                    people.removeAt(index);
                    _calculateTotals();
                  },
                  onPersonLongPress: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  onPersonLongPressEnd: ({person, index}) {
                    _showPersonSheet(context, person: person, index: index);
                    setState(() {
                      selectedIndex = null;
                    });
                  },

                  // onPersonLongPressEnd: ({person, index}) =>
                  //     _showPersonSheet(context, person: person, index: index),
                ),
              ),
            ],
          ),

          // Blur everything EXCEPT the selected card
          Positioned.fill(
            child: IgnorePointer(
              ignoring: selectedIndex == null,
              child: GestureDetector(
                onTap: () => setState(() {
                  selectedIndex = null;
                }),
                child: AnimatedOpacity(
                  opacity: selectedIndex != null ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 350),
                  child: GestureDetector(
                    onTap: () => setState(() => selectedIndex = null),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
                      child: Container(
                        color: Colors.black.withValues(alpha: 0.07),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: 20,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.cardBorder, width: 2.3),
                borderRadius: BorderRadius.circular(17),
              ),
              child: FloatingActionButton(
                backgroundColor: AppColors.background,
                foregroundColor: AppColors.primaryText,
                onPressed: () => _showPersonSheet(context),
                child: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// --- HEADER WIDGET (unchanged) ---
class _PaymentSummaryHeader extends StatelessWidget {
  final bool extended;
  final double totalOwed;
  final double collectedAmount;
  final VoidCallback onTap;

  const _PaymentSummaryHeader({
    required this.extended,
    required this.totalOwed,
    required this.collectedAmount,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 350);
    final double remaining = -1 * (totalOwed - collectedAmount);

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        height: extended ? 214 : 133,
        decoration: const BoxDecoration(
          color: AppColors.background,
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 8,
              offset: Offset(3, 3),
              spreadRadius: 1,
            ),
          ],
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          border: BorderDirectional(
            bottom: BorderSide(color: AppColors.cardBorder, width: 4),
          ),
        ),
        duration: animationDuration,
        curve: Curves.easeInOut,
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 30, bottom: 17),
          child: Stack(
            children: [
              AnimatedPositioned(
                curve: Curves.easeInOut,
                top: 4,
                left: 0,
                right: 0,
                bottom: extended ? 70 : 0,
                duration: animationDuration,
                child: AnimatedOpacity(
                  opacity: extended ? 1 : 0,
                  duration: animationDuration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'TOTAL:',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '\$${totalOwed.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Collected:',
                              style: TextStyle(
                                color: Color(0xFF333333),
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            Text(
                              '\$${collectedAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: extended ? 0 : 20,
                left: extended ? 0 : 182,
                curve: Curves.easeInOut,
                duration: animationDuration,
                child: AnimatedDefaultTextStyle(
                  curve: Curves.easeInOut,
                  style: TextStyle(
                    color: remaining > 0
                        ? AppColors.success
                        : AppColors.warning,
                    fontSize: extended ? 40 : 30,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                  duration: animationDuration,
                  child: Text('\$${remaining.toStringAsFixed(2)}'),
                ),
              ),
              AnimatedPositioned(
                bottom: extended ? 50 : 23,
                left: extended ? 0 : 30,
                curve: Curves.easeInOut,
                duration: animationDuration,
                child: const Text(
                  'Overall Balance:',
                  style: TextStyle(
                    color: AppColors.secondaryText,
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- LIST WIDGET ---
class _PeopleList extends StatelessWidget {
  final List<Person> people;
  final int? selectedIndex;
  final Function(int) onPersonDismissed;
  final Function(int) onPersonLongPress;
  final Function({Person? person, int? index}) onPersonLongPressEnd;

  const _PeopleList({
    required this.people,
    required this.selectedIndex,
    required this.onPersonDismissed,
    required this.onPersonLongPress,
    required this.onPersonLongPressEnd,
  });

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
        border: BorderDirectional(
          top: BorderSide(color: AppColors.cardBorder, width: 4),
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(35),
          topRight: Radius.circular(35),
        ),
        child: people.isNotEmpty
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 6),
                itemCount: people.length,
                itemBuilder: (context, index) {
                  final p = people[index];
                  bool isSelected = selectedIndex == index;

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
                              color: Colors.red,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
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
                          key: Key(p.name),
                          direction: DismissDirection.endToStart,
                          onDismissed: (direction) => onPersonDismissed(index),
                          child: GestureDetector(
                            onLongPress: () => onPersonLongPress(index),
                            onLongPressEnd: (details) {
                              onPersonLongPressEnd(person: p, index: index);
                            },
                            child: AnimatedScale(
                              scale: isSelected ? 1.03 : 1,
                              duration: const Duration(milliseconds: 140),
                              child: PersonCard(p),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.account_circle, // Or any profile-related icon
                    size: 80,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No entries yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                ],
              ),
      ),
    );
  }
}
