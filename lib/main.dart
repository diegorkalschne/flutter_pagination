import 'package:flutter/material.dart';
import 'package:flutter_pagination/views/home_screen_view.dart';

void main() => runApp(const FlutterPaginationApp());

class FlutterPaginationApp extends StatelessWidget {
  const FlutterPaginationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Pagination',
      theme: ThemeData.dark(),
      home: const HomeScreenView(),
    );
  }
}
