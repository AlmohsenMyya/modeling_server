// lib/views/simulation_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/simulation_controller.dart';

class SimulationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SimulationController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Server Queue Simulation'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.results.isEmpty
                ? Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: controller.runSimulationSet,
                          child: const Text('Run Simulations'),
                        ),
                        const SizedBox(height: 20),
                        const Text('No results yet.')
                      ],
                    ),
                  )
                : Column(
                    children: [
                      ElevatedButton(
                        onPressed: controller.runSimulationSet,
                        child: const Text('Rerun Simulations'),
                      ),
                      const SizedBox(height: 20),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.results.length,
                          itemBuilder: (context, index) {
                            final result = controller.results[index];
                            final data = result["result"];
                            return Card(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Inter-Arrival Time: ${result["interArrival"]}, Service Time: ${result["service"]}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                        'Number of customers entered: ${data["customerCount"]}'),
                                    Text(
                                        'Number of customers served: ${data["customersServed"]}'),
                                    Text(
                                        'Throughput rate: ${data["throughputRate"].toStringAsFixed(2)}'),
                                    Text(
                                        'Server utilization: ${data["serverUtilization"].toStringAsFixed(2)}%'),
                                    Text(
                                        'Mean wait time: ${data["meanWaitTime"].toStringAsFixed(2)}'),
                                    Text(
                                        'Mean service time: ${data["meanServiceTime"].toStringAsFixed(2)}'),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
          );
        }
      }),
    );
  }
}
