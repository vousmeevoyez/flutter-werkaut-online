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
import 'package:werkaut/providers/auth.dart';
import 'package:werkaut/screens/auth_screen.dart';

void main() {
  testWidgets('Test the widgets on the auth screen, login mode', (WidgetTester tester) async {
    // Wrap screen in material app so that the media query gets a context
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: (ctx) => AuthProvider(),
          ),
        ],
        child: Consumer<AuthProvider>(
          builder: (ctx, auth, _) => MaterialApp(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            locale: const Locale('en'),
            home: AuthScreen(),
          ),
        ),
      ),
    );
/*
    Provider<Auth>(
        create: (_) => Auth(),
        // we use `builder` to obtain a new `BuildContext` that has access to the provider
        builder: (context) {
          // No longer throws
          return Text(''),
        }
    );

 */

    Consumer<AuthProvider>(
      builder: (ctx, auth, _) => MaterialApp(
        builder: (ctx, authResultSnapshot) => AuthScreen(),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('werkaut'), findsOneWidget);

    // Verify that the correct buttons and input fields are shown: login
    expect(find.text('Register now'), findsOneWidget);
    expect(find.text('LOGIN INSTEAD'), findsNothing);

    // Check that the correct widgets are shown
    expect(find.byKey(const Key('inputUsername')), findsOneWidget);
    expect(find.byKey(const Key('inputEmail')), findsNothing);
    expect(find.byKey(const Key('inputPassword')), findsOneWidget);
    expect(find.byKey(const Key('inputServer')), findsNothing);
    expect(find.byKey(const Key('inputPassword2')), findsNothing);
    expect(find.byKey(const Key('actionButton')), findsOneWidget);
    expect(find.byKey(const Key('toggleActionButton')), findsOneWidget);
    expect(find.byKey(const Key('toggleCustomServerButton')), findsOneWidget);
  }, skip: true); // TODO(x): skipped because of technical problems:
  // either the provider wasn't found or, if the call was removed, the
  // localization data could not be loaded...

  testWidgets('Test the widgets on the auth screen, registration', (WidgetTester tester) async {
    // Wrap screen in material app so that the media query gets a context
    await tester.pumpWidget(MaterialApp(home: AuthScreen()));
    await tester.tap(find.byKey(const Key('toggleActionButton')));

    // Rebuild the widget after the state has changed.
    await tester.pump();
    expect(find.text('Register now'), findsNothing);
    expect(find.text('LOGIN INSTEAD'), findsOneWidget);

    // Check that the correct widgets are shown
    expect(find.byKey(const Key('inputUsername')), findsOneWidget);
    expect(find.byKey(const Key('inputEmail')), findsOneWidget);
    expect(find.byKey(const Key('inputPassword')), findsOneWidget);
    expect(find.byKey(const Key('inputServer')), findsOneWidget);
    expect(find.byKey(const Key('inputPassword2')), findsOneWidget);
    expect(find.byKey(const Key('actionButton')), findsOneWidget);
    expect(find.byKey(const Key('toggleActionButton')), findsOneWidget);
  }, skip: true);
}
