import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SkillLeisureServicesScreen extends StatefulWidget {
  static const String routeName = 'skill-leisure-services-screen';
  @override
  _SkillLeisureServicesScreenState createState() =>
      _SkillLeisureServicesScreenState();
}

class _SkillLeisureServicesScreenState
    extends State<SkillLeisureServicesScreen> {
  List<dynamic> _leisureServiceSkills = [];

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _leisureServiceSkills =
          Provider.of<UserSkills>(context, listen: false).leisureServiceSkills;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<UserSkills>(context, listen: false)
            .addLeisureServiceSkills(_leisureServiceSkills);
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
                                  .addLeisureServiceSkills(
                                      _leisureServiceSkills);
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
                        'Leisure Services',
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
                        _leisureServiceSkills.contains('Perawatan Peliharaan')
                            ? _leisureServiceSkills.removeWhere(
                                (element) => element == 'Perawatan Peliharaan')
                            : _leisureServiceSkills.add('Perawatan Peliharaan');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _leisureServiceSkills
                                  .contains('Perawatan Peliharaan')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _leisureServiceSkills
                                .contains('Perawatan Peliharaan')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Perawatan Peliharaan',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _leisureServiceSkills
                                      .contains('Perawatan Peliharaan')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_leisureServiceSkills
                              .contains('Perawatan Peliharaan'))
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
                        _leisureServiceSkills.contains('Pemain Seni / Hiburan')
                            ? _leisureServiceSkills.removeWhere(
                                (element) => element == 'Pemain Seni / Hiburan')
                            : _leisureServiceSkills
                                .add('Pemain Seni / Hiburan');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _leisureServiceSkills
                                  .contains('Pemain Seni / Hiburan')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _leisureServiceSkills
                                .contains('Pemain Seni / Hiburan')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemain Seni / Hiburan',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _leisureServiceSkills
                                      .contains('Pemain Seni / Hiburan')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_leisureServiceSkills
                              .contains('Pemain Seni / Hiburan'))
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
                        _leisureServiceSkills.contains('Tata Rias / Makeup')
                            ? _leisureServiceSkills.removeWhere(
                                (element) => element == 'Tata Rias / Makeup')
                            : _leisureServiceSkills.add('Tata Rias / Makeup');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _leisureServiceSkills
                                  .contains('Tata Rias / Makeup')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color:
                            _leisureServiceSkills.contains('Tata Rias / Makeup')
                                ? Color(0xFF4C6DE3)
                                : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tata Rias / Makeup',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _leisureServiceSkills
                                      .contains('Tata Rias / Makeup')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_leisureServiceSkills
                              .contains('Tata Rias / Makeup'))
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
                        _leisureServiceSkills
                                .contains('Perawatan Kuku / Manicure')
                            ? _leisureServiceSkills.removeWhere((element) =>
                                element == 'Perawatan Kuku / Manicure')
                            : _leisureServiceSkills
                                .add('Perawatan Kuku / Manicure');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _leisureServiceSkills
                                  .contains('Perawatan Kuku / Manicure')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _leisureServiceSkills
                                .contains('Perawatan Kuku / Manicure')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Perawatan Kuku / Manicure',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _leisureServiceSkills
                                      .contains('Perawatan Kuku / Manicure')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_leisureServiceSkills
                              .contains('Perawatan Kuku / Manicure'))
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
                        _leisureServiceSkills.contains('Spa')
                            ? _leisureServiceSkills
                                .removeWhere((element) => element == 'Spa')
                            : _leisureServiceSkills.add('Spa');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _leisureServiceSkills.contains('Spa')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _leisureServiceSkills.contains('Spa')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Spa',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _leisureServiceSkills.contains('Spa')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_leisureServiceSkills.contains('Spa'))
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
                        _leisureServiceSkills.contains('Spa Bayi')
                            ? _leisureServiceSkills
                                .removeWhere((element) => element == 'Spa Bayi')
                            : _leisureServiceSkills.add('Spa Bayi');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _leisureServiceSkills.contains('Spa Bayi')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _leisureServiceSkills.contains('Spa Bayi')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Spa Bayi',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _leisureServiceSkills.contains('Spa Bayi')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_leisureServiceSkills.contains('Spa Bayi'))
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
                            .addLeisureServiceSkills(_leisureServiceSkills);
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
