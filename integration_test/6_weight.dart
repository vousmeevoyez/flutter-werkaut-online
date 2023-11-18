import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/models/body_weight/weight_entry.dart';
import 'package:werkaut/providers/body_weight.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/screens/weight_screen.dart';
import 'package:werkaut/theme/theme.dart';

import '../test/utils.dart';

Widget createWeightScreen({locale = 'en'}) {
  final provider = BodyWeightProvider(mockBaseProvider);
  provider.items = [
    WeightEntry(id: 1, weight: 86, date: DateTime(2021, 01, 01)),
    WeightEntry(id: 2, weight: 81, date: DateTime(2021, 01, 10)),
    WeightEntry(id: 3, weight: 82, date: DateTime(2021, 01, 20)),
    WeightEntry(id: 4, weight: 83, date: DateTime(2021, 01, 30)),
    WeightEntry(id: 5, weight: 86, date: DateTime(2021, 02, 20)),
    WeightEntry(id: 6, weight: 90, date: DateTime(2021, 02, 28)),
    WeightEntry(id: 7, weight: 91, date: DateTime(2021, 03, 20)),
    WeightEntry(id: 8, weight: 91.1, date: DateTime(2021, 03, 30)),
    WeightEntry(id: 9, weight: 90, date: DateTime(2021, 05, 1)),
    WeightEntry(id: 10, weight: 91, date: DateTime(2021, 6, 5)),
    WeightEntry(id: 11, weight: 89, date: DateTime(2021, 6, 20)),
    WeightEntry(id: 12, weight: 88, date: DateTime(2021, 7, 15)),
    WeightEntry(id: 13, weight: 86, date: DateTime(2021, 7, 20)),
    WeightEntry(id: 14, weight: 83, date: DateTime(2021, 7, 30)),
    WeightEntry(id: 15, weight: 80, date: DateTime(2021, 8, 10))
  ];

  return ChangeNotifierProvider<BodyWeightProvider>(
    create: (context) => provider,
    child: MaterialApp(
      locale: Locale(locale),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: werkautTheme,
      home: WeightScreen(),
      routes: {
        FormScreen.routeName: (ctx) => FormScreen(),
      },
    ),
  );
}
