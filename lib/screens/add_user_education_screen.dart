import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:kerjakanapp/screens/drawer_screen.dart';
import 'package:kerjakanapp/screens/skill2_screen.dart';
import 'package:kerjakanapp/screens/skill_delivery_automotive_screen.dart';
import 'package:kerjakanapp/screens/skill_home_service_screen.dart';
import 'package:kerjakanapp/screens/skill_leisure_services_screen.dart';
import 'package:kerjakanapp/screens/skill_miscellaneous_screen.dart';
import 'package:kerjakanapp/screens/skill_personal_care_screen.dart';
import 'package:kerjakanapp/widgets/skills_list.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class AddUserEducationScreen extends StatefulWidget {
  static const String routeName = '/add-user-education-screen';

  @override
  _AddUserEducationScreenState createState() => _AddUserEducationScreenState();
}

class _AddUserEducationScreenState extends State<AddUserEducationScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();

  String level;
  String department;
  String startYear;
  String endYear;

  Map<String, dynamic> _editData = {};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    _editData['education_department'] = '$level $department';
    _editData['education_year'] = '$startYear - $endYear';

    final prevData = Provider.of<UserData>(context, listen: false).userData;
    var educationPlace = prevData['education_place'] as List<dynamic>;
    var educationDepartment = prevData['education_department'] as List<dynamic>;
    var educationYear = prevData['education_year'] as List<dynamic>;

    if (educationPlace == null) {
      educationPlace = [];
    }

    if (educationDepartment == null) {
      educationDepartment = [];
    }

    if (educationYear == null) {
      educationYear = [];
    }

    educationPlace.add(_editData['education_place']);
    educationDepartment.add(_editData['education_department']);
    educationYear.add(_editData['education_year']);

    Map<String, dynamic> _newEditData = {};
    _newEditData['education_place'] = [];
    educationPlace.forEach((element) {
      (_newEditData['education_place'] as List<dynamic>).add('\"$element\"');
    });

    _newEditData['education_department'] = [];
    educationDepartment.forEach((element) {
      (_newEditData['education_department'] as List<dynamic>)
          .add('\"$element\"');
    });

    _newEditData['education_year'] = [];
    educationYear.forEach((element) {
      (_newEditData['education_year'] as List<dynamic>).add('\"$element\"');
    });

    try {
      final id = Provider.of<Auth>(context, listen: false).id;

      await Provider.of<UserData>(context, listen: false)
          .requestEditUserEducation(id, _newEditData);

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Data berhasil disimpan')));
    } catch (error) {
      throw error;
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
                                'Tambah Riwayat Pendidikan',
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
                      'Instansi Pendidikan',
                      style: TextStyle(
                        fontFamily: 'Kayak',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Instansi',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Nama Instansi',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nama instansi tidak boleh kosong';
                          }
                        },
                        onSaved: (value) {
                          _editData['education_place'] = value;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tingkat Pendidikan',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Tingkat Pendidikan',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Tingkat pendidikan tidak boleh kosong';
                          }
                        },
                        onSaved: (value) {
                          level = value;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jurusan / Bidang / Keahlian Studi',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      TextFormField(
                        style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Jurusan / Bidang / Keahlian Studi',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Jurusan pendidikan tidak boleh kosong';
                          }
                        },
                        onSaved: (value) {
                          department = value;
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tahun Mulai',
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style:
                                  TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(8)),
                                hintText: 'Tahun mulai',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 16.0,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Tahun mulai tidak boleh kosong';
                                }
                              },
                              onSaved: (value) {
                                startYear = value;
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Tahun Selesai',
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            TextFormField(
                              keyboardType: TextInputType.number,
                              style:
                                  TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                    borderRadius: BorderRadius.circular(8)),
                                hintText: 'Tahun Selesai',
                                contentPadding: const EdgeInsets.symmetric(
                                  vertical: 0.0,
                                  horizontal: 16.0,
                                ),
                              ),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Tahun selesai tidak boleh kosong';
                                }
                              },
                              onSaved: (value) {
                                endYear = value;
                              },
                            ),
                          ],
                        ),
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
