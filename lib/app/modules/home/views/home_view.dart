import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/widgets/loading.dart';
import 'package:flutter_mobile_csms/app/widgets/text.dart';
import 'package:gap/gap.dart';

import 'package:get/get.dart';
import 'package:loading_overlay_pro/loading_overlay_pro.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: GestureDetector(
              onTap: () => Get.toNamed(Routes.PROFILE),
              child: CircleAvatar(
                  backgroundColor: Colors.grey.withOpacity(0.7),
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  )),
            ),
          ),
        ],
      ),
      body: GetBuilder<HomeController>(
        builder: (builder) {
          return RefreshIndicator(
            onRefresh: () async {
              builder.getDayTime();
              await builder.getRole();
            },
            child: LoadingOverlayPro(
              isLoading: builder.isLoading.value,
              progressIndicator: loading(),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                height: double.infinity,
                width: double.infinity,
                child: Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Center(
                          child: Image.asset('assets/images/logo_home.png'),
                        ),
                        const Gap(30),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(10),
                        text(
                            "${builder.greeting.value}, ${builder.name.value}",
                            18,
                            Colors.black87,
                            FontWeight.w600,
                            TextAlign.start),
                        Container(
                          width: Get.width,
                          margin: const EdgeInsets.only(top: 10),
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Obx(() => Text(
                                builder.quote.value,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.w500,
                                ),
                              )),
                        ),
                        const Gap(5),
                        const Divider(),
                        text("Menu", 26, Colors.black87, FontWeight.bold,
                            TextAlign.center),
                        const Gap(15),
                        Expanded(
                          child: GridView.count(
                            mainAxisSpacing: 10,
                            crossAxisSpacing: 10,
                            crossAxisCount: 3,
                            children: builder.menuHome.map((e) {
                              return GestureDetector(
                                onTap: () => Get.toNamed(e['route'].toString()),
                                child: Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        color: Colors.grey.withOpacity(0.7),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Image.asset(e['image']),
                                        text(e['title'], 12, Colors.white,
                                            FontWeight.w800, TextAlign.center),
                                      ],
                                    )),
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
