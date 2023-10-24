import 'package:flutter/material.dart';
import 'package:notes_app/data/utils/others/custom_page_route_transition.dart';

kNavigation (BuildContext context, Widget route) {
  return Navigator.of(context).push(MyCustomRouteTransition(route: route));
}