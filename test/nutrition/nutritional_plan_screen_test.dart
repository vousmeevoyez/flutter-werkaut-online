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
import 'package:provider/provider.dart';
import 'package:werkaut/providers/auth.dart';
import 'package:werkaut/providers/base_provider.dart';
import 'package:werkaut/providers/body_weight.dart';
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/screens/nutritional_plan_screen.dart';
import 'package:werkaut/widgets/nutrition/charts.dart';

import '../../test_data/nutritional_plans.dart';
import 'nutritional_plan_screen_test.mocks.dart';

@GenerateMocks([werkautBaseProvider, AuthProvider, http.Client])
void main() {
  Widget createNutritionalPlan({locale = 'en'}) {
    final key = GlobalKey<NavigatorState>();
    final mockBaseProvider = MockwerkautBaseProvider();

    final plan = getNutritionalPlan();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NutritionPlansProvider>(
          create: (context) => NutritionPlansProvider(mockBaseProvider, []),
        ),
        ChangeNotifierProvider<BodyWeightProvider>(
          create: (context) => BodyWeightProvider(mockBaseProvider),
        ),
      ],
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        navigatorKey: key,
        home: TextButton(
          onPressed: () => key.currentState!.push(
            MaterialPageRoute<void>(
              settings: RouteSettings(arguments: plan),
              builder: (_) => NutritionalPlanScreen(),
            ),
          ),
          child: const SizedBox(),
        ),
      ),
    );
  }

  testWidgets('Test the widgets on the nutritional plan screen', (WidgetTester tester) async {
    await tester.pumpWidget(createNutritionalPlan());
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    // PLan description
    expect(find.text('Less fat, more protein'), findsOneWidget);

    // Ingredients
    expect(find.text('100g Water'), findsOneWidget);
    expect(find.text('75g Burger soup'), findsOneWidget);
    expect(find.text('300g Broccoli cake'), findsOneWidget);

    expect(find.byType(Dismissible), findsNWidgets(2));
    expect(find.byType(FlNutritionalDiaryChartWidget), findsNothing);
  });

  testWidgets('Tests the localization of times - EN', (WidgetTester tester) async {
    await tester.pumpWidget(createNutritionalPlan());
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    expect(find.text('5:00 PM'), findsOneWidget);
  });

  testWidgets('Tests the localization of times - DE', (WidgetTester tester) async {
    await tester.pumpWidget(createNutritionalPlan(locale: 'de'));
    await tester.tap(find.byType(TextButton));
    await tester.pumpAndSettle();

    expect(find.text('17:00'), findsOneWidget);
  });
}
