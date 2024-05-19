import 'dart:math';
import 'dart:collection';

// Define the Customer class
class Customer {
  final double arrivalTime;
  double? startServiceTime;
  double? endServiceTime;

  Customer(this.arrivalTime);
}

// Define the Server class
class Server {
  bool isBusy = false;
  Customer? currentCustomer;
}

// Function to generate a random number following an exponential distribution
// لارجاع قيمة عشوائية تتبع توزيعا اسيا
double exponentialDistribution(Random random, double mean) {
  return -mean * log(1 - random.nextDouble());
}

// Function to run the simulation
Map<String, dynamic> runSimulation(
    double meanInterArrivalTime, double meanServiceTime, int simulationTime) {
  /*
  * تنفيذ المحاكاة:

تُعرف دالة runSimulation التي تأخذ متوسط زمن الوصول ومتوسط زمن الخدمة وزمن المحاكاة كمدخلات.
تُعرف المتغيرات اللازمة مثل الوقت الحالي وعدد العملاء وعدد العملاء المخدومين وإجمالي وقت الانتظار والخدمة ووقت اشتغال الخادم.
يتم إنشاء قائمة انتظار (queue) للاعتماد على نظام الانتظار الأولى في الدخول، أي FIFO.
يتم تنفيذ حلقة تمثل وقت المحاكاة حتى الوصول إلى الحد الزمني.
في كل تكرار من الحلقة، يتم إنشاء عميل جديد وإضافته إلى قائمة الانتظار، ثم يتم خدمته إذا كان الخادم غير مشغول.
يتم حساب الوقت الذي يقضيه العميل في الانتظار وفي الخدمة وتحديث المتغيرات ذات الصلة.
في نهاية المحاكاة، يتم حساب النتائج مثل عدد العملاء وعدد العملاء المخدومين ومتوسط الانتظار والخدمة ونسبة استخدام الخادم، وتُرجع هذه النتائج كجدول.

  * */
  // Initialize variables
  Random random = Random();
  double currentTime = 0;
  int customerCount = 0;
  int customersServed = 0;
  double totalWaitTime = 0;
  double totalServiceTime = 0;
  double serverBusyTime = 0;

  // Initialize data structures
  Queue<Customer> queue = Queue();
  Server server = Server();

// Simulation loop
// Simulation loop
  while (currentTime < simulationTime) {
    // Generate random inter-arrival and service times
    double interArrivalTime =
        exponentialDistribution(random, meanInterArrivalTime);
    double serviceTime = exponentialDistribution(random, meanServiceTime);

    // Update current time
    currentTime += interArrivalTime;
    if (currentTime >= simulationTime) break;

    // print('Customer arrived at time: $currentTime');

    // Create and add new customer to the queue
    Customer customer = Customer(currentTime);
    queue.add(customer);
    customerCount++;
    // print('Customer added to queue. Queue length: ${queue.length}');

    // Serve the customer if the server is idle
    if (!server.isBusy && queue.isNotEmpty) {
      server.isBusy = true;
      server.currentCustomer = queue.removeFirst();
      server.currentCustomer!.startServiceTime = currentTime;
      server.currentCustomer!.endServiceTime = currentTime + serviceTime;
      serverBusyTime += serviceTime;
      // print('Customer ${server.currentCustomer!.arrivalTime} started service at time: ${server.currentCustomer!.startServiceTime}');
    }

    // Check if the current customer's service is complete
    if (server.currentCustomer != null &&
        server.currentCustomer!.endServiceTime! <= currentTime) {
      // Update metrics and serve the next customer
      print(
          " interArrivalTime $interArrivalTime serviceTime $serviceTime currenttime $currentTime *** server.currentCustomer!.arrivalTime ${server.currentCustomer!.arrivalTime} server.currentCustomer!.startServiceTime! ${server.currentCustomer!.startServiceTime!} server.currentCustomer!.endServiceTime! ${server.currentCustomer!.endServiceTime!} ");
      print("---------------------------------------------");
      customersServed++;
      totalServiceTime += serviceTime;
      double waitTime = server.currentCustomer!.startServiceTime! -
          server.currentCustomer!.arrivalTime;
      totalWaitTime += waitTime;
      server.isBusy = false;
      server.currentCustomer = null;
      // print('Customer completed service at time: $currentTime. Wait time: $waitTime');
    }
  }

  print('Simulation completed');

  // Calculate performance metrics
  double throughputRate = customersServed / simulationTime;
  double serverUtilization = serverBusyTime / simulationTime * 100;
  double meanCustomerWaitTime = totalWaitTime / customersServed;
  // print("double meanCustomerWaitTime = $totalWaitTime / $customersServed;");
  double meanCustomerServiceTime = totalServiceTime / customersServed;

  // Return simulation results
  return {
    "customerCount": customerCount,
    "customersServed": customersServed,
    "throughputRate": throughputRate,
    "serverUtilization": serverUtilization,
    "meanWaitTime": meanCustomerWaitTime,
    "meanServiceTime": meanCustomerServiceTime
  };
}
