import 'package:flutter/material.dart';

abstract class RouterService {
  RouterDelegate<Object> get routerDelegate;
  RouteInformationParser<Object> get routeInformationParser;
  RouteInformationProvider? get routeInformationProvider;
}
