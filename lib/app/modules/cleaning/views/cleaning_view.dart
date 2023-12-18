
import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/cleaning_controller.dart';

class CleaningView extends GetView<CleaningController> {
  const CleaningView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Cleaning'),
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () async {
              await controller.fetchAllAPI();
              },
              icon: const Icon(Icons.refresh),
            )
          ]
        ),
        body: GetBuilder<CleaningController>(builder: (builder){
          return RefreshIndicator(
            onRefresh: () async {
              await builder.getRole();
              await builder.fetchAllAPI();
            },
            child: LoadingOverlayPro(
              isLoading: builder.isLoading.value,
              progressIndicator: loading(),
              child: builder.bodyCleaning(),),
          );
        })
    );
  }
}
