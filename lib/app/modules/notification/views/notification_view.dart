import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../data/models/notifikasi_models.dart';
import '../../../data/providers/home_provider.dart';
import '../../home/views/home_view.dart';
import '../controllers/notification_controller.dart';
import '../../../widgets/navbarAppBar.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ApiServices apiService = ApiServices();

    return Scaffold(
      appBar: GradientAppBar(
        centerText: true,
        title: Text(
          'Notification',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        gradient: LinearGradient(
          colors: [
            Color(0xFF197391),
            Color(0xFF0F9EEA),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.delete,
              color: Colors.white,
            ),
            onPressed: () {
              // Prompt konfirmasi sebelum menghapus semua notifikasi
              Get.defaultDialog(
                title: 'Konfirmasi',
                middleText:
                    'Apakah Anda yakin untuk menghapus semua notifikasi?',
                confirm: ElevatedButton(
                  onPressed: () {
                    Get.back();

                    // Panggil fungsi untuk menghapus semua notifikasi
                    controller.deleteAllNotifications();
                  },
                  child: Text("Hapus"),
                ),
                cancel: ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text("Batal"),
                ),
              );
            },
          ),
        ],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Get.offAll(HomeView());
          },
        ),
      ),
      body: FutureBuilder<List<NotificationModel>>(
        future: apiService.fetchDataNotifications(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              color: Colors.blue,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  SizedBox(width: 10),
                  Lottie.asset(
                    'assets/lottie/Animation-cat-serevr.json',
                    width: 200,
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Server Erorr 500 ${snapshot.error}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                children: [
                  SizedBox(width: 10),
                  Lottie.network(
                    'https://lottie.host/21f699d1-5f97-405e-b338-e31d1a80cb9d/07uDzn6POU.json',
                    width: 200, // Sesuaikan ukuran animasi sesuai kebutuhan
                    height: 200,
                    fit: BoxFit.contain,
                  ),
                  Text(
                    'No Notifikasi',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          } else {
            List<NotificationModel> notifications = snapshot.data!;

            return ListView.builder(
              itemCount: notifications.length,
              padding: EdgeInsets.all(10),
              itemBuilder: (context, index) {
                // Ambil notifikasi pada indeks tertentu
                var notification = notifications[index];

                // Widget Card untuk menampilkan notifikasi
                return Card(
                  color: Color(0XFFBCE0FD),
                  shadowColor: Colors.black,
                  elevation: 2,
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: InkWell(
                    onTap: () {
                      // Tampilkan modal ketika kartu ditekan
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.sizeOf(context).width,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF197391), Color(0XFF0F9EEA)],
                              ),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  notification.content,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Terkirim : ${notification.created.toString().substring(0, 10)}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white),
                                ),
                                SizedBox(height: 10),
                                Text(
                                  'Telah Dibaca',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: const Color.fromARGB(
                                        255, 176, 176, 176),
                                  ),
                                ),
                                SizedBox(height: 10),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context); // Tutup modal
                                  },
                                  child: Text('Tutup'),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.amber,
                        child: Icon(
                          Icons.notification_important,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        notification.content,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10,
                        ),
                        child: Text(
                          'Terkirim : ${notification.created.toString().substring(0, 10)}',
                          style: TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      trailing: Column(
                        children: [
                          Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          Text(
                            "Dibaca",
                            style: TextStyle(
                              fontSize: 8,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
