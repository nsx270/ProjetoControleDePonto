import 'package:rxdart/rxdart.dart';

import 'custom_auth_manager.dart';

class HelpAppAuthUser {
  HelpAppAuthUser({required this.loggedIn, this.uid});

  bool loggedIn;
  String? uid;
}

/// Generates a stream of the authenticated user.
BehaviorSubject<HelpAppAuthUser> helpAppAuthUserSubject =
    BehaviorSubject.seeded(HelpAppAuthUser(loggedIn: false));
Stream<HelpAppAuthUser> helpAppAuthUserStream() => helpAppAuthUserSubject
    .asBroadcastStream()
    .map((user) => currentUser = user);
