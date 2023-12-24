import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QRScanner extends GetView {
  const QRScanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Builder(
        builder: (context) => Container(
          alignment: Alignment.center,
          child: const Flex(
            direction: Axis.vertical,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              
            ],
          ),
        ),
      )
    );
  }
}
