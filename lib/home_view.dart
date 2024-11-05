import 'dart:isolate';

import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    complexTask1() {
      var total = 0.0;
      for (var i = 0; i < 1000000000; i++) {
        total += i;
      }
      return total;
    }

    complexTask2(SendPort sendPort) {
      var total = 0.0;
      for (var i = 0; i < 1000000000; i++) {
        total += i;
      }
      sendPort.send(total);
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: Text("Flutter Isolate"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            "asset/image/ball.gif",
            height: 200,
          ),
          SizedBox(
            height: 25,
          ),
          //WithOut Isolate
          ElevatedButton(
              onPressed: () {
                var total = complexTask1();
                print("Result 1 : $total");
              },
              child: Text("Task 1")),
          SizedBox(
            height: 15,
          ),
          //Isolate
          ElevatedButton(
              onPressed: () async {
                final receivePort = ReceivePort();
                await Isolate.spawn(complexTask2, receivePort.sendPort);
                receivePort.listen((total) {
                  print("Result 2: $total");
                });
              },
              child: Text("Task 2")),
        ],
      )),
    );
  }
}
