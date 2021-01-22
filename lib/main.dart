import 'package:flutter/material.dart';
import 'package:get_api_0/screens/screens.dart';

void main() {
  runApp(
    ApiGet(),
  );
}

class ApiGet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}
