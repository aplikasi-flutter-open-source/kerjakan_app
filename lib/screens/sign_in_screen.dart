import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/screens/drawer_screen.dart';
import 'package:kerjakanapp/screens/home_screen_job_seeker.dart';
import 'package:kerjakanapp/screens/sign_up_screen_1.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kerjakanapp/widgets/sign_in_info.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  var _isLoading = false;
  int _index = 0;

  Future<void> _signIn() async {
    try {
      await _googleSignIn.signIn();

      setState(() {
        _isLoading = true;
      });

      print(_googleSignIn.currentUser.email);

      await Provider.of<Auth>(context, listen: false)
          .signIn(_googleSignIn.currentUser.email, context);

      setState(() {
        _isLoading = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      print(error);
    }
  }

  Future<void> _signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (error) {
      print(error);
    }
  }

  final _controller = PageController(
    initialPage: 0,
  );

  final _pageView = [
    SignInInfo(0, 'Apapun\nBisa\nDikerjan',
        'Tata boga, tata graha, atau tata rambut? Pekerjaan apapun bisa di kerjakan!'),
    SignInInfo(1, 'Cari,\nHubungi,\nSelesai.',
        'Anda ingin layanan atau jasa tertentu? tinggal cari, hubungi, dan santai saja.'),
    SignInInfo(2, 'Beragam\nKeahlian\nPekerjaan',
        'Apapun yang Anda kerjakan, temukan peluang, dan pelanggan Anda selanjutnya disini.'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            PageView(
              onPageChanged: (value) {
                setState(() {
                  _index = value;
                });
              },
              controller: _controller,
              children: _pageView,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0, top: 16),
              child: Column(
                children: [
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.brightness_1,
                        size: 8,
                        color: _index == 0
                            ? primaryColor
                            : primaryColor.withOpacity(0.25),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.brightness_1,
                        size: 8,
                        color: _index == 1
                            ? primaryColor
                            : primaryColor.withOpacity(0.25),
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Icon(
                        Icons.brightness_1,
                        size: 8,
                        color: _index == 2
                            ? primaryColor
                            : primaryColor.withOpacity(0.25),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 36,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 24, right: 24, bottom: 24, top: 24),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 36),
                  height: 48,
                  width: double.infinity,
                  child: InkWell(
                    onTap: () {
                      _signIn();
                      _signOut();
                    },
                    child: Card(
                      shadowColor: greyColor.withOpacity(0.15),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      color: Colors.white,
                      child: _isLoading
                          ? Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(
                                  valueColor: new AlwaysStoppedAnimation<Color>(
                                      primaryColor),
                                ),
                              ),
                            )
                          : Center(
                              child: Image.asset(
                                'assets/images/ic_sign_google.png',
                                width: 154,
                                height: 15,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
