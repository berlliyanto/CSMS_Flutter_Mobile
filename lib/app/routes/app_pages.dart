import 'package:get/get.dart';

import '../modules/assestment/bindings/assestment_binding.dart';
import '../modules/assestment/views/assestment_view.dart';
import '../modules/assestmentPenilaian/bindings/assestment_penilaian_binding.dart';
import '../modules/assestmentPenilaian/views/assestment_penilaian_view.dart';
import '../modules/cleaning/bindings/cleaning_binding.dart';
import '../modules/cleaning/views/cleaning_view.dart';
import '../modules/cleaningAssignment/bindings/cleaning_assignment_binding.dart';
import '../modules/cleaningAssignment/bindings/cleaning_assignment_detail_binding.dart';
import '../modules/cleaningAssignment/views/cleaning_assignment_detail.dart';
import '../modules/cleaningAssignment/views/cleaning_assignment_view.dart';
import '../modules/cleaningData/bindings/cleaning_data_binding.dart';
import '../modules/cleaningData/views/cleaning_data_view.dart';
import '../modules/cleaningDetail/bindings/cleaning_detail_binding.dart';
import '../modules/cleaningDetail/views/cleaning_detail_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/other/bindings/file_binding.dart';
import '../modules/other/bindings/qr_binding.dart';
import '../modules/other/view/qr_scanner.dart';
import '../modules/other/view/qr_view.dart';
import '../modules/other/view/zoom_image.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/report/bindings/report_binding.dart';
import '../modules/report/views/report_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/training/bindings/training_binding.dart';
import '../modules/training/views/training_view.dart';
import '../modules/userVerification/bindings/user_verification_binding.dart';
import '../modules/userVerification/views/user_verification_view.dart';

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
        page: () => const FullScreenImagePage(),
        binding: FileBindings()),
    GetPage(
      name: _Paths.QR_VIEW,
      page: () => const QRView(),
    ),
    GetPage(
        name: _Paths.QR_SCANNER,
        page: () => const QRScanner(),
        binding: QRBinding()),
    GetPage(
      name: _Paths.USER_VERIFICATION,
      page: () => const UserVerificationView(),
      binding: UserVerificationBinding(),
    ),
    GetPage(
      name: _Paths.REPORT,
      page: () => const ReportView(),
      binding: ReportBinding(),
    ),
    GetPage(
      name: _Paths.TRAINING,
      page: () => const TrainingView(),
      binding: TrainingBinding(),
    ),
  ];
}
