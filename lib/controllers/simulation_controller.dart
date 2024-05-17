// lib/controllers/simulation_controller.dart

import 'package:get/get.dart';
import 'dart:math';
import 'dart:collection';
import '../models/customer.dart';
import '../models/server.dart';
import '../simulation.dart';

class SimulationController extends GetxController {
  var isLoading = false.obs; // Observable for loading state
  var results = <Map<String, dynamic>>[].obs; // Observable list for results

  // Function to run a set of simulations with different parameters.
  void runSimulationSet() {
    isLoading.value = true; // Show loading indicator.
    results.clear(); // Clear previous results.

    Future.delayed(Duration.zero, () {
      final params = [
        {"interArrival": 2.0, "service": 1.0},
        {"interArrival": 3.0, "service": 1.0},
        {"interArrival": 4.0, "service": 1.0},
      ];
      for (var param in params) {
        final result = runSimulation(param["interArrival"]!, param["service"]!, 1000000);
        results.add({
          "interArrival": param["interArrival"],
          "service": param["service"],
          "result": result
        });
      }
      isLoading.value = false; // Hide loading indicator.
    });
  }
}
