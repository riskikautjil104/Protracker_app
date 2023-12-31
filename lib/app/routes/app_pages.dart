import 'package:get/get.dart';
import 'package:productivity_tracker_app/app/modules/project/views/detail_project.dart';
import 'package:productivity_tracker_app/app/modules/project/views/projects2_view.dart';
// import 'package:productivity_tracker_app/app/modules/project/views/target.dart';

import '../modules/project/bindings/project_binding.dart';
// import '../modules/project/views/projects_view.dart';
import '../modules/task/bindings/task_binding.dart';
import '../modules/task/views/crew_task_view.dart';
import '../modules/forgot/bindings/forgot_binding.dart';
import '../modules/forgot/views/changepasswordsuccess.dart';
import '../modules/forgot/views/createNewPassword.dart';
import '../modules/forgot/views/forgot_view.dart';
import '../modules/forgot/views/otpVerification.dart';
import '../modules/home/bindings/home_binding.dart';
// import '../modules/home/views/home_pm_views.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/notification/bindings/notification_binding.dart';
import '../modules/notification/views/notification_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/register/bindings/register_binding.dart';
import '../modules/register/views/register_view.dart';
import '../modules/statistik/bindings/statistik_binding.dart';
import '../modules/statistik/views/statistik_view.dart';
import '../modules/welcome/bindings/welcome_binding.dart';
import '../modules/welcome/views/welcome_view.dart';

// import '../modules/home/views/home_pm_views.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.WELCOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.HomeViewPm, // Use the correct path name for HomeViewPm
    //   page: () => const HomeViewPm(),
    //   binding: HomeBinding(),
    // ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.WELCOME,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: _Paths.REGISTER,
      page: () => RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.FORGOT,
      page: () => const ForgotView(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: _Paths.OTPVERIFICATION,
      page: () => const OtpVerificationView(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: _Paths.CREATENEWPASSWORD,
      page: () => CreateNewPasswordView(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORDSUCCESS,
      page: () => const ChangePasswordSuccessView(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.STATISTIK,
      page: () => const StatistikView(),
      binding: StatistikBinding(),
    ),
    GetPage(
      name: _Paths.NOTIFICATION,
      page: () => const NotificationView(),
      binding: NotificationBinding(),
    ),
    GetPage(
      name: _Paths.PROJECT,
      page: () => Project2View(),
      binding: ProjectBinding(),
    ),
    GetPage(
      name: _Paths.CREW_TASK,
      page: () => const CrewTaskView(),
      binding: TaskBinding(),
    ),
    GetPage(
      name: _Paths.DETAIL_PROJECT,
      page: () => DetailProjectView(),
      binding: ProjectBinding(),
    ),
    // GetPage(
    //   name: _Paths.TARGET,
    //   page: () => TargetView(),
    //   binding: ProjectBinding(),
    // ),
  ];
}
