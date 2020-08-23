import 'package:flutter/material.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';
import 'package:permission_handler/permission_handler.dart';

import '../const.dart';

class SignUpScreen1 extends StatelessWidget {
  static const String routeName = '/sign-up-screen-1';

  Future<void> askPermission(BuildContext context) async {
    await [
      Permission.camera,
      Permission.notification,
      Permission.location,
    ].request();

    if (await Permission.locationWhenInUse.serviceStatus.isDisabled) {
      Permission.locationWhenInUse.request();
    }

    if (await Permission.locationWhenInUse.serviceStatus.isEnabled &&
        await Permission.location.isGranted &&
        await Permission.camera.isGranted &&
        await Permission.notification.isGranted) {
      final email = ModalRoute.of(context).settings.arguments;
      Navigator.of(context)
          .pushNamed(SignUpScreen2.routeName, arguments: email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.arrow_back_ios,
                                size: 14.0,
                                color: greyColor,
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                            ),
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.only(right: 42.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.brightness_1,
                                      size: 8,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      size: 8,
                                      color: primaryColor.withOpacity(0.25),
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      size: 8,
                                      color: primaryColor.withOpacity(0.25),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Step 1 of 3',
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Izinkan kamera, lokasi, dan notifikasi',
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Image.asset(
                      'assets/images/il_permission.png',
                      width: 240.87,
                      height: 240,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ic_camera.png',
                          width: 16,
                          height: 14,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Kemudahan Penggunaan Aplikasi',
                          style: TextStyle(
                            fontFamily: 'Kayak',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ic_notification.png',
                          width: 16,
                          height: 16,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Pemberitahuan Informasi Terbaru',
                          style: TextStyle(
                            fontFamily: 'Kayak',
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/ic_location.png',
                          width: 14,
                          height: 16.9,
                          color: primaryColor,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Mencari Pekerja dan Pekerjaan di Sekitarmu',
                          style: TextStyle(
                            fontFamily: 'Kayak',
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                  ],
                ),
              ),
              Container(
                width: 148,
                height: 40,
                margin: const EdgeInsets.only(bottom: 16),
                child: FlatButton(
                  color: primaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () {
                    askPermission(context);
                  },
                  child: Text(
                    'Izinkan',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
