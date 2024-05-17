// lib/main.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'bindings/simulation_binding.dart';
import 'views/simulation_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Single Server Queue Simulation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialBinding: SimulationBinding(),
      home: SimulationScreen(),
    );
  }
}
