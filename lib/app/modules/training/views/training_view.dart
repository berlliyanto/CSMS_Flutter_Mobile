import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/training_controller.dart';

class TrainingView extends GetView<TrainingController> {
  const TrainingView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TrainingView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'TrainingView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
