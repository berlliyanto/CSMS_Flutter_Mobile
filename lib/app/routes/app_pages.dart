import 'package:flutter_mobile_csms/app/modules/image/qr_view.dart';
import 'package:flutter_mobile_csms/app/modules/image/zoom_image.dart';
import 'package:get/get.dart';

import '../modules/assestment/bindings/assestment_binding.dart';
import '../modules/assestment/views/assestment_view.dart';
import '../modules/assestmentPenilaian/bindings/assestment_penilaian_binding.dart';
import '../modules/assestmentPenilaian/views/assestment_penilaian_view.dart';
import '../modules/cleaning/bindings/cleaning_binding.dart';
import '../modules/cleaning/views/cleaning_view.dart';
import '../modules/cleaningAssignment/bindings/cleaning_assignment_binding.dart';
import '../modules/cleaningAssignment/bindings/cleaning_assignment_detail_binding.dart';
import '../modules/cleaningAssignment/views/cleaning_assignment_view.dart';
import '../modules/cleaningAssignment/views/cleaning_assignment_detail.dart';
import '../modules/cleaningData/bindings/cleaning_data_binding.dart';
import '../modules/cleaningData/views/cleaning_data_view.dart';
import '../modules/cleaningDetail/bindings/cleaning_detail_binding.dart';
import '../modules/cleaningDetail/views/cleaning_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
      children: [
        GetPage(
          name: _Paths.HOME,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.CLEANING,
      page: () => const CleaningView(),
      binding: CleaningBinding(),
    ),
    GetPage(
      name: _Paths.ASSESMENT,
      page: () => const AssestmentView(),
      binding: AssestmentBinding(),
    ),
    GetPage(
      name: _Paths.ASSESTMENT_PENILAIAN,
      page: () => const AssestmentPenilaianView(),
      binding: AssestmentPenilaianBinding(),
    ),
    GetPage(
      name: _Paths.CLEANING_DETAIL,
      page: () => const CleaningDetailView(),
      binding: CleaningDetailBinding(),
    ),
    GetPage(
      name: _Paths.CLEANING_DATA,
      page: () => const CleaningDataView(),
      binding: CleaningDataBinding(),
    ),
    GetPage(
      name: _Paths.CLEANING_ASSIGNMENT,
      page: () => const CleaningAssignmentView(),
      binding: CleaningAssignmentBinding(),
    ),
    GetPage(
        name: _Paths.CLEANING_ASSIGNMENT_DETAIL,
        page: () => const CleaningAssignmentDetailView(),
        binding: CleaningAssignmentDetailBinding()),
    GetPage(
      name: _Paths.PROFILE,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ZOOM_IMAGE,
      page: () => const FullScreenImagePage()
    ),
    GetPage(
      name: _Paths.QR_VIEW,
      page: () => const QRView()
    ),

  ];
}
