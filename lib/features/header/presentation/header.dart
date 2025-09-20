import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rendlargent/core/services/providers/app_database_provider.dart';

class PaymentSummaryHeader extends StatefulWidget {
  const PaymentSummaryHeader({super.key});

  @override
  State<PaymentSummaryHeader> createState() => _PaymentSummaryHeaderState();
}

class _PaymentSummaryHeaderState extends State<PaymentSummaryHeader> {
  bool? extended;

  @override
  void initState() {
    super.initState();
    extended = true;
  }

  @override
  Widget build(BuildContext context) {
    const animationDuration = Duration(milliseconds: 350);
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return GestureDetector(
      onTap: () {
        setState(() {
          extended = !extended!;
        });
      },
      child: AnimatedContainer(
        height: extended! ? 214 : 133,
        decoration: BoxDecoration(
          color: theme.scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: const Offset(3, 3),
              spreadRadius: 1,
            ),
          ],
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(35),
            bottomRight: Radius.circular(35),
          ),
          border: const BorderDirectional(bottom: BorderSide(width: 4)),
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
                bottom: extended! ? 70 : 0,
                duration: animationDuration,
                child: AnimatedOpacity(
                  opacity: extended! ? 1 : 0,
                  duration: animationDuration,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('TOTAL:', style: theme.textTheme.titleMedium),
                            Consumer(
                              builder:
                                  (
                                    BuildContext context,
                                    WidgetRef ref,
                                    Widget? child,
                                  ) {
                                    final totalOwed =
                                        ref
                                            .watch(totalAmountOwedProvider)
                                            .value ??
                                        0.0;
                                    return Text(
                                      '\$${totalOwed.toStringAsFixed(2)}',
                                      style: theme.textTheme.titleMedium,
                                    );
                                  },
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Collected:',
                              style: theme.textTheme.titleMedium,
                            ),
                            Consumer(
                              builder: (context, ref, child) {
                                final collectedAmount =
                                    ref.watch(totalAmountPayedProvider).value ??
                                    0.0;
                                return Text(
                                  '\$${collectedAmount.toStringAsFixed(2)}',
                                  style: theme.textTheme.titleMedium,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AnimatedPositioned(
                bottom: extended! ? 0 : 20,
                left: extended! ? 0 : 182,
                curve: Curves.easeInOut,
                duration: animationDuration,
                child: Consumer(
                  builder:
                      (BuildContext context, WidgetRef ref, Widget? child) {
                        final totalOwed =
                            ref.watch(totalAmountOwedProvider).value ?? 0.0;
                        final collectedAmount =
                            ref.watch(totalAmountPayedProvider).value ?? 0.0;
                        final double remaining =
                            -1 * (totalOwed - collectedAmount);
                        return AnimatedDefaultTextStyle(
                          curve: Curves.easeInOut,
                          style: theme.textTheme.headlineMedium!.copyWith(
                            color: remaining > 0
                                ? colorScheme.primary
                                : colorScheme.error,
                            fontSize: extended! ? 40 : 30,
                          ),
                          duration: animationDuration,
                          child: Text('\$${remaining.toStringAsFixed(2)}'),
                        );
                      },
                ),
              ),
              AnimatedPositioned(
                bottom: extended! ? 50 : 23,
                left: extended! ? 0 : 30,
                curve: Curves.easeInOut,
                duration: animationDuration,
                child: Text(
                  'Overall Balance:',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.textTheme.bodyMedium?.color,
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
