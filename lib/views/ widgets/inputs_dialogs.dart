import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/simulation_controller.dart';

// Function to show dialog for adding input parameters
Future<void> showInputDialog(
    BuildContext context, SimulationController controller) async {
  TextEditingController interArrivalController = TextEditingController();
  TextEditingController serviceController = TextEditingController();

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Obx(() => Text('${controller.inputParameters.length} - Binary Input ')),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Obx(() => SizedBox(
                height: 100,
                child: SingleChildScrollView(
                  child: Column(
                        children: List.generate(
                          controller.inputParameters.length,
                          (index) {
                            final parameter = controller.inputParameters[index];
                            return Column(
                              children: [
                                Container(
                                  color : Colors.white,
                                  child: ListTile(
                                    title: Text(
                                      'Inter-Arrival: ${parameter["interArrival"]}, Service: ${parameter["service"]}',
                                      style: TextStyle(fontSize: 11),
                                    ),
                                    splashColor: Colors.blue,
                                    trailing: IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        controller.removeInputParameter(index);
                                      },
                                    ),
                                  ),
                                ),
                                Divider(color: Colors.blue,)
                              ],
                            );
                          },
                        ),
                      ),
                ),
              )),
              SizedBox(height: 10),
              TextField(
                controller: interArrivalController,
                decoration: InputDecoration(labelText: 'Inter-Arrival Time'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              TextField(
                controller: serviceController,
                decoration: InputDecoration(labelText: 'Service Time'),
                keyboardType: TextInputType.numberWithOptions(decimal: true),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      double interArrival =
                          double.parse(interArrivalController.text);
                      double service = double.parse(serviceController.text);
                      controller.addInputParameter(interArrival, service);

                      interArrivalController.clear();
                      serviceController.clear();
                    },
                    child: Text('Add Binary'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text('Close'),
                  ),
                ],
              ),
              SizedBox(height: 10),
            ],
          ),
        ),
      );
    },
  );
}
