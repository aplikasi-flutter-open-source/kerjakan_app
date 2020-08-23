import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:kerjakanapp/screens/skill2_screen.dart';
import 'package:kerjakanapp/screens/skill_delivery_automotive_screen.dart';
import 'package:kerjakanapp/screens/skill_home_service_screen.dart';
import 'package:kerjakanapp/screens/skill_leisure_services_screen.dart';
import 'package:kerjakanapp/screens/skill_miscellaneous_screen.dart';
import 'package:kerjakanapp/screens/skill_personal_care_screen.dart';
import 'package:kerjakanapp/widgets/skills_list.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SkillScreen extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static const String routeName = '/skill-screen';

  Widget build(BuildContext context) {
    final _signUpData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;

    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
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
                            padding: const EdgeInsets.only(right: 32.0),
                            child: Text(
                              "Keahlian Anda",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Kayak',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Lengkapi Keahlian Anda',
                      style: TextStyle(
                        fontFamily: 'Kayak',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
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
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Tambahkan Keahlian',
                    style: TextStyle(
                      fontFamily: 'Kayak',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SkillDeliveryAutomotiveScreen.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4C6DE3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        'Delivery and Automotive',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      trailing: RotatedBox(
                        quarterTurns: 90,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SkillHomeServiceScreen.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4C6DE3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        'Home and Food Services',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      trailing: RotatedBox(
                        quarterTurns: 90,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SkillPersonalCareScreen.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4C6DE3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        'Personal & Health Care',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      trailing: RotatedBox(
                        quarterTurns: 90,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SkillLeisureServicesScreen.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4C6DE3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        'Leisure Services',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      trailing: RotatedBox(
                        quarterTurns: 90,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                InkWell(
                  onTap: () => Navigator.of(context)
                      .pushNamed(SkillMiscellaneousScreen.routeName),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF4C6DE3),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text(
                        'Miscellaneous',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      trailing: RotatedBox(
                        quarterTurns: 90,
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.white,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Keahlian Ditambahkan',
                    style: TextStyle(
                      fontFamily: 'Kayak',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                SkillsList(),
                const SizedBox(
                  height: 32,
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
                      final List<dynamic> _allSkills = [];
                      final List<dynamic> _deliveryAndAutomotiveSkills =
                          Provider.of<UserSkills>(context, listen: false)
                              .deliveryAndAutomotiveSkills;
                      final List<dynamic> _homeServiceSkills =
                          Provider.of<UserSkills>(context, listen: false)
                              .homeServiceSkills;
                      final List<dynamic> _personalHealthCareSkills =
                          Provider.of<UserSkills>(context, listen: false)
                              .personalHealthCareSkills;
                      final List<dynamic> _leisureServiceSkills =
                          Provider.of<UserSkills>(context, listen: false)
                              .leisureServiceSkills;
                      final List<dynamic> _miscellaneousSkills =
                          Provider.of<UserSkills>(context, listen: false)
                              .miscellaneousSkills;

                      _deliveryAndAutomotiveSkills.forEach((element) {
                        _allSkills.add(element);
                      });
                      _homeServiceSkills.forEach((element) {
                        _allSkills.add(element);
                      });
                      _personalHealthCareSkills.forEach((element) {
                        _allSkills.add(element);
                      });
                      _leisureServiceSkills.forEach((element) {
                        _allSkills.add(element);
                      });
                      _miscellaneousSkills.forEach((element) {
                        _allSkills.add(element);
                      });

                      if (_allSkills.length != 0) {
                        _signUpData['delivery_skills'] = [];
                        _deliveryAndAutomotiveSkills.forEach((element) {
                          (_signUpData['delivery_skills']).add('\"$element\"');
                        });

                        _signUpData['home_service_skills'] = [];
                        _homeServiceSkills.forEach((element) {
                          (_signUpData['home_service_skills'])
                              .add('\"$element\"');
                        });

                        _signUpData['personal_health_skills'] = [];
                        _personalHealthCareSkills.forEach((element) {
                          (_signUpData['personal_health_skills'])
                              .add('\"$element\"');
                        });

                        _signUpData['leisure_skills'] = [];
                        _leisureServiceSkills.forEach((element) {
                          (_signUpData['leisure_skills']).add('\"$element\"');
                        });

                        _signUpData['misc_skills'] = [];
                        _miscellaneousSkills.forEach((element) {
                          (_signUpData['misc_skills']).add('\"$element\"');
                        });

                        Navigator.of(context).pushNamed(Skill2Screen.routeName,
                            arguments: _signUpData);
                      } else {
                        _scaffoldKey.currentState.showSnackBar(SnackBar(
                            content:
                                Text('Silahkan memilih minimal satu skill')));
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
