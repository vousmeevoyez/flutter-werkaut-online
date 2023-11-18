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
import 'package:werkaut/providers/nutrition.dart';
import 'package:werkaut/screens/nutritional_plan_screen.dart';
import 'package:werkaut/widgets/core/text_prompt.dart';

class NutritionalPlansList extends StatelessWidget {
  final NutritionPlansProvider _nutritionProvider;

  const NutritionalPlansList(this._nutritionProvider);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _nutritionProvider.fetchAndSetAllPlansSparse(),
      child: _nutritionProvider.items.isEmpty
          ? TextPrompt()
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: _nutritionProvider.items.length,
              itemBuilder: (context, index) {
                final currentPlan = _nutritionProvider.items[index];
                return Dismissible(
                  key: Key(currentPlan.id.toString()),
                  confirmDismiss: (direction) async {
                    // Delete workout from DB
                    final bool? res = await showDialog(
                        context: context,
                        builder: (BuildContext contextDialog) {
                          return AlertDialog(
                            content: Text(
                              AppLocalizations.of(context).confirmDelete(currentPlan.description),
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
                                  _nutritionProvider.deletePlan(currentPlan.id!);

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
                    return res;
                  },
                  background: Container(
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
                  direction: DismissDirection.endToStart,
                  child: Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          NutritionalPlanScreen.routeName,
                          arguments: currentPlan,
                        );
                      },
                      title: Text(currentPlan.getLabel(context)),
                      subtitle: Text(
                        DateFormat.yMd(Localizations.localeOf(context).languageCode)
                            .format(currentPlan.creationDate),
                      ),
                    ),
                  ),
                );
              },
            ),
    );
  }
}
