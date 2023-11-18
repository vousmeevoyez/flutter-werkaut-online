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
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/providers/body_weight.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/screens/measurement_categories_screen.dart';
import 'package:werkaut/theme/theme.dart';
import 'package:werkaut/widgets/measurements/charts.dart';
import 'package:werkaut/widgets/weight/forms.dart';

class WeightEntriesList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final _weightProvider = Provider.of<BodyWeightProvider>(context, listen: false);

    return Column(
      children: [
        Container(
          color: Theme.of(context).cardColor,
          padding: const EdgeInsets.all(15),
          height: 220,
          child: MeasurementChartWidgetFl(
              _weightProvider.items.map((e) => MeasurementChartEntry(e.weight, e.date)).toList()),
        ),
        TextButton(
          onPressed: () => Navigator.pushNamed(
            context,
            MeasurementCategoriesScreen.routeName,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(AppLocalizations.of(context).measurements),
              const Icon(Icons.chevron_right)
            ],
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => _weightProvider.fetchAndSetEntries(),
            child: ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _weightProvider.items.length,
              itemBuilder: (context, index) {
                final currentEntry = _weightProvider.items[index];
                return Dismissible(
                  key: Key(currentEntry.id.toString()),
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      // Delete entry from DB
                      _weightProvider.deleteEntry(currentEntry.id!);

                      // and inform the user
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            AppLocalizations.of(context).successfullyDeleted,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      );
                    }
                  },
                  confirmDismiss: (direction) async {
                    // Edit entry
                    if (direction == DismissDirection.startToEnd) {
                      Navigator.pushNamed(
                        context,
                        FormScreen.routeName,
                        arguments: FormScreenArguments(
                          AppLocalizations.of(context).edit,
                          WeightForm(currentEntry),
                        ),
                      );
                      return false;
                    }
                    return true;
                  },
                  secondaryBackground: Container(
                    color: Theme.of(context).errorColor,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Colors.white,
                    ),
                  ),
                  background: Container(
                    color: werkautPrimaryButtonColor,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 20),
                    margin: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 4,
                    ),
                    child: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                  ),
                  child: Card(
                    child: ListTile(
                      title: Text('${currentEntry.weight} kg'),
                      subtitle: Text(
                        DateFormat.yMd(Localizations.localeOf(context).languageCode)
                            .format(currentEntry.date),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
