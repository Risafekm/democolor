import 'package:flutter/material.dart';
import 'package:halfcontainerproject/home_screen/stateful.dart';
import 'package:halfcontainerproject/home_screen/stateless.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          Expanded(child: SLess()),
          Divider(),
          Expanded(child: SFul()),
        ],
      ),
    );
  }
}
