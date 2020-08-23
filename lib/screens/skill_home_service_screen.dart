import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SkillHomeServiceScreen extends StatefulWidget {
  static const String routeName = 'skill-home-service-screen';
  @override
  _SkillHomeServiceScreenState createState() => _SkillHomeServiceScreenState();
}

class _SkillHomeServiceScreenState extends State<SkillHomeServiceScreen> {
  List<dynamic> _homeServiceSkills = [];

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _homeServiceSkills =
          Provider.of<UserSkills>(context, listen: false).homeServiceSkills;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<UserSkills>(context, listen: false)
            .addHomeServiceSkills(_homeServiceSkills);
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
                                  .addHomeServiceSkills(_homeServiceSkills);
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
                        'Home and Food Services',
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
                        _homeServiceSkills.contains('Laundry / Cuci Pakaian')
                            ? _homeServiceSkills.removeWhere((element) =>
                                element == 'Laundry / Cuci Pakaian')
                            : _homeServiceSkills.add('Laundry / Cuci Pakaian');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills
                                  .contains('Laundry / Cuci Pakaian')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills
                                .contains('Laundry / Cuci Pakaian')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Laundry / Cuci Pakaian',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Laundry / Cuci Pakaian')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Laundry / Cuci Pakaian'))
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
                        _homeServiceSkills.contains('Membersihkan Rumah')
                            ? _homeServiceSkills.removeWhere(
                                (element) => element == 'Membersihkan Rumah')
                            : _homeServiceSkills.add('Membersihkan Rumah');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _homeServiceSkills.contains('Membersihkan Rumah')
                                  ? Color(0xFF4C6DE3)
                                  : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills.contains('Membersihkan Rumah')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Membersihkan Rumah',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Membersihkan Rumah')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills.contains('Membersihkan Rumah'))
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
                        _homeServiceSkills.contains('Membersihkan Furnitur')
                            ? _homeServiceSkills.removeWhere(
                                (element) => element == 'Membersihkan Furnitur')
                            : _homeServiceSkills.add('Membersihkan Furnitur');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills
                                  .contains('Membersihkan Furnitur')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color:
                            _homeServiceSkills.contains('Membersihkan Furnitur')
                                ? Color(0xFF4C6DE3)
                                : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Membersihkan Furnitur',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Membersihkan Furnitur')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Membersihkan Furnitur'))
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
                        _homeServiceSkills.contains('Babysit / Menjaga Bayi')
                            ? _homeServiceSkills.removeWhere((element) =>
                                element == 'Babysit / Menjaga Bayi')
                            : _homeServiceSkills.add('Babysit / Menjaga Bayi');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills
                                  .contains('Babysit / Menjaga Bayi')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills
                                .contains('Babysit / Menjaga Bayi')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Babysit / Menjaga Bayi',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Babysit / Menjaga Bayi')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Babysit / Menjaga Bayi'))
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
                        _homeServiceSkills.contains('Berkebun / Florist')
                            ? _homeServiceSkills.removeWhere(
                                (element) => element == 'Berkebun / Florist')
                            : _homeServiceSkills.add('Berkebun / Florist');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _homeServiceSkills.contains('Berkebun / Florist')
                                  ? Color(0xFF4C6DE3)
                                  : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills.contains('Berkebun / Florist')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Berkebun / Florist',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Berkebun / Florist')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills.contains('Berkebun / Florist'))
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
                        _homeServiceSkills.contains('Katering')
                            ? _homeServiceSkills
                                .removeWhere((element) => element == 'Katering')
                            : _homeServiceSkills.add('Katering');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills.contains('Katering')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills.contains('Katering')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Katering',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills.contains('Katering')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills.contains('Katering'))
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
                        _homeServiceSkills
                                .contains('Pemasangan Perbaikan Elektronik')
                            ? _homeServiceSkills.removeWhere((element) =>
                                element == 'Pemasangan Perbaikan Elektronik')
                            : _homeServiceSkills
                                .add('Pemasangan Perbaikan Elektronik');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills
                                  .contains('Pemasangan Perbaikan Elektronik')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills
                                .contains('Pemasangan Perbaikan Elektronik')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemasangan Perbaikan Elektronik',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills.contains(
                                      'Pemasangan Perbaikan Elektronik')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Pemasangan Perbaikan Elektronik'))
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
                        _homeServiceSkills.contains(
                                'Pemasangan Perbaikan Pipa dan Ledeng')
                            ? _homeServiceSkills.removeWhere((element) =>
                                element ==
                                'Pemasangan Perbaikan Pipa dan Ledeng')
                            : _homeServiceSkills
                                .add('Pemasangan Perbaikan Pipa dan Ledeng');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills.contains(
                                  'Pemasangan Perbaikan Pipa dan Ledeng')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills.contains(
                                'Pemasangan Perbaikan Pipa dan Ledeng')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemasangan Perbaikan Pipa dan Ledeng',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills.contains(
                                      'Pemasangan Perbaikan Pipa dan Ledeng')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Pemasangan Perbaikan Pipa dan Ledeng'))
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
                        _homeServiceSkills
                                .contains('Pemasangan Perbaikan Furnitur')
                            ? _homeServiceSkills.removeWhere((element) =>
                                element == 'Pemasangan Perbaikan Furnitur')
                            : _homeServiceSkills
                                .add('Pemasangan Perbaikan Furnitur');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills
                                  .contains('Pemasangan Perbaikan Furnitur')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills
                                .contains('Pemasangan Perbaikan Furnitur')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pemasangan Perbaikan Furnitur',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Pemasangan Perbaikan Furnitur')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Pemasangan Perbaikan Furnitur'))
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
                        _homeServiceSkills.contains('Jasa Interior Rumah')
                            ? _homeServiceSkills.removeWhere(
                                (element) => element == 'Jasa Interior Rumah')
                            : _homeServiceSkills.add('Jasa Interior Rumah');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color:
                              _homeServiceSkills.contains('Jasa Interior Rumah')
                                  ? Color(0xFF4C6DE3)
                                  : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color:
                            _homeServiceSkills.contains('Jasa Interior Rumah')
                                ? Color(0xFF4C6DE3)
                                : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jasa Interior Rumah',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Jasa Interior Rumah')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Jasa Interior Rumah'))
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
                        _homeServiceSkills.contains('Jasa Eksterior Rumah')
                            ? _homeServiceSkills.removeWhere(
                                (element) => element == 'Jasa Eksterior Rumah')
                            : _homeServiceSkills.add('Jasa Eksterior Rumah');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills
                                  .contains('Jasa Eksterior Rumah')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color:
                            _homeServiceSkills.contains('Jasa Eksterior Rumah')
                                ? Color(0xFF4C6DE3)
                                : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Jasa Eksterior Rumah',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills
                                      .contains('Jasa Eksterior Rumah')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills
                              .contains('Jasa Eksterior Rumah'))
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
                        _homeServiceSkills.contains('Kendali Hama')
                            ? _homeServiceSkills.removeWhere(
                                (element) => element == 'Kendali Hama')
                            : _homeServiceSkills.add('Kendali Hama');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills.contains('Kendali Hama')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills.contains('Kendali Hama')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kendali Hama',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills.contains('Kendali Hama')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills.contains('Kendali Hama'))
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
                        _homeServiceSkills.contains('Penjahit')
                            ? _homeServiceSkills
                                .removeWhere((element) => element == 'Penjahit')
                            : _homeServiceSkills.add('Penjahit');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _homeServiceSkills.contains('Penjahit')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _homeServiceSkills.contains('Penjahit')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Penjahit',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _homeServiceSkills.contains('Penjahit')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_homeServiceSkills.contains('Penjahit'))
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
                            .addHomeServiceSkills(_homeServiceSkills);
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
