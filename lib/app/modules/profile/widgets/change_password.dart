import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/modules/profile/controllers/profile_controller.dart';
import 'package:flutter_mobile_csms/app/widgets/button.dart';
import 'package:gap/gap.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

Widget changePassword(ProfileController controller) {
  return Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
          )
        ]),
    child: Column(
      children: [
        Obx(
          () => TextField(
            
            controller: controller.password1,
            obscureText: controller.isObscure1.value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.deepOrange, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Password",
              labelStyle: const TextStyle(color: Colors.deepOrange),
              suffixIcon: IconButton(
                  onPressed: () => controller.changeObscure(1),
                  icon: Icon(
                    controller.isObscure1.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.deepOrange,
                  )),
            ),
          ),
        ),
        const Gap(10),
        Obx(
          () => TextField(
            
            controller: controller.password2,
            obscureText: controller.isObscure2.value,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.deepOrange),
                borderRadius: BorderRadius.circular(10),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    const BorderSide(color: Colors.deepOrange, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              labelText: "Confirm Password",
              labelStyle: const TextStyle(color: Colors.deepOrange),
              suffixIcon: IconButton(
                  onPressed: () => controller.changeObscure(2),
                  icon: Icon(
                    controller.isObscure2.value
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Colors.deepOrange,
                  )),
            ),
          ),
        ),
        const Gap(10),
        customButton("Ubah Password", Colors.deepOrange, 5, 5, () => controller.updatePassword())
      ],
    ),
  );
}
