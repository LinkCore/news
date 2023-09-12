// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Hello Egor, today `
  String get hello {
    return Intl.message(
      'Hello Egor, today ',
      name: 'hello',
      desc: '',
      args: [],
    );
  }

  /// `News: `
  String get news {
    return Intl.message(
      'News: ',
      name: 'news',
      desc: '',
      args: [],
    );
  }

  /// `Some reading time:`
  String get someReadingTime {
    return Intl.message(
      'Some reading time:',
      name: 'someReadingTime',
      desc: '',
      args: [],
    );
  }

  /// `{howMany, plural, one{1 minute} two{2 minutes} other{more than two minutes}}`
  String pageNotificationsCount(num howMany) {
    return Intl.plural(
      howMany,
      one: '1 minute',
      two: '2 minutes',
      other: 'more than two minutes',
      name: 'pageNotificationsCount',
      desc: '',
      args: [howMany],
    );
  }

  /// `today at `
  String get todayAt {
    return Intl.message(
      'today at ',
      name: 'todayAt',
      desc: '',
      args: [],
    );
  }

  /// `yesterday in `
  String get yesterdayIn {
    return Intl.message(
      'yesterday in ',
      name: 'yesterdayIn',
      desc: '',
      args: [],
    );
  }

  /// `Open the entire article (on the website)`
  String get openOnWeb {
    return Intl.message(
      'Open the entire article (on the website)',
      name: 'openOnWeb',
      desc: '',
      args: [],
    );
  }

  /// `unknown`
  String get unknownItem {
    return Intl.message(
      'unknown',
      name: 'unknownItem',
      desc: '',
      args: [],
    );
  }

  /// `Likes: `
  String get countOfLikes {
    return Intl.message(
      'Likes: ',
      name: 'countOfLikes',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ru'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
