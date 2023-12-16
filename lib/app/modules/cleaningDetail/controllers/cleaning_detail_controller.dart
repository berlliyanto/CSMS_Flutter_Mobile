import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mobile_csms/app/models/task_by_cleaner_model.dart';
import 'package:flutter_mobile_csms/app/models/user_model.dart';
import 'package:flutter_mobile_csms/app/routes/app_pages.dart';
import 'package:flutter_mobile_csms/app/services/Tasks/tasks_by_cleaner_service.dart';
import 'package:flutter_mobile_csms/app/widgets/dialog.dart';
import 'package:flutter_mobile_csms/app/widgets/snackbar.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class CleaningDetailController extends GetxController {
  TasksByCleanerModel taskByCleaner = TasksByCleanerModel(
    id: 0,
    alasan: '',
    status: '',
    catatan: '',
    cleanerId: 0,
    assignId: 0,
    imageBefore: '',
    imageProgress: '',
    imageFinish: '',
    tasks: [],
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
    assign: Assign(
        id: 0,
        codeCS: '',
        assignBy: Cleaner(id: 0, name: ''),
        area: Area(id: 0, areaName: ''),
        location: Location(id: 0, locationName: ''),
        checkedSupervisorAt: null,
        verifiedDanoneAt: null),
    cleaner: Cleaner(id: 0, name: ''),
  );

  late ArgCD arg;
  File? imageBefore;
  File? imageProgress;
  File? imageFinish;

  TextEditingController alasanController = TextEditingController();
  TextEditingController catatanController = TextEditingController();
  List<UserModel> cleaners = [];
  var isLoading = false.obs;
  var isNotFinish = false.obs;

  final imagePicker = ImagePicker();

  bool isValidImageExtension(File image) {
    final validExtensions = ['jpg', 'jpeg', 'png', 'gif'];
    String extension = image.path.split('.').last.toLowerCase();
    return validExtensions.contains(extension);
  }

  Future getImage(ImageSource source, String tipe) async {
    final image = await imagePicker.pickImage(source: source);

    if (image?.path != null) {
      File imageFile = File(image!.path);
      if (isValidImageExtension(imageFile) &&
          imageFile.lengthSync() < 4 * 1024 * 1024) {
        if (tipe == "before") {
          imageBefore = imageFile;
        } else if (tipe == "progress") {
          imageProgress = imageFile;
        } else if (tipe == "finish") {
          imageFinish = imageFile;
        }
      } else {
        snackBar("Error", "File terlalu besar atau format tidak sesuai",
            SnackPosition.TOP, 10, Colors.red, Colors.white);
      }
    }

    update();

    return true;
  }

  Future deleteImage(String tipe) async {
    if (tipe == "before") {
      imageBefore = null;
    } else if (tipe == "progress") {
      imageProgress = null;
    } else if (tipe == "finish") {
      imageFinish = null;
    }
    update();
  }

  Future updateFinishTask() async {
    FormData formData = FormData({});
    formData.fields.add(MapEntry("alasan", alasanController.text));
    formData.fields.add(MapEntry("catatan", catatanController.text));
    formData.fields
        .add(MapEntry("status", isNotFinish.value ? "Not Finish" : "Finish"));
    if (imageBefore != null) {
      formData.files.add(
        MapEntry(
          "image_before",
          MultipartFile(
            File(imageBefore!.path),
            filename: "${DateTime.now()}1",
            // filename: imageBefore!.path.split('/').last,
          ),
        ),
      );
    }
    if (imageProgress != null) {
      formData.files.add(
        MapEntry(
          "image_progress",
          MultipartFile(
            File(imageProgress!.path),
            filename: "${DateTime.now()}2",
            // filename: imageProgress!.path.split('/').last,
          ),
        ),
      );
    }
    if (imageFinish != null) {
      formData.files.add(
        MapEntry(
          "image_finish",
          MultipartFile(
            File(imageFinish!.path),
            filename: "${DateTime.now()}3",
            // filename: imageFinish!.path.split('/').last,
          ),
        ),
      );
    }
    print(isNotFinish.value);
    if (isNotFinish.value == true) {
      if (alasanController.text.isEmpty) {
        snackBar("Error", "Alasan harus diisi", SnackPosition.TOP, 10,
            const Color.fromARGB(255, 188, 169, 2), Colors.white);
        return;
      }
    }

    if (imageBefore == null && imageProgress == null && imageFinish == null) {
      dialog("Gambar tidak ada", "Apakah anda yakin ?", "Ya", "tidak", () {
        isLoading.value = true;
        update();
        sendUpdateFinishTask(formData);
        isLoading.value = false;
        update();
      });
      return;
    }

    isLoading.value = true;
    update();

    sendUpdateFinishTask(formData);

    isLoading.value = false;
    update();
  }

  Future sendUpdateFinishTask(FormData formData) async {
    final response =
        await TaskByCleanerService().updateFinishTask(formData, arg.id);
    if (response.statusCode == 200) {
      Get.offNamed(Routes.CLEANING);
      snackBar("Success", "Berhasil update", SnackPosition.TOP, 10,
          Colors.green, Colors.white);
    } else {
      snackBar("Error", "Something went wrong", SnackPosition.TOP, 10,
          Colors.red, Colors.white);
    }
  }

  Future getCleaningDetail() async {
    isLoading.value = true;
    final response =
        await TaskByCleanerService().showTaskByCleaner(arg.id, arg.assignId);

    taskByCleaner = response.body != null
        ? TasksByCleanerModel.fromJson(response.body['data'])
        : TasksByCleanerModel(
            id: 0,
            alasan: '',
            status: '',
            cleanerId: 0,
            assignId: 0,
            imageBefore: '',
            imageProgress: '',
            catatan: '',
            imageFinish: '',
            tasks: [],
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
            assign: Assign(
                id: 0,
                codeCS: '',
                assignBy: Cleaner(id: 0, name: ''),
                area: Area(id: 0, areaName: ''),
                location: Location(id: 0, locationName: ''),
                verifiedDanoneAt: null,
                checkedSupervisorAt: null),
            cleaner: Cleaner(id: 0, name: ''));
    cleaners = response.body != null
        ? (List.from(response.body['cleaners']))
            .map((e) => UserModel.fromJson(e))
            .toList()
        : [];

    isLoading.value = false;
    update();
  }

  Future updateStatusTask(String status) async {
    final response =
        await TaskByCleanerService().updateStatusTask(arg.id, status);

    if (response.statusCode == 200) {
      getCleaningDetail();
    } else {
      Get.snackbar(
        "Error",
        "Something went wrong",
        snackPosition: SnackPosition.TOP,
      );
    }

    update();
  }

  @override
  void onInit() async {
    super.onInit();
    arg = Get.arguments;
    getCleaningDetail();
  }

  @override
  void onClose() {
    super.onClose();
    cleaners.clear();
  }
}

class ArgCD {
  final int id, assignId;

  ArgCD({required this.id, required this.assignId});

  factory ArgCD.fromJson(Map<String, dynamic> json) {
    return ArgCD(
      id: json['id'],
      assignId: json['assignId'],
    );
  }
}
