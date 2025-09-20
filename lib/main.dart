import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/theme.dart';
import 'features/blur/blur.dart';
import 'features/header/presentation/header.dart';
import 'features/peoplelist/presentation/peoplelist.dart';
import 'features/person_sheet/presentation/sheet_and_button.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'rend l\'argent',
      theme: ModernPurpleTheme.darkTheme,
      darkTheme: ModernPurpleTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PaymentSummaryHeader(),
                const SizedBox(height: 8),
                Expanded(child: PeopleList()),
              ],
            ),
            Blur(),
            AddButton(),
          ],
        ),
      ),
    );
  }
}
