// lib/views/simulation_screen.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import ' widgets/inputs_dialogs.dart';
import '../controllers/simulation_controller.dart';
import 'info_screen.dart';

class SimulationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final SimulationController controller = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Text('Single Server Queue Simulation' , style: TextStyle(fontSize: 18),),
            Spacer(),
            IconButton(
              icon: Icon(Icons.info_outline),
              onPressed: () {
                Get.to(DevelopersPage());
              },
            )
          ],
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: controller.results.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onLongPress: () =>
                              showInputDialog(context, controller),
                          onPressed: controller.runSimulationSet,
                          child: const Text('Run Simulations'),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('No results yet.'),
                      ],
                    ),
                  )
                : Column(
                    children: [
                      ElevatedButton(
                        onLongPress: () => showInputDialog(context, controller),
                        onPressed: controller.runSimulationSet,
                        child: const Text('Rerun Simulations'),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: controller.results.length,
                          itemBuilder: (context, index) {

                            final result = controller.results[index];
                            final data = result["result"];
                            // print(data);
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Inter-Arrival Time: ${result["interArrival"]}, Service Time: ${result["service"]}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 10),
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
