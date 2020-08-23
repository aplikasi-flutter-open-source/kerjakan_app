import 'package:flutter/material.dart';
import 'package:kerjakanapp/main.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/screens/drawer_screen.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';
import 'package:kerjakanapp/screens/sign_up_screen_finish.dart';
import 'package:kerjakanapp/screens/skill_screen.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SignUpScreen3 extends StatefulWidget {
  static const String routeName = '/sign-up-screen-3';

  @override
  _SignUpScreen3State createState() => _SignUpScreen3State();
}

class _SignUpScreen3State extends State<SignUpScreen3> {
  var _userStatus;
  var _isLoading = false;
  var _signUpData;

  Future<void> _requestSignUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .signUpCariJasa(_signUpData);

      Navigator.of(context).pushNamedAndRemoveUntil(
          SignUpScreenFinish.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      throw error;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _signUpData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
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
                              color: primaryColor,
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Icon(
                              Icons.brightness_1,
                              size: 8,
                              color: primaryColor,
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
                  'Step 3 of 3',
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
                  'Apakah Tujuan Anda?',
                  style: TextStyle(
                    fontFamily: 'Kayak',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  'Anda dapat memperbarui ini melalui Pengaturan',
                  style: TextStyle(
                    fontFamily: 'Kayak',
                    fontSize: 12,
                    color: Color(0xFFA0A0A0),
                  ),
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        _signUpData['mode'] = 'Mencari Pekerjaan';
                        setState(() {
                          _userStatus = 'mencari_pekerjaan';
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          width: 148,
                          height: 232,
                          decoration: BoxDecoration(
                            color: _userStatus == 'mencari_pekerjaan'
                                ? Color(0xFF4C6DE3)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Cari Kerja',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.w600,
                                      fontSize: 16,
                                      color: _userStatus == 'mencari_pekerjaan'
                                          ? Colors.white
                                          : Color(0xFFA0A0A0),
                                    ),
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/il_cari_kerja.png',
                                width: 158.36,
                                height: 249,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        _signUpData['mode'] = 'Mencari Pekerja';
                        setState(() {
                          _userStatus = 'mencari_pekerja';
                        });
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Container(
                          height: 232,
                          width: 148,
                          decoration: BoxDecoration(
                            color: _userStatus == 'mencari_pekerja'
                                ? Color(0xFF4C6DE3)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'Cari Jasa',
                                    style: TextStyle(
                                        fontFamily: 'Kayak',
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                        color: _userStatus == 'mencari_pekerja'
                                            ? Colors.white
                                            : Color(0xFFA0A0A0)),
                                  ),
                                ),
                              ),
                              Image.asset(
                                'assets/images/il_cari_jasa.png',
                                width: 158.36,
                                height: 248.52,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'Kami akan menampilkan layanan dan jasa yang tersedia disekitar Anda,',
                    style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.bold,
                        color: primaryColor),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                const SizedBox(
                  height: 48,
                ),
                Container(
                  width: 148,
                  height: 40,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: _isLoading
                      ? Center(
                          child: CircularProgressIndicator(),
                        )
                      : FlatButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          onPressed: () {
                            if (_userStatus == 'mencari_pekerjaan') {
                              Navigator.of(context).pushNamed(
                                  SkillScreen.routeName,
                                  arguments: _signUpData);
                            } else {
                              _requestSignUp();
                            }
                          },
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
      ),
    );
  }
}
