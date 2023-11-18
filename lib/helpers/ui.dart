/*
 * This file is part of werkaut Workout Manager <https://github.com/werkaut-project>.
 * Copyright (C) 2020, 2021 werkaut Team
 *
 * werkaut Workout Manager is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Affero General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Affero General Public License for more details.
 *
 * You should have received a copy of the GNU Affero General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:werkaut/exceptions/http_exception.dart';
import 'package:werkaut/models/exercises/base.dart';
import 'package:werkaut/models/exercises/translation.dart';
import 'package:werkaut/models/workouts/log.dart';
import 'package:werkaut/providers/workout_plans.dart';

void showErrorDialog(dynamic exception, BuildContext context) {
  log('showErrorDialog: ');
  log(exception.toString());
  log('=====================');

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(AppLocalizations.of(context).anErrorOccurred),
      content: Text(exception.toString()),
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(context).closeButtonLabel),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );
}

void showHttpExceptionErrorDialog(werkautHttpException exception, BuildContext context) async {
  log('showHttpExceptionErrorDialog: ');
  log(exception.toString());
  log('-------------------');

  final List<Widget> errorList = [];
  for (final key in exception.errors!.keys) {
    // Error headers
    // Ensure that the error heading first letter is capitalized.
    final String errorHeaderMsg = key[0].toUpperCase() + key.substring(1, key.length);

    errorList.add(
      Text(
        errorHeaderMsg,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
    );

    // Error messages
    if (exception.errors![key] is String) {
      errorList.add(Text(exception.errors![key]));
    } else {
      for (final value in exception.errors![key]) {
        errorList.add(Text(value));
      }
    }
    errorList.add(const SizedBox(height: 8));
  }

  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      title: Text(AppLocalizations.of(ctx).anErrorOccurred),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [...errorList],
      ),
      actions: [
        TextButton(
          child: Text(MaterialLocalizations.of(ctx).closeButtonLabel),
          onPressed: () {
            Navigator.of(ctx).pop();
          },
        )
      ],
    ),
  );

  // This call serves no purpose The dialog above doesn't seem to show
  // unless this dummy call is present
  // showDialog(context: context, builder: (context) => Container());
}

dynamic showDeleteDialog(
  BuildContext context,
  String confirmDeleteName,
  Log log,
  Translation exercise,
  Map<ExerciseBase, List<Log>> exerciseData,
) async {
  final res = await showDialog(
      context: context,
      builder: (BuildContext contextDialog) {
        return AlertDialog(
          content: Text(
            AppLocalizations.of(context).confirmDelete(confirmDeleteName),
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
                exerciseData[exercise]!.removeWhere((el) => el.id == log.id);
                Provider.of<WorkoutPlansProvider>(context, listen: false).deleteLog(
                  log,
                );

                Navigator.of(contextDialog).pop();

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
}
