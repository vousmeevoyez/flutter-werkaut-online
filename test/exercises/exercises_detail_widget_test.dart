/*
 * This file is part of werkaut Workout Manager <https://github.com/werkaut-project>.
 * Copyright (C) 2020, 2021 werkaut Team
 *
 * werkaut Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * werkaut Workout Manager is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/providers/exercises.dart';
import 'package:werkaut/widgets/exercises/exercises.dart';

import '../../test_data/exercises.dart';
import '../workout/gym_mode_screen_test.mocks.dart';

void main() {
  final mockProvider = MockExercisesProvider();

  Widget createHomeScreen({locale = 'en'}) {
    return ChangeNotifierProvider<ExercisesProvider>(
      create: (context) => mockProvider,
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorKey: GlobalKey<NavigatorState>(),
        home: Scaffold(
          body: ExerciseDetail(getTestExerciseBases()[0]),
        ),
      ),
    );
  }

  testWidgets('Test the widgets on the exercise detail widget', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());
    await tester.pumpAndSettle();

    expect(find.text('Arms'), findsOneWidget, reason: 'Category');

    expect(find.text('Bench'), findsOneWidget, reason: 'Equipment');
    expect(find.text('Dumbbell'), findsOneWidget, reason: 'Equipment');

    expect(find.text('Muscles'), findsNWidgets(2), reason: 'One header, one sub header');
    expect(find.text('Flutterus maximus (Glutes)'), findsOneWidget, reason: 'Muscles');
    expect(find.text('Biceps brachii (Biceps)'), findsOneWidget, reason: 'Muscles');

    expect(find.text('Secondary muscles'), findsOneWidget);
    expect(
      find.byType(MuscleWidget),
      findsNWidgets(2),
      reason: 'Two diagrams, one for front, one for the back',
    );
    expect(find.text('Gluteus maximus'), findsOneWidget, reason: 'Secondary muscles');
    expect(find.text('Description'), findsOneWidget, reason: 'Description header');
    expect(find.text('add clever text'), findsOneWidget, reason: 'Description');
    expect(find.text('Variations'), findsNothing);
  });
}
