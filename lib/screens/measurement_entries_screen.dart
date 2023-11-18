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
import 'package:provider/provider.dart';
import 'package:werkaut/providers/measurement.dart';
import 'package:werkaut/screens/form_screen.dart';
import 'package:werkaut/widgets/measurements/entries.dart';
import 'package:werkaut/widgets/measurements/forms.dart';

enum MeasurementOptions {
  edit,
  delete,
}

class MeasurementEntriesScreen extends StatelessWidget {
  static const routeName = '/measurement-entries';

  @override
  Widget build(BuildContext context) {
    final categoryId = ModalRoute.of(context)!.settings.arguments as int;
    final category = Provider.of<MeasurementProvider>(context).findCategoryById(categoryId);

    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
        actions: [
          PopupMenuButton<MeasurementOptions>(
            icon: const Icon(Icons.more_vert),
            onSelected: (value) {
              switch (value) {
                case MeasurementOptions.edit:
                  Navigator.pushNamed(
                    context,
                    FormScreen.routeName,
                    arguments: FormScreenArguments(
                      AppLocalizations.of(context).edit,
                      MeasurementCategoryForm(category),
                    ),
                  );
                  break;

                case MeasurementOptions.delete:
                  showDialog(
                      context: context,
                      builder: (BuildContext contextDialog) {
                        return AlertDialog(
                          content: Text(
                            AppLocalizations.of(context).confirmDelete(category.name),
                          ),
                          actions: [
                            TextButton(
                              child: Text(MaterialLocalizations.of(context).cancelButtonLabel),
                              onPressed: () => Navigator.of(contextDialog).pop(),
                            ),
                            TextButton(
                              child: Text(
                                AppLocalizations.of(context).delete,
                                style: TextStyle(color: Theme.of(context).errorColor),
                              ),
                              onPressed: () {
                                // Confirmed, delete the workout
                                Provider.of<MeasurementProvider>(context, listen: false)
                                    .deleteCategory(category.id!);

                                // Close the popup
                                Navigator.of(contextDialog).pop();

                                // and inform the user
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      AppLocalizations.of(context).successfullyDeleted,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      });
                  break;
              }
            },
            itemBuilder: (context) {
              return [
                PopupMenuItem<MeasurementOptions>(
                  value: MeasurementOptions.edit,
                  child: Text(AppLocalizations.of(context).edit),
                ),
                PopupMenuItem<MeasurementOptions>(
                  value: MeasurementOptions.delete,
                  child: Text(AppLocalizations.of(context).delete),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          Navigator.pushNamed(
            context,
            FormScreen.routeName,
            arguments: FormScreenArguments(
              AppLocalizations.of(context).newEntry,
              MeasurementEntryForm(categoryId),
            ),
          );
        },
      ),
      body: Consumer<MeasurementProvider>(
        builder: (context, provider, child) => EntriesList(category),
      ),
    );
  }
}
