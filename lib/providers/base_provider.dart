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

import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:werkaut/exceptions/http_exception.dart';
import 'package:werkaut/providers/auth.dart';
import 'package:werkaut/providers/helpers.dart';

/// Base provider class.
///
/// Provides a couple of comfort functions so we avoid a bit of boilerplate.
class werkautBaseProvider {
  AuthProvider auth;
  late http.Client client;

  werkautBaseProvider(this.auth, [http.Client? client]) {
    auth = auth;
    this.client = client ?? http.Client();
  }

  Map<String, String> getDefaultHeaders({includeAuth = false}) {
    final out = {
      HttpHeaders.contentTypeHeader: 'application/json; charset=UTF-8',
      HttpHeaders.userAgentHeader: auth.getAppNameHeader(),
    };

    if (includeAuth) {
      out[HttpHeaders.authorizationHeader] = 'Token ${auth.token}';
    }

    return out;
  }

  /// Helper function to make a URL.
  Uri makeUrl(String path, {int? id, String? objectMethod, Map<String, dynamic>? query}) {
    return makeUri(auth.serverUrl!, path, id, objectMethod, query);
  }

  /// Fetch and retrieve the overview list of objects, returns the JSON parsed response
  Future<Map<String, dynamic>> fetch(Uri uri) async {
    // Send the request
    final response = await client.get(
      uri,
      headers: getDefaultHeaders(includeAuth: true),
    );

    // Something wrong with our request
    if (response.statusCode >= 400) {
      throw werkautHttpException(response.body);
    }

    // Process the response
    return json.decode(utf8.decode(response.bodyBytes)) as dynamic;
  }

  /// Fetch and retrieve the overview list of objects, returns the JSON parsed response
  Future<List<dynamic>> fetchPaginated(Uri uri) async {
    final out = [];
    var url = uri;
    var allPagesProcessed = false;

    while (!allPagesProcessed) {
      final data = await fetch(url);

      data['results'].forEach((e) => out.add(e));

      if (data['next'] == null) {
        allPagesProcessed = true;
      } else {
        url = Uri.parse(data['next']);
      }
    }

    return out;
  }

  /// POSTs a new object
  Future<Map<String, dynamic>> post(Map<String, dynamic> data, Uri uri) async {
    final response = await client.post(
      uri,
      headers: getDefaultHeaders(includeAuth: true),
      body: json.encode(data),
    );

    // Something wrong with our request
    if (response.statusCode >= 400) {
      throw werkautHttpException(response.body);
    }

    return json.decode(response.body);
  }

  /// PATCHEs an existing object
  Future<Map<String, dynamic>> patch(Map<String, dynamic> data, Uri uri) async {
    final response = await client.patch(
      uri,
      headers: getDefaultHeaders(includeAuth: true),
      body: json.encode(data),
    );

    // Something wrong with our request
    if (response.statusCode >= 400) {
      throw werkautHttpException(response.body);
    }

    return json.decode(response.body);
  }

  /// DELETEs an existing object
  Future<Response> deleteRequest(String url, int id) async {
    final deleteUrl = makeUrl(url, id: id);

    final response = await client.delete(
      deleteUrl,
      headers: getDefaultHeaders(includeAuth: true),
    );

    // Something wrong with our request
    if (response.statusCode >= 400) {
      throw werkautHttpException(response.body);
    }
    return response;
  }
}
