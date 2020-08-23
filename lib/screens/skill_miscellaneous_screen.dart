import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SkillMiscellaneousScreen extends StatefulWidget {
  static const String routeName = 'skill-miscellaneous-screen';
  @override
  _SkillMiscellaneousScreenState createState() =>
      _SkillMiscellaneousScreenState();
}

class _SkillMiscellaneousScreenState extends State<SkillMiscellaneousScreen> {
  List<dynamic> _miscellaneousSkills = [];

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _miscellaneousSkills =
          Provider.of<UserSkills>(context, listen: false).miscellaneousSkills;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<UserSkills>(context, listen: false)
            .addMiscellaneousSkills(_miscellaneousSkills);
        Navigator.of(context).pop();
      },
      child: Scaffold(
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
                            onPressed: () {
                              Provider.of<UserSkills>(context, listen: false)
                                  .addMiscellaneousSkills(_miscellaneousSkills);
                              Navigator.of(context).pop();
                            },
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
                        'Miscellaneous',
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
                    'Pilih keahlian yang ingin Anda kerjakan',
                    style: descStyle,
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _miscellaneousSkills.contains('Guru Les')
                            ? _miscellaneousSkills
                                .removeWhere((element) => element == 'Guru Les')
                            : _miscellaneousSkills.add('Guru Les');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _miscellaneousSkills.contains('Guru Les')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _miscellaneousSkills.contains('Guru Les')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Guru Les',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _miscellaneousSkills.contains('Guru Les')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_miscellaneousSkills.contains('Guru Les'))
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _miscellaneousSkills.contains('Guru Privat')
                            ? _miscellaneousSkills.removeWhere(
                                (element) => element == 'Guru Privat')
                            : _miscellaneousSkills.add('Guru Privat');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _miscellaneousSkills.contains('Guru Privat')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _miscellaneousSkills.contains('Guru Privat')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Guru Privat',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color:
                                  _miscellaneousSkills.contains('Guru Privat')
                                      ? Colors.white
                                      : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_miscellaneousSkills.contains('Guru Privat'))
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _miscellaneousSkills.contains('Guru Mengemudi')
                            ? _miscellaneousSkills.removeWhere(
                                (element) => element == 'Guru Mengemudi')
                            : _miscellaneousSkills.add('Guru Mengemudi');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _miscellaneousSkills.contains('Guru Mengemudi')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _miscellaneousSkills.contains('Guru Mengemudi')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Guru Mengemudi',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _miscellaneousSkills
                                      .contains('Guru Mengemudi')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_miscellaneousSkills.contains('Guru Mengemudi'))
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _miscellaneousSkills.contains('Guru Seni Musik')
                            ? _miscellaneousSkills.removeWhere(
                                (element) => element == 'Guru Seni Musik')
                            : _miscellaneousSkills.add('Guru Seni Musik');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _miscellaneousSkills.contains('Guru Seni Musik')
                                  ? Color(0xFF4C6DE3)
                                  : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _miscellaneousSkills.contains('Guru Seni Musik')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Guru Seni Musik',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _miscellaneousSkills
                                      .contains('Guru Seni Musik')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_miscellaneousSkills.contains('Guru Seni Musik'))
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _miscellaneousSkills.contains('Guru Seni Lukis')
                            ? _miscellaneousSkills.removeWhere(
                                (element) => element == 'Guru Seni Lukis')
                            : _miscellaneousSkills.add('Guru Seni Lukis');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _miscellaneousSkills.contains('Guru Seni Lukis')
                                  ? Color(0xFF4C6DE3)
                                  : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _miscellaneousSkills.contains('Guru Seni Lukis')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Guru Seni Lukis',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _miscellaneousSkills
                                      .contains('Guru Seni Lukis')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_miscellaneousSkills.contains('Guru Seni Lukis'))
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _miscellaneousSkills.contains('Guru Bahasa')
                            ? _miscellaneousSkills.removeWhere(
                                (element) => element == 'Guru Bahasa')
                            : _miscellaneousSkills.add('Guru Bahasa');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _miscellaneousSkills.contains('Guru Bahasa')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _miscellaneousSkills.contains('Guru Bahasa')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Guru Bahasa',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color:
                                  _miscellaneousSkills.contains('Guru Bahasa')
                                      ? Colors.white
                                      : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_miscellaneousSkills.contains('Guru Bahasa'))
                            Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 14,
                            )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Container(
                    width: 148,
                    height: 40,
                    margin: const EdgeInsets.only(bottom: 16),
                    child: OutlineButton(
                      borderSide: BorderSide(color: primaryColor),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16)),
                      onPressed: () {
                        Provider.of<UserSkills>(context, listen: false)
                            .addMiscellaneousSkills(_miscellaneousSkills);
                        Navigator.of(context).pop();
                      },
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
        ),
      ),
    );
  }
}
