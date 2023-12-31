// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';

// import 'package:get/get.dart';
// import 'package:productivity_tracker_app/app/modules/project/bindings/project_binding.dart';
// import 'package:sp_util/sp_util.dart';

// import 'app/routes/app_pages.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SpUtil.getInstance();
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//         statusBarColor: Color(0xFF000),
//         statusBarIconBrightness: Brightness.dark,
//         systemNavigationBarColor: Colors.black),
//   );
//   runApp(
//     GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       builder: EasyLoading.init(),
//       theme: ThemeData(
//         primaryColor: Colors.white,
//       ),
//       title: "Application",
//       initialBinding: ProjectBinding(),
//       initialRoute: SpUtil.getBool('already_login', defValue: false)! == true
//           ? Routes.HOME
//           : AppPages.INITIAL,

//       // initialRoute: Routes.WELCOME,
//       // initialRoute: Routes.DETAIL_PROJECT,
//       getPages: AppPages.routes,
//     ),
//   );
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
import 'package:productivity_tracker_app/app/modules/project/bindings/project_binding.dart';
import 'package:sp_util/sp_util.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SpUtil.getInstance();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF000),
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.black,
    ),
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      builder: EasyLoading.init(),
      theme: ThemeData(
        primaryColor: Colors.white,
      ),
      title: "Protracker",
      initialBinding: ProjectBinding(),
      getPages: AppPages.routes,
      home: SplashScreen(),
    ),
  );
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulasi delay selama 3 detik (sesuaikan dengan kebutuhan)
    Future.delayed(
      Duration(seconds: 4),
      () {
        // Periksa kondisi untuk menentukan nama rute
        String initialRoute =
            SpUtil.getBool('already_login', defValue: false) == true
                ? Routes.HOME
                : AppPages.INITIAL;

        // Navigasi ke halaman beranda atau halaman awal
        Get.offNamed(initialRoute);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 200,
            ),
            Container(
              child: Center(
                child: Image.asset(
                  'assets/icons/PROTracker2.png',
                  width: 290,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                //  Lottie.asset(
                //   'assets/lottie/Animation-cat-serevr.json',
                //   width: 200, // Sesuaikan ukuran animasi sesuai kebutuhan
                //   height: 200,
                //   fit: BoxFit.contain,
                // ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



// Jika anda merasa diri anda gila, tidak perlu anda merasa karena semua orang  juga sudah tau, hahaha hahaha, wkwkw wkwk wkw wk, tapi pelase jangan emosi ya ttd, tanda tangan kamu juga bagus,  

// seputar  bale kata biking beta ta pata parcuma nona se pui cinta bukan par beta kanapa nona sepung cinta bukan par beta kana  janji yang se bilang Hahahahahaha,
// TES KEYBOAR GUYS JANGAN MARAH YA UKE HEHEHE