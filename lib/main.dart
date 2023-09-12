import 'package:flutter/material.dart';
import 'package:table_app/ui/table_view%20cell.dart';
import 'package:table_app/ui/table_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    const breakpointWidth = 200.0;
    final Widget selectedPage = screenSize.width < breakpointWidth
        ? const TableViewCell()
        : const TableView();

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: selectedPage,
        ),
      ),
    );
  }
}
