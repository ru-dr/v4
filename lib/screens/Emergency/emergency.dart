import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:v4/controllers/location_controller.dart';

class Emergency extends StatefulWidget {
  const Emergency({Key? key}) : super(key: key);

  @override
  _EmergencyState createState() => _EmergencyState();
}

class _EmergencyState extends State<Emergency> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      Get.find<LocationController>().getCurrentLocation();
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(
        init: LocationController(),
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
                title: Text(
                  "Emergency",
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                backgroundColor: const Color(0xff0E1219),
                iconTheme: const IconThemeData(color: Color(0xffffffff)),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                )),
            body: Center(
              child: controller.isLoading.value
                  ? const CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            controller.currentLocation == null
                                ? 'Location not found'
                                : controller.currentLocation!,
                            style: const TextStyle(
                                fontSize: 23, color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
            ),
          );
        });
  }
}
