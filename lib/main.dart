import 'package:flutter/material.dart';

/// Run this entrypoint when you want to send a Universal Link and debug when/where Flutter
/// surfaces that info.
void main() {
  runApp(
    const _UniversalLinkDebuggingApp(),
  );
}

class _UniversalLinkDebuggingApp extends StatefulWidget {
  const _UniversalLinkDebuggingApp();

  @override
  State<_UniversalLinkDebuggingApp> createState() => _UniversalLinkDebuggingAppState();
}

class _UniversalLinkDebuggingAppState extends State<_UniversalLinkDebuggingApp> with WidgetsBindingObserver {
  final _log = StringBuffer("Start Route Log:\n\n");

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) async {
    setState(() {
      _log.write("Pushed route: ${routeInformation.uri.toString()}\n\n");
    });

    return await super.didPushRouteInformation(routeInformation);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: SafeArea(
            child: Text(
              _log.toString(),
            ),
          ),
        ),
      ),
    );
  }
}