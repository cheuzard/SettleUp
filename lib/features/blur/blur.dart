import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rendlargent/features/peoplelist/presentation/people_card.dart';

class Blur extends ConsumerWidget {
  const Blur({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(selectedPersonProvider);
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: selectedIndex == null,
        child: GestureDetector(
          onTap: () => ref.read(selectedPersonProvider.notifier).state = null,
          child: AnimatedOpacity(
            opacity: selectedIndex != null ? 1.0 : 0.0,
            duration: const Duration(milliseconds: 350),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2.5, sigmaY: 2.5),
              child: Container(color: Colors.black.withValues(alpha: 0.07)),
            ),
          ),
        ),
      ),
    );
  }
}
