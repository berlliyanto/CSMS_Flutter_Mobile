
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
        ),
        body: GetBuilder<CleaningController>(builder: (builder){
          return LoadingOverlayPro(
            isLoading: builder.isLoading.value,
            progressIndicator: loading(),
            child: builder.bodyCleaning(),);
        })
    );
  }
}
