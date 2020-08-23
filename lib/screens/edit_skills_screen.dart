import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/user_data.dart';
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

class EditSkillScreen extends StatefulWidget {
  static const String routeName = '/edit-skill-screen';

  @override
  _EditSkillScreenState createState() => _EditSkillScreenState();
}

class _EditSkillScreenState extends State<EditSkillScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _isHaveTool = true;

  Map<String, dynamic> _editData = {};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    final List<dynamic> _allSkills = [];
    final List<dynamic> _deliveryAndAutomotiveSkills =
        Provider.of<UserSkills>(context, listen: false)
            .deliveryAndAutomotiveSkills;
    final List<dynamic> _homeServiceSkills =
        Provider.of<UserSkills>(context, listen: false).homeServiceSkills;
    final List<dynamic> _personalHealthCareSkills =
        Provider.of<UserSkills>(context, listen: false)
            .personalHealthCareSkills;
    final List<dynamic> _leisureServiceSkills =
        Provider.of<UserSkills>(context, listen: false).leisureServiceSkills;
    final List<dynamic> _miscellaneousSkills =
        Provider.of<UserSkills>(context, listen: false).miscellaneousSkills;

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
      _editData['delivery_skills'] = [];
      _deliveryAndAutomotiveSkills.forEach((element) {
        (_editData['delivery_skills']).add('\"$element\"');
      });

      _editData['home_service_skills'] = [];
      _homeServiceSkills.forEach((element) {
        (_editData['home_service_skills']).add('\"$element\"');
      });

      _editData['personal_health_skills'] = [];
      _personalHealthCareSkills.forEach((element) {
        (_editData['personal_health_skills']).add('\"$element\"');
      });

      _editData['leisure_skills'] = [];
      _leisureServiceSkills.forEach((element) {
        (_editData['leisure_skills']).add('\"$element\"');
      });

      _editData['misc_skills'] = [];
      _miscellaneousSkills.forEach((element) {
        (_editData['misc_skills']).add('\"$element\"');
      });

      try {
        final id = Provider.of<Auth>(context, listen: false).id;
        await Provider.of<UserData>(context, listen: false)
            .requestEditUserSkills(id, _editData);
        _scaffoldKey.currentState.showSnackBar(
            SnackBar(content: Text('Skill berhasil ditambahkan')));
      } catch (error) {
        throw error;
      }
    } else {
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('Silahkan memilih minimal satu skill')));
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Form(
          key: _formKey,
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
                                "Keahlian",
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
                    ],
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
                        color: primaryLighterColor,
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
                        color: primaryLighterColor,
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
                        color: primaryLighterColor,
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
                        color: primaryLighterColor,
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
                        color: primaryLighterColor,
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
                    height: 16,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 16,
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
                    height: 16,
                  ),
                  Divider(),
                  const SizedBox(
                    height: 16,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Apakah Anda memiliki alat bekerja sesuai keahlian Anda?',
                      style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isHaveTool = true;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(right: 4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: _isHaveTool
                                      ? primaryColor
                                      : Colors.grey.withOpacity(0.5),
                                  width: 1,
                                )),
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Ya',
                                  style: TextStyle(
                                    fontFamily: 'Kayak',
                                    fontWeight: FontWeight.bold,
                                    color: _isHaveTool
                                        ? primaryColor
                                        : Colors.grey.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                if (_isHaveTool)
                                  Icon(
                                    Icons.check,
                                    color: primaryColor,
                                    size: 14,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isHaveTool = false;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(left: 4),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: !_isHaveTool
                                    ? primaryColor
                                    : Colors.grey.withOpacity(0.5),
                                width: 1,
                              ),
                            ),
                            height: 45,
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Tidak',
                                  style: TextStyle(
                                    fontFamily: 'Kayak',
                                    fontWeight: FontWeight.bold,
                                    color: !_isHaveTool
                                        ? primaryColor
                                        : Colors.grey.withOpacity(0.5),
                                    fontSize: 12,
                                  ),
                                ),
                                if (!_isHaveTool)
                                  Icon(
                                    Icons.check,
                                    color: primaryColor,
                                    size: 14,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  if (_isHaveTool)
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'Alat bekerja Anda',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(8)),
                            hintText:
                                'Contoh : Perkakas, Alat Kebersihan, Kendaraan',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 16.0,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty && _isHaveTool) {
                              return 'Field tidak boleh kosong';
                            }
                          },
                          onSaved: (value) {
                            _editData['work_tools'] = value;
                          },
//                      onFieldSubmitted: (value) => _submit(),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                      ],
                    ),
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
                      onPressed: _submit,
                      child: Text(
                        'Simpan',
                        style: TextStyle(color: Colors.white),
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
