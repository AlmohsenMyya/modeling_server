// lib/controllers/simulation_controller.dart

import 'package:get/get.dart';
import 'dart:math';
import 'dart:collection';
import '../models/customer.dart';
import '../models/server.dart';
import '../simulation.dart';

class SimulationController extends GetxController {
  var isLoading = false.obs;
  var results = <Map<String, dynamic>>[].obs;
  var inputParameters = <Map<String, double>>[
    {"interArrival": 2.0, "service": 1.0},
    {"interArrival": 3.0, "service": 1.0},
    {"interArrival": 4.0, "service": 1.0},
  ].obs; // Observable list for input parameters

  void runSimulationSet() {
    isLoading.value = true;
    results.clear();

    Future.delayed(Duration.zero, () {
      for (var param in inputParameters) {
        final result = runSimulation(param["interArrival"]!, param["service"]!, 20 );
        results.add({
          "interArrival": param["interArrival"],
          "service": param["service"],
          "result": result
        });
      }
      isLoading.value = false;
    });
  }

  // Function to add an input parameter
  void addInputParameter(double interArrival, double service) {
    inputParameters.add({"interArrival": interArrival, "service": service});
  }
  // Function to remove an input parameter
  void removeInputParameter(int index) {
    inputParameters.removeAt(index);
  }
}
