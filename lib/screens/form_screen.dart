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

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:werkaut/theme/theme.dart';

/// Arguments passed to the form screen
class FormScreenArguments {
  /// Title
  final String title;

  /// Widget to render, typically a form
  final Widget widget;

  /// Flag indicating whether to render the content has a list view (e.g. larger
  /// forms that use an autocompleter, etc) or not (smnall forms, content will
  /// get pushed down)
  final bool hasListView;

  /// Padding for the whole content, default 15px on all sides
  final EdgeInsets padding;

  /// Background color, default white
  final Color backgroundColor;

  FormScreenArguments(
    this.title,
    this.widget, {
    this.hasListView = false,
    this.padding = const EdgeInsets.all(15),
    this.backgroundColor = werkautBackground,
  });
}

class FormScreen extends StatelessWidget {
  static const routeName = '/form';

  @override
  Widget build(BuildContext context) {
    final FormScreenArguments args =
        ModalRoute.of(context)!.settings.arguments as FormScreenArguments;

    return Scaffold(
      backgroundColor: args.backgroundColor,
      appBar: AppBar(title: Text(args.title)),
      body: args.hasListView
          ? Scrollable(
              viewportBuilder: (BuildContext context, ViewportOffset position) => Padding(
                padding: args.padding,
                child: args.widget,
              ),
            )
          : Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: args.padding,
                  child: args.widget,
                ),
              ],
            ),
    );
  }
}
