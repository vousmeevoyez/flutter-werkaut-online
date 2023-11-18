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
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/providers/body_weight.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/screens/weight_screen.dart';
import 'package:werkaut/widgets/measurements/charts.dart';
import 'package:werkaut/widgets/weight/forms.dart';

import '../../test_data/body_weight.dart';
import 'weight_screen_test.mocks.dart';

@GenerateMocks([BodyWeightProvider])
void main() {
  var mockWeightProvider = MockBodyWeightProvider();

  Widget createWeightScreen({locale = 'en'}) {
    mockWeightProvider = MockBodyWeightProvider();
    when(mockWeightProvider.items).thenReturn(getWeightEntries());

    return ChangeNotifierProvider<BodyWeightProvider>(
      create: (context) => mockWeightProvider,
      child: MaterialApp(
        locale: Locale(locale),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: WeightScreen(),
        routes: {
          FormScreen.routeName: (_) => FormScreen(),
        },
      ),
    );
  }

  testWidgets('Test the widgets on the body weight screen', (WidgetTester tester) async {
    await tester.pumpWidget(createWeightScreen());

    expect(find.text('Weight'), findsOneWidget);
    expect(find.byType(MeasurementChartWidgetFl), findsOneWidget);
    expect(find.byType(Dismissible), findsNWidgets(2));
    expect(find.byType(ListTile), findsNWidgets(2));
  });

  testWidgets('Test deleting an item by dragging the dismissible', (WidgetTester tester) async {
    await tester.pumpWidget(createWeightScreen());

    await tester.drag(find.byKey(const Key('1')), const Offset(-500.0, 0.0));
    await tester.pumpAndSettle();
    verify(mockWeightProvider.deleteEntry(1)).called(1);
    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('Test the form on the body weight screen', (WidgetTester tester) async {
    await tester.pumpWidget(createWeightScreen());

    expect(find.byType(WeightForm), findsNothing);
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.byType(WeightForm), findsOneWidget);
  });

  testWidgets('Tests the localization of dates - EN', (WidgetTester tester) async {
    await tester.pumpWidget(createWeightScreen());

    // One in the entries list, one in the chart
    expect(find.text('1/1/2021'), findsOneWidget);
    expect(find.text('1/10/2021'), findsOneWidget);
  });

  testWidgets('Tests the localization of dates - DE', (WidgetTester tester) async {
    await tester.pumpWidget(createWeightScreen(locale: 'de'));

    expect(find.text('1.1.2021'), findsOneWidget);
    expect(find.text('10.1.2021'), findsOneWidget);
  });
}
