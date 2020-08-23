import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SkillPersonalCareScreen extends StatefulWidget {
  static const String routeName = 'skill-personal-care-screen';
  @override
  _SkillPersonalCareScreenState createState() =>
      _SkillPersonalCareScreenState();
}

class _SkillPersonalCareScreenState extends State<SkillPersonalCareScreen> {
  List<dynamic> _personalCareSkills = [];

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _personalCareSkills = Provider.of<UserSkills>(context, listen: false)
          .personalHealthCareSkills;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<UserSkills>(context, listen: false)
            .addPersonalHealthCareSkills(_personalCareSkills);
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
                                  .addPersonalHealthCareSkills(
                                      _personalCareSkills);
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
                        'Personal & Health Care',
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
                        _personalCareSkills.contains('Potong Rambut / Barber')
                            ? _personalCareSkills.removeWhere((element) =>
                                element == 'Potong Rambut / Barber')
                            : _personalCareSkills.add('Potong Rambut / Barber');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _personalCareSkills
                                  .contains('Potong Rambut / Barber')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _personalCareSkills
                                .contains('Potong Rambut / Barber')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Potong Rambut / Barber',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills
                                      .contains('Potong Rambut / Barber')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills
                              .contains('Potong Rambut / Barber'))
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
                        _personalCareSkills
                                .contains('Tata Rambut / Hair Stylist')
                            ? _personalCareSkills.removeWhere((element) =>
                                element == 'Tata Rambut / Hair Stylist')
                            : _personalCareSkills
                                .add('Tata Rambut / Hair Stylist');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _personalCareSkills
                                  .contains('Tata Rambut / Hair Stylistr')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _personalCareSkills
                                .contains('Tata Rambut / Hair Stylist')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tata Rambut / Hair Stylist',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills
                                      .contains('Tata Rambut / Hair Stylist')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills
                              .contains('Tata Rambut / Hair Stylist'))
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
                        _personalCareSkills.contains('Pijat')
                            ? _personalCareSkills
                                .removeWhere((element) => element == 'Pijat')
                            : _personalCareSkills.add('Pijat');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _personalCareSkills.contains('Pijat')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _personalCareSkills.contains('Pijat')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pijat',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills.contains('Pijat')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills.contains('Pijat'))
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
                        _personalCareSkills.contains('Pelatih Pribadi')
                            ? _personalCareSkills.removeWhere(
                                (element) => element == 'Pelatih Pribadi')
                            : _personalCareSkills.add('Pelatih Pribadi');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _personalCareSkills.contains('Pelatih Pribadi')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _personalCareSkills.contains('Pelatih Pribadi')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pelatih Pribadi',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills
                                      .contains('Pelatih Pribadi')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills.contains('Pelatih Pribadi'))
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
                        _personalCareSkills.contains('Instruktur Olahraga')
                            ? _personalCareSkills.removeWhere(
                                (element) => element == 'Instruktur Olahraga')
                            : _personalCareSkills.add('Instruktur Olahraga');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _personalCareSkills
                                  .contains('Instruktur Olahraga')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color:
                            _personalCareSkills.contains('Instruktur Olahraga')
                                ? Color(0xFF4C6DE3)
                                : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Instruktur Olahraga',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills
                                      .contains('Instruktur Olahraga')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills
                              .contains('Instruktur Olahraga'))
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
                        _personalCareSkills.contains('Instruktur Yoga')
                            ? _personalCareSkills.removeWhere(
                                (element) => element == 'Instruktur Yoga')
                            : _personalCareSkills.add('Instruktur Yoga');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _personalCareSkills.contains('Instruktur Yoga')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _personalCareSkills.contains('Instruktur Yoga')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Instruktur Yoga',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills
                                      .contains('Instruktur Yoga')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills.contains('Instruktur Yoga'))
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
                        _personalCareSkills.contains('Tenaga Kesehatan')
                            ? _personalCareSkills.removeWhere(
                                (element) => element == 'Tenaga Kesehatan')
                            : _personalCareSkills.add('Tenaga Kesehatan');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _personalCareSkills.contains('Tenaga Kesehatan')
                                  ? Color(0xFF4C6DE3)
                                  : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _personalCareSkills.contains('Tenaga Kesehatan')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tenaga Kesehatan',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills
                                      .contains('Tenaga Kesehatan')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills.contains('Tenaga Kesehatan'))
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
                        _personalCareSkills.contains('Layanan Keagamaan')
                            ? _personalCareSkills.removeWhere(
                                (element) => element == 'Layanan Keagamaan')
                            : _personalCareSkills.add('Layanan Keagamaan');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _personalCareSkills.contains('Layanan Keagamaan')
                                  ? Color(0xFF4C6DE3)
                                  : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _personalCareSkills.contains('Layanan Keagamaan')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Layanan Keagamaan',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _personalCareSkills
                                      .contains('Layanan Keagamaan')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_personalCareSkills.contains('Layanan Keagamaan'))
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
                            .addPersonalHealthCareSkills(_personalCareSkills);
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
