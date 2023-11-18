# Mobile app for werkaut Workout Manager

werkaut is a free, open-source flutter application that manages and tracks/logs
your exercises and personal workouts, weight, and diet plans. This is the mobile
app written with Flutter, it talks via REST with the main server.

If you want to contribute, hop on the Discord server and say hi!


<p>
<img src="https://raw.githubusercontent.com/werkaut-project/flutter/master/fastlane/metadata/android/en-US/images/phoneScreenshots/01%20-%20dashboard.png" width="200" />

<img src="https://raw.githubusercontent.com/werkaut-project/flutter/master/fastlane/metadata/android/en-US/images/phoneScreenshots/04%20-%20measurements.png" width="200" />

<img src="https://raw.githubusercontent.com/werkaut-project/flutter/master/fastlane/metadata/android/en-US/images/phoneScreenshots/05%20-%20nutritional%20plan.png" width="200" />
</p>

## Installation

[<img src="https://play.google.com/intl/en_us/badges/images/generic/en-play-badge.png"
alt="Get it on Google Play"
height="80">](https://play.google.com/store/apps/details?id=de.werkaut.flutter)
[<img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png"
alt="Get it on F-Droid"
height="80">](https://f-droid.org/packages/de.werkaut.flutter/)

## Development

### 1

Install the [werkaut server](https://github.com/werkaut-project/werkaut), the easiest way
is to start the development docker-compose: <https://github.com/werkaut-project/docker>

Alternatively, you can use the test server (the db is reset every day):

* URL: `https://werkaut-master.rge.uber.space`
* username: `user`
* password: `flutteruser`
* API key: `31e2ea0322c07b9df583a9b6d1e794f7139e78d4`

### 2

Install Flutter, and all its dependencies, and create a new virtual device:
<https://flutter.dev/docs/get-started/install>.

The app currently uses flutter 3.13

### 3

Create a new file ``werkaut.properties`` in ``fastlane/metadata/envfiles/``:

```properties
werkaut_API_KEY=123456
```

On Linux and macOS, add these as environment variables, e.g. by running the `source`
command on the file.

To just run/develop the app it only needs to have any value for werkaut_API_KEY, but
you need a correct value if you want to register via the app. For this, you need
to allow (a probably dedicated) user on the werkaut server to register users on its
behalf. For this, generate an API KEY by visiting <http://localhost:8000/de/user/api-key>
on your local instance and then run ``python3 manage.py add-user-rest the username``

You can later list all the registered users with: ``python3 manage.py list-users-api``

### 4

Start the application with ``flutter run`` or use your IDE
(please note that depending on how you run your emulator you will need to change the IP address of
the server)

You can run the tests with the ``flutter test``

## Translation

Translate the app to your language on  [Weblate](https://hosted.weblate.org/engage/werkaut/).

[![translation status](https://hosted.weblate.org/widgets/werkaut/-/mobile/multi-blue.svg)](https://hosted.weblate.org/engage/werkaut/)

## Contact

Feel free to get in touch if you found this useful or if something didn't behave
as expected. We can't fix what we don't know about, so please report liberally.
If you're not sure if something is a bug or not, feel free to file a bug anyway.

* **Discord:** <https://discord.gg/rPWFv6W>
* **Issue tracker:** <https://github.com/werkaut-project/flutter/issues>
* **Twitter:** <https://twitter.com/werkaut_project>

## License

The application is licensed under the GNU Affero General Public License 3 or later
(AGPL 3+) with an app store exception.

As additional permission under section 7, you are allowed to distribute the
software through an app store, even if that store has restrictive terms and
conditions that are incompatible with the AGPL, provided that the source is also
available under the AGPL with or without this permission through a channel without
those restrictive terms and conditions.

The initial exercise and ingredient data is licensed additionally under one of
the Creative Commons licenses, see the individual exercises for more details.

