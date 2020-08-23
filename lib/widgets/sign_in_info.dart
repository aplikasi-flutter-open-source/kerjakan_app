import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/screens/home_screen_job_seeker.dart';
import 'package:kerjakanapp/screens/sign_up_screen_1.dart';

class SignInInfo extends StatelessWidget {
  final int indexPage;
  final String titleInfo;
  final String descInfo;
  SignInInfo(this.indexPage, this.titleInfo, this.descInfo);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Icon(
                Icons.brightness_1,
                size: 8,
                color: indexPage == 0 ? Colors.transparent : Colors.transparent,
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                Icons.brightness_1,
                size: 8,
                color: indexPage == 1 ? Colors.transparent : Colors.transparent,
              ),
              const SizedBox(
                width: 4,
              ),
              Icon(
                Icons.brightness_1,
                size: 8,
                color: indexPage == 2 ? Colors.transparent : Colors.transparent,
              ),
            ],
          ),
          const SizedBox(
            height: 24,
          ),
          Text(
            titleInfo,
            style: TextStyle(
              fontFamily: 'Kayak',
              fontWeight: FontWeight.bold,
              fontSize: 36,
              color: blackTextColor,
            ),
          ),
          const SizedBox(
            height: 24,
          ),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: indexPage == 0
                                ? Color(0xFF4C6DE3)
                                : indexPage == 1
                                    ? Color(0xFF2152DB)
                                    : Color(0xFF314FBA),
                            borderRadius: BorderRadius.circular(16)),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(
                              descInfo,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontFamily: 'Kayak'),
                            ),
                          ),
                          indexPage == 0
                              ? Image.asset(
                                  'assets/images/il_sign_in_1.png',
                                  width: 203.47,
                                  height: 231.89,
                                )
                              : indexPage == 1
                                  ? Image.asset(
                                      'assets/images/il_sign_in_2.png',
                                      width: 176.88,
                                      height: 226.05,
                                    )
                                  : Image.asset(
                                      'assets/images/il_sign_in_3.png',
                                      width: 196.08,
                                      height: 212.47,
                                    ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 64,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
