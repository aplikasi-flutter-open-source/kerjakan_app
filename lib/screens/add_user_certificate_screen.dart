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

class AddUserCertificateScreen extends StatefulWidget {
  static const String routeName = '/add-user-certificate-screen';

  @override
  _AddUserCertificateScreenState createState() =>
      _AddUserCertificateScreenState();
}

class _AddUserCertificateScreenState extends State<AddUserCertificateScreen> {
  var _certificateDateController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();

  Map<String, dynamic> _editData = {};

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    final prevData = Provider.of<UserData>(context, listen: false).userData;
    var certificateName = prevData['certificate_name'] as List<dynamic>;
    var certificateInstansi = prevData['certificate_instansi'] as List<dynamic>;
    var certificateDate = prevData['certificate_date'] as List<dynamic>;

    if (certificateName == null) {
      certificateName = [];
    }

    if (certificateInstansi == null) {
      certificateInstansi = [];
    }

    if (certificateDate == null) {
      certificateDate = [];
    }

    certificateName.add(_editData['certificate_name']);
    certificateInstansi.add(_editData['certificate_instansi']);
    certificateDate.add(_editData['certificate_date']);

    Map<String, dynamic> _newEditData = {};
    _newEditData['certificate_name'] = [];
    certificateName.forEach((element) {
      (_newEditData['certificate_name'] as List<dynamic>).add('\"$element\"');
    });

    _newEditData['certificate_instansi'] = [];
    certificateInstansi.forEach((element) {
      (_newEditData['certificate_instansi'] as List<dynamic>)
          .add('\"$element\"');
    });

    _newEditData['certificate_date'] = [];
    certificateDate.forEach((element) {
      (_newEditData['certificate_date'] as List<dynamic>).add('\"$element\"');
    });

    try {
      final id = Provider.of<Auth>(context, listen: false).id;

      await Provider.of<UserData>(context, listen: false)
          .requestEditUserCertificate(id, _newEditData);

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Data berhasil disimpan')));
    } catch (error) {
      throw error;
    }
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
//        _editData['born_date'] = DateFormat('yyyy-MM-dd').format(pickedDate);
        _certificateDateController = TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(pickedDate));
      });
    });
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
                                'Tambah Sertifikasi',
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
                      'Sertifikasi',
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
                        'Nama Sertifikat / Surat',
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
                          hintText: 'Nama Sertifikasi',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nama sertifikasi tidak boleh kosong';
                          }
                        },
                        onSaved: (value) {
                          _editData['certificate_name'] = value;
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
                        'Instansi Sertifikasi',
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
                          _editData['certificate_instansi'] = value;
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
                        'Tanggal Sertifikasi',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          color: Colors.grey,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      InkWell(
                        onTap: _presentDatePicker,
                        child: IgnorePointer(
                          child: TextFormField(
                            controller: _certificateDateController,
                            style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(),
                                  borderRadius: BorderRadius.circular(8)),
                              hintText: 'dd / mm / yy',
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 0.0,
                                horizontal: 16.0,
                              ),
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Tanggal sertifikasi tidak boleh kosong';
                              }
                            },
                            onSaved: (value) {
                              _editData['certificate_date'] = value;
                            },
                          ),
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
