import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/backend/schema/structs/index.dart';

import '/auth/custom_auth/custom_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';

const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  HelpAppAuthUser? initialUser;
  HelpAppAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(HelpAppAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : PagInicialWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : PagInicialWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: RegistrarWidget.routeName,
          path: RegistrarWidget.routePath,
          builder: (context, params) => RegistrarWidget(),
        ),
        FFRoute(
          name: PagInicialWidget.routeName,
          path: PagInicialWidget.routePath,
          builder: (context, params) => PagInicialWidget(),
        ),
        FFRoute(
          name: EsqueceuSenhaWidget.routeName,
          path: EsqueceuSenhaWidget.routePath,
          builder: (context, params) => EsqueceuSenhaWidget(),
        ),
        FFRoute(
          name: EmailEnviadoWidget.routeName,
          path: EmailEnviadoWidget.routePath,
          builder: (context, params) => EmailEnviadoWidget(),
        ),
        FFRoute(
          name: CadastroClienteWidget.routeName,
          path: CadastroClienteWidget.routePath,
          builder: (context, params) => CadastroClienteWidget(),
        ),
        FFRoute(
          name: PremiumWidget.routeName,
          path: PremiumWidget.routePath,
          builder: (context, params) => PremiumWidget(),
        ),
        FFRoute(
          name: SuporteWidget.routeName,
          path: SuporteWidget.routePath,
          builder: (context, params) => SuporteWidget(),
        ),
        FFRoute(
          name: AvaliationsWidget.routeName,
          path: AvaliationsWidget.routePath,
          builder: (context, params) => AvaliationsWidget(),
        ),
        FFRoute(
          name: TrabalhadorClienteWidget.routeName,
          path: TrabalhadorClienteWidget.routePath,
          builder: (context, params) => TrabalhadorClienteWidget(),
        ),
        FFRoute(
          name: CadastroAutonomoWidget.routeName,
          path: CadastroAutonomoWidget.routePath,
          builder: (context, params) => CadastroAutonomoWidget(),
        ),
        FFRoute(
          name: TermosCondicoesWidget.routeName,
          path: TermosCondicoesWidget.routePath,
          builder: (context, params) => TermosCondicoesWidget(),
        ),
        FFRoute(
          name: MenuWidget.routeName,
          path: MenuWidget.routePath,
          builder: (context, params) => MenuWidget(),
        ),
        FFRoute(
          name: NotificationsWidget.routeName,
          path: NotificationsWidget.routePath,
          builder: (context, params) => NotificationsWidget(),
        ),
        FFRoute(
          name: EditarPerfilWidget.routeName,
          path: EditarPerfilWidget.routePath,
          builder: (context, params) => EditarPerfilWidget(),
        ),
        FFRoute(
          name: ChatWidget.routeName,
          path: ChatWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'Chat') : ChatWidget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'Home') : HomeWidget(),
        ),
        FFRoute(
          name: SeuPerfilWidget.routeName,
          path: SeuPerfilWidget.routePath,
          builder: (context, params) => SeuPerfilWidget(),
        ),
        FFRoute(
          name: Questao1Widget.routeName,
          path: Questao1Widget.routePath,
          builder: (context, params) => Questao1Widget(),
        ),
        FFRoute(
          name: Questao2Widget.routeName,
          path: Questao2Widget.routePath,
          builder: (context, params) => Questao2Widget(),
        ),
        FFRoute(
          name: Questao3Widget.routeName,
          path: Questao3Widget.routePath,
          builder: (context, params) => Questao3Widget(),
        ),
        FFRoute(
          name: Questao4Widget.routeName,
          path: Questao4Widget.routePath,
          builder: (context, params) => Questao4Widget(),
        ),
        FFRoute(
          name: Questao5Widget.routeName,
          path: Questao5Widget.routePath,
          builder: (context, params) => Questao5Widget(),
        ),
        FFRoute(
          name: SettingsWidget.routeName,
          path: SettingsWidget.routePath,
          builder: (context, params) => SettingsWidget(
            darkLight: params.getParam(
              'darkLight',
              ParamType.String,
            ),
          ),
        ),
        FFRoute(
          name: ObrigadoWidget.routeName,
          path: ObrigadoWidget.routePath,
          builder: (context, params) => ObrigadoWidget(),
        ),
        FFRoute(
          name: CadastroEmpresaWidget.routeName,
          path: CadastroEmpresaWidget.routePath,
          builder: (context, params) => CadastroEmpresaWidget(),
        ),
        FFRoute(
          name: FriendsWidget.routeName,
          path: FriendsWidget.routePath,
          builder: (context, params) => FriendsWidget(),
        ),
        FFRoute(
          name: PaymentWidget.routeName,
          path: PaymentWidget.routePath,
          builder: (context, params) => PaymentWidget(),
        ),
        FFRoute(
          name: ListaProfissionaisWidget.routeName,
          path: ListaProfissionaisWidget.routePath,
          builder: (context, params) => ListaProfissionaisWidget(),
        ),
        FFRoute(
          name: CalendarioDisponibilidadeWidget.routeName,
          path: CalendarioDisponibilidadeWidget.routePath,
          builder: (context, params) => CalendarioDisponibilidadeWidget(),
        ),
        FFRoute(
          name: PesquisadorWidget.routeName,
          path: PesquisadorWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'Pesquisador')
              : PesquisadorWidget(),
        ),
        FFRoute(
          name: FavoritesWidget.routeName,
          path: FavoritesWidget.routePath,
          builder: (context, params) => FavoritesWidget(),
        ),
        FFRoute(
          name: ConfigurationNotificationsWidget.routeName,
          path: ConfigurationNotificationsWidget.routePath,
          builder: (context, params) => ConfigurationNotificationsWidget(),
        ),
        FFRoute(
          name: PerfilViewWidget.routeName,
          path: PerfilViewWidget.routePath,
          builder: (context, params) => PerfilViewWidget(),
        ),
        FFRoute(
          name: TasksWidget.routeName,
          path: TasksWidget.routePath,
          builder: (context, params) => TasksWidget(),
        ),
        FFRoute(
          name: NotificationsInteractiveWidget.routeName,
          path: NotificationsInteractiveWidget.routePath,
          builder: (context, params) => NotificationsInteractiveWidget(),
        ),
        FFRoute(
          name: CreateTaskWidget.routeName,
          path: CreateTaskWidget.routePath,
          builder: (context, params) => CreateTaskWidget(),
        ),
        FFRoute(
          name: ChatBUGWidget.routeName,
          path: ChatBUGWidget.routePath,
          builder: (context, params) => ChatBUGWidget(),
        ),
        FFRoute(
          name: TimerWidget.routeName,
          path: TimerWidget.routePath,
          builder: (context, params) => TimerWidget(),
        ),
        FFRoute(
          name: OrcamentoWidget.routeName,
          path: OrcamentoWidget.routePath,
          builder: (context, params) => OrcamentoWidget(),
        ),
        FFRoute(
          name: PerfilCurriculoWidget.routeName,
          path: PerfilCurriculoWidget.routePath,
          builder: (context, params) => PerfilCurriculoWidget(),
        ),
        FFRoute(
          name: PoliticaPrivacidadeWidget.routeName,
          path: PoliticaPrivacidadeWidget.routePath,
          builder: (context, params) => PoliticaPrivacidadeWidget(),
        ),
        FFRoute(
          name: AjudaWidget.routeName,
          path: AjudaWidget.routePath,
          builder: (context, params) => AjudaWidget(),
        ),
        FFRoute(
          name: FaleconoscoWidget.routeName,
          path: FaleconoscoWidget.routePath,
          builder: (context, params) => FaleconoscoWidget(),
        ),
        FFRoute(
          name: ConversasWidget.routeName,
          path: ConversasWidget.routePath,
          builder: (context, params) => ConversasWidget(),
        )
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
    StructBuilder<T>? structBuilder,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
    return deserializeParam<T>(
      param,
      type,
      isList,
      structBuilder: structBuilder,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }

          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/pagInicial';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Container(
                  color: Colors.transparent,
                  child: Image.asset(
                    'assets/images/splashlogoENTSAI.gif',
                    fit: BoxFit.cover,
                  ),
                )
              : page;

          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}
