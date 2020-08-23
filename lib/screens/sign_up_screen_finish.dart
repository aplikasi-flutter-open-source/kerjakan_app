import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/main.dart';
import 'package:kerjakanapp/screens/home_screen_job_seeker.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';

import 'drawer_screen.dart';

class SignUpScreenFinish extends StatelessWidget {
  static const String routeName = '/sign-up-screen-finish';
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
                        const SizedBox(
                          height: 48,
                        ),
                        Text(
                          'Congratulation!',
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'You’re ready to go!',
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
                      'assets/images/il_finish_sign_up.png',
                      width: 240,
                      height: 240,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 32),
                      child: Text(
                        'Terima kasih telah meluangkan waktu untuk membuat Akun anda bersama kami. Selamat datang, dan siap kerjakan!',
                        style: TextStyle(
                            fontFamily: 'Kayak', fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(
                      height: 48,
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
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(MainScreen.routeName,
                          (Route<dynamic> route) => false),
                  child: Text(
                    'Lanjutkan',
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
