import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/main.dart';
import 'package:kerjakanapp/screens/home_screen_job_seeker.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';

import 'drawer_screen.dart';

class FinishAddJobScreen extends StatelessWidget {
  static const String routeName = '/finish-add-job-screen';
  @override
  Widget build(BuildContext context) {
    final _vacancyData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
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
                          'Lowongan Dibuat',
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              color: primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Dibuat dan Dibagikan!',
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
                    Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      elevation: 5,
                      shadowColor: greyColor.withOpacity(0.15),
                      child: Container(
                        width: 248,
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 36),
                        child: Column(
                          children: [
                            Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 8),
                                  child: _vacancyData['category'] == 'Home'
                                      ? Image.asset(
                                          'assets/images/placeholder_home.png',
                                          height: 94,
                                          width: 94,
                                        )
                                      : _vacancyData['category'] == 'Self Care'
                                          ? Image.asset(
                                              'assets/images/placeholder_self_care.png',
                                              height: 94,
                                              width: 94,
                                            )
                                          : _vacancyData['category'] == 'Auto'
                                              ? Image.asset(
                                                  'assets/images/placeholder_auto.png',
                                                  height: 94,
                                                  width: 94,
                                                )
                                              : _vacancyData['category'] ==
                                                      'Other'
                                                  ? Image.asset(
                                                      'assets/images/placeholder_other.png',
                                                      height: 94,
                                                      width: 94,
                                                    )
                                                  : _vacancyData['category'] ==
                                                          'Leisure'
                                                      ? Image.asset(
                                                          'assets/images/placeholder_leisure.png',
                                                          height: 94,
                                                          width: 94,
                                                        )
                                                      : null,
                                ),
                                Stack(
                                  children: [
                                    Image.asset(
                                      'assets/images/ic_banner.png',
                                      width: 20,
                                      height: 16,
                                      color: accentColor,
                                    ),
                                    Positioned.fill(
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: _vacancyData['category'] ==
                                                'Home'
                                            ? Image.asset(
                                                'assets/images/ic_house.png',
                                                width: 8,
                                                height: 8,
                                              )
                                            : _vacancyData['category'] == 'Auto'
                                                ? Image.asset(
                                                    'assets/images/ic_auto.png',
                                                    width: 8,
                                                    height: 8,
                                                  )
                                                : _vacancyData['category'] ==
                                                        'Leisure'
                                                    ? Image.asset(
                                                        'assets/images/ic_leisure.png',
                                                        width: 8,
                                                        height: 8,
                                                      )
                                                    : _vacancyData[
                                                                'category'] ==
                                                            'Other'
                                                        ? Image.asset(
                                                            'assets/images/ic_other.png',
                                                            width: 8,
                                                            height: 8,
                                                          )
                                                        : _vacancyData[
                                                                    'category'] ==
                                                                'Self Care'
                                                            ? Image.asset(
                                                                'assets/images/ic_personal.png',
                                                                width: 8,
                                                                height: 12,
                                                              )
                                                            : null,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              _vacancyData['title'],
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              'Rp. ${oCcy.format(int.parse(_vacancyData['salary']))},-/ ${_vacancyData['salary_time']}',
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 10,
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                  ],
                ),
              ),
              Container(
                width: 248,
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
                    'Lihat Lowongan Saya',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              Container(
                width: 248,
                height: 40,
                margin: const EdgeInsets.only(bottom: 16),
                child: OutlineButton(
                  borderSide: BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  onPressed: () => Navigator.of(context)
                      .pushNamedAndRemoveUntil(MainScreen.routeName,
                          (Route<dynamic> route) => false),
                  child: Text(
                    'Kembali',
                    style: TextStyle(color: primaryColor),
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
