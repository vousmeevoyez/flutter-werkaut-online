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
import 'package:werkaut/helpers/platform.dart';
import 'package:werkaut/providers/gallery.dart';
import 'package:werkaut/widgets/core/app_bar.dart';
import 'package:werkaut/widgets/gallery/forms.dart';
import 'package:werkaut/widgets/gallery/overview.dart';

import 'form_screen.dart';

class GalleryScreen extends StatelessWidget {
  static const routeName = '/gallery';

  const GalleryScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: EmptyAppBar(AppLocalizations.of(context).gallery),
      floatingActionButton: isDesktop
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  FormScreen.routeName,
                  arguments: FormScreenArguments(
                    AppLocalizations.of(context).addImage,
                    ImageForm(),
                    hasListView: true,
                  ),
                );
              },
            ),
      body: Consumer<GalleryProvider>(
        builder: (context, workoutProvider, child) => const Gallery(),
      ),
    );
  }
}
