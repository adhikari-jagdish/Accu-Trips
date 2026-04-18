import 'package:accu_trips/common/view_utils/header.dart';
import 'package:flutter/material.dart';

class RootLayout extends StatelessWidget {
  const RootLayout({super.key, this.headerTitle, this.child, this.fab, this.fabLocation, this.drawer});
  final String? headerTitle;
  final Widget? child;
  final FloatingActionButtonLocation? fabLocation;
  final Widget? fab;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Header(headerTitle: headerTitle ?? ''),
      body: child ?? Container(),
      drawer: drawer,
      floatingActionButton: fab,
      floatingActionButtonLocation: fabLocation ?? FloatingActionButtonLocation.endFloat,
    );
  }
}
