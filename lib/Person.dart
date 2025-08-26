import 'package:flutter/material.dart';

import 'Theme_info.dart';

class Person {
  String name;
  double paid;
  double owes;

  Person(this.name, this.owes, this.paid);

  bool _isPayed() {
    return paid >= owes;
  }

  Color getStatusColor() {
    return _isPayed() ? AppColors.success : AppColors.warning;
  }
}

class PersonCard extends StatefulWidget {
  final Person person;

  const PersonCard(this.person, {super.key});

  Person getPerson() {
    return person;
  }

  @override
  State<StatefulWidget> createState() => _PersonCardState();
}

class _PersonCardState extends State<PersonCard> {
  bool isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 122,
      decoration: ShapeDecoration(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          side: const BorderSide(width: 2, color: AppColors.cardBorder),
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(4, 4),
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
                  widget.person.name,
                  style: const TextStyle(
                    color: AppColors.primaryText,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Owes: \$${widget.person.owes.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Paid: \$${widget.person.paid.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: AppColors.secondaryText,
                      fontSize: 16,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Text(
                  widget.person._isPayed()
                      ? 'Change Due: \$${(widget.person.paid - widget.person.owes).toStringAsFixed(2)}'
                      : 'Still Owes: \$${(widget.person.owes - widget.person.paid).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: widget.person.getStatusColor(),
                    fontSize: 20,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
