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
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/models/nutrition/nutritional_plan.dart';
import 'package:werkaut/providers/auth.dart';
import 'package:werkaut/providers/base_provider.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/screens/nutritional_plans_screen.dart';
import 'package:werkaut/widgets/nutrition/forms.dart';

import 'nutritional_plan_screen_test.mocks.dart';

@GenerateMocks([AuthProvider, werkautBaseProvider, http.Client])
void main() {
  final mockAuthProvider = MockAuthProvider();
  final mockBaseProvider = MockwerkautBaseProvider();
  final client = MockClient();

  Widget createHomeScreen({locale = 'en'}) {
    when(client.delete(
      any,
      headers: anyNamed('headers'),
    )).thenAnswer((_) async => http.Response('', 200));

    when(mockBaseProvider.deleteRequest(any, any)).thenAnswer(
      (_) async => http.Response('', 200),
    );

    when(mockAuthProvider.token).thenReturn('1234');
    when(mockAuthProvider.serverUrl).thenReturn('http://localhost');
    when(mockAuthProvider.getAppNameHeader()).thenReturn('werkaut app');

    return ChangeNotifierProvider<NutritionPlansProvider>(
      create: (context) => NutritionPlansProvider(
        mockBaseProvider,
        [
          NutritionalPlan(
            id: 1,
            description: 'test plan 1',
            creationDate: DateTime(2021, 01, 01),
          ),
          NutritionalPlan(
            id: 2,
            description: 'test plan 2',
            creationDate: DateTime(2021, 01, 10),
          ),
        ],
      ),
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: NutritionScreen(),
        routes: {
          FormScreen.routeName: (ctx) => FormScreen(),
        },
      ),
    );
  }

  testWidgets('Test the widgets on the nutritional plans screen', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    //debugDumpApp();
    expect(find.text('Nutritional plans'), findsOneWidget);
    expect(find.byType(Dismissible), findsNWidgets(2));
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('Test deleting an item by dragging the dismissible', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    await tester.drag(find.byKey(const Key('1')), const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();

    // Confirmation dialog
    expect(find.byType(AlertDialog), findsOneWidget);

    // Confirm
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('Test the form on the nutritional plan screen', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    expect(find.byType(PlanForm), findsNothing);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(PlanForm), findsOneWidget);
  });

  testWidgets('Tests the localization of dates - EN', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen());

    expect(find.text('1/1/2021'), findsOneWidget);
    expect(find.text('1/10/2021'), findsOneWidget);
  });

  testWidgets('Tests the localization of dates - DE', (WidgetTester tester) async {
    await tester.pumpWidget(createHomeScreen(locale: 'de'));

    expect(find.text('1.1.2021'), findsOneWidget);
    expect(find.text('10.1.2021'), findsOneWidget);
  });
}
