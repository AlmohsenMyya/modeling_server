// lib/simulation.dart

import 'dart:math';
import 'dart:collection';
import 'models/customer.dart';
import 'models/server.dart';

double exponentialDistribution(Random random, double mean) {
  return -mean * log(1 - random.nextDouble());
}

Map<String, dynamic> runSimulation(double meanInterArrivalTime, double meanServiceTime, int simulationTime) {
  Random random = Random();
  double currentTime = 0;
  int customerCount = 0;
  int customersServed = 0;
  double totalWaitTime = 0;
  double totalServiceTime = 0;
  double serverBusyTime = 0;

  Queue<Customer> queue = Queue();
  Server server = Server();

  while (currentTime < simulationTime) {
    double interArrivalTime = exponentialDistribution(random, meanInterArrivalTime);
    double serviceTime = exponentialDistribution(random, meanServiceTime);

    currentTime += interArrivalTime;
    if (currentTime >= simulationTime) break;

    Customer customer = Customer(currentTime);
    queue.add(customer);
    customerCount++;

    if (!server.isBusy && queue.isNotEmpty) {
      server.isBusy = true;
      server.currentCustomer = queue.removeFirst();
      server.currentCustomer!.startServiceTime = currentTime;
      server.currentCustomer!.endServiceTime = currentTime + serviceTime;
      serverBusyTime += serviceTime;
    }

    if (server.currentCustomer != null && server.currentCustomer!.endServiceTime! <= currentTime) {
      customersServed++;
      totalServiceTime += serviceTime;
      totalWaitTime += server.currentCustomer!.startServiceTime! - server.currentCustomer!.arrivalTime;
      server.isBusy = false;
      server.currentCustomer = null;
    }
  }

  double throughputRate = customersServed / simulationTime;
  double serverUtilization = serverBusyTime / simulationTime * 100;
  double meanCustomerWaitTime = totalWaitTime / customersServed;
  double meanCustomerServiceTime = totalServiceTime / customersServed;

  return {
    "customerCount": customerCount,
    "customersServed": customersServed,
    "throughputRate": throughputRate,
    "serverUtilization": serverUtilization,
    "meanWaitTime": meanCustomerWaitTime,
    "meanServiceTime": meanCustomerServiceTime
  };
}
