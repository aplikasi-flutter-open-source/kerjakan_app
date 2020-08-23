import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class SkillDeliveryAutomotiveScreen extends StatefulWidget {
  static const String routeName = 'skill-delivery-automotive-screen';
  @override
  _SkillDeliveryAutomotiveScreenState createState() =>
      _SkillDeliveryAutomotiveScreenState();
}

class _SkillDeliveryAutomotiveScreenState
    extends State<SkillDeliveryAutomotiveScreen> {
  List<dynamic> _deliveryAutomotiveSkills = [];

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _deliveryAutomotiveSkills =
          Provider.of<UserSkills>(context, listen: false)
              .deliveryAndAutomotiveSkills;
    }

    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Provider.of<UserSkills>(context, listen: false)
            .addDeliveryAndAutomotiveSkills(_deliveryAutomotiveSkills);
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
                                  .addDeliveryAndAutomotiveSkills(
                                      _deliveryAutomotiveSkills);
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
                        'Delivery and Automotive',
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
                        _deliveryAutomotiveSkills.contains('Titip Berbelanja')
                            ? _deliveryAutomotiveSkills.removeWhere(
                                (element) => element == 'Titip Berbelanja')
                            : _deliveryAutomotiveSkills.add('Titip Berbelanja');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _deliveryAutomotiveSkills
                                  .contains('Titip Berbelanja')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _deliveryAutomotiveSkills
                                .contains('Titip Berbelanja')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Titip Berbelanja',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _deliveryAutomotiveSkills
                                      .contains('Titip Berbelanja')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_deliveryAutomotiveSkills
                              .contains('Titip Berbelanja'))
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
                        _deliveryAutomotiveSkills.contains('Kurir')
                            ? _deliveryAutomotiveSkills
                                .removeWhere((element) => element == 'Kurir')
                            : _deliveryAutomotiveSkills.add('Kurir');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _deliveryAutomotiveSkills.contains('Kurir')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _deliveryAutomotiveSkills.contains('Kurir')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Kurir',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _deliveryAutomotiveSkills.contains('Kurir')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_deliveryAutomotiveSkills.contains('Kurir'))
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
                        _deliveryAutomotiveSkills
                                .contains('Logistik / Pindah Rumah')
                            ? _deliveryAutomotiveSkills.removeWhere((element) =>
                                element == 'Logistik / Pindah Rumah')
                            : _deliveryAutomotiveSkills
                                .add('Logistik / Pindah Rumah');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _deliveryAutomotiveSkills
                                  .contains('Logistik / Pindah Rumah')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _deliveryAutomotiveSkills
                                .contains('Logistik / Pindah Rumah')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Logistik / Pindah Rumah',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _deliveryAutomotiveSkills
                                      .contains('Logistik / Pindah Rumah')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_deliveryAutomotiveSkills
                              .contains('Logistik / Pindah Rumah'))
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
                        _deliveryAutomotiveSkills.contains('Supir Pribadi')
                            ? _deliveryAutomotiveSkills.removeWhere(
                                (element) => element == 'Supir Pribadi')
                            : _deliveryAutomotiveSkills.add('Supir Pribadi');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _deliveryAutomotiveSkills
                                  .contains('Supir Pribadi')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color:
                            _deliveryAutomotiveSkills.contains('Supir Pribadi')
                                ? Color(0xFF4C6DE3)
                                : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Supir Pribadi',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _deliveryAutomotiveSkills
                                      .contains('Supir Pribadi')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_deliveryAutomotiveSkills
                              .contains('Supir Pribadi'))
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
                        _deliveryAutomotiveSkills
                                .contains('Perawatan Kendaraan')
                            ? _deliveryAutomotiveSkills.removeWhere(
                                (element) => element == 'Perawatan Kendaraan')
                            : _deliveryAutomotiveSkills
                                .add('Perawatan Kendaraan');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _deliveryAutomotiveSkills
                                  .contains('Perawatan Kendaraan')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _deliveryAutomotiveSkills
                                .contains('Perawatan Kendaraan')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Perawatan Kendaraan',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _deliveryAutomotiveSkills
                                      .contains('Perawatan Kendaraan')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_deliveryAutomotiveSkills
                              .contains('Perawatan Kendaraan'))
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
                        _deliveryAutomotiveSkills
                                .contains('Perbaikan Kendaraan')
                            ? _deliveryAutomotiveSkills.removeWhere(
                                (element) => element == 'Perbaikan Kendaraan')
                            : _deliveryAutomotiveSkills
                                .add('Perbaikan Kendaraan');
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: _deliveryAutomotiveSkills
                                  .contains('Perbaikan Kendaraan')
                              ? Color(0xFF4C6DE3)
                              : Colors.grey.withOpacity(0.5),
                          width: 1,
                        ),
                        color: _deliveryAutomotiveSkills
                                .contains('Perbaikan Kendaraan')
                            ? Color(0xFF4C6DE3)
                            : null,
                      ),
                      height: 40,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Perbaikan Kendaraan',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: _deliveryAutomotiveSkills
                                      .contains('Perbaikan Kendaraan')
                                  ? Colors.white
                                  : Color(0xFF4C6DE3),
                              fontSize: 12,
                            ),
                          ),
                          if (_deliveryAutomotiveSkills
                              .contains('Perbaikan Kendaraan'))
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
                            .addDeliveryAndAutomotiveSkills(
                                _deliveryAutomotiveSkills);
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
