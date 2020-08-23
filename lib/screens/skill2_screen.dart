import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';
import 'package:kerjakanapp/screens/sign_up_screen_finish.dart';
import 'package:kerjakanapp/screens/skill_delivery_automotive_screen.dart';
import 'package:kerjakanapp/screens/skill_home_service_screen.dart';
import 'package:kerjakanapp/screens/skill_leisure_services_screen.dart';
import 'package:kerjakanapp/screens/skill_miscellaneous_screen.dart';
import 'package:kerjakanapp/screens/skill_personal_care_screen.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class Skill2Screen extends StatefulWidget {
  static const String routeName = '/skill2-screen';

  @override
  _Skill2ScreenState createState() => _Skill2ScreenState();
}

class _Skill2ScreenState extends State<Skill2Screen> {
  var _isHaveTool = true;
  var _isHaveCertificate = true;
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _signUpData;
  var _certificateDateController = TextEditingController();

  var _isLoading = false;

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
        _signUpData['certificate_date'] = [
          '\"${DateFormat('yyyy-MM-dd').format(pickedDate)}\"'
        ];
        _certificateDateController = TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(pickedDate));
      });
    });
  }

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    setState(() {
      _isLoading = true;
    });

    try {
      await Provider.of<Auth>(context, listen: false)
          .signUpCariKerja(_signUpData);

      Navigator.of(context).pushNamedAndRemoveUntil(
          SignUpScreenFinish.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      throw error;
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    _signUpData =
        ModalRoute.of(context).settings.arguments as Map<String, dynamic>;
    print('data $_signUpData');
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Container(
            height: double.infinity,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
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
                      style: descStyle,
                    ),
                    const SizedBox(
                      height: 24,
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
                      height: 8,
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
                                        ? Color(0xFF4C6DE3)
                                        : Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  )),
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ya',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.bold,
                                      color: _isHaveTool
                                          ? Color(0xFF4C6DE3)
                                          : Colors.grey.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (_isHaveTool)
                                    Icon(
                                      Icons.check,
                                      color: Color(0xFF4C6DE3),
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
                                      ? Color(0xFF4C6DE3)
                                      : Colors.grey.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tidak',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.bold,
                                      color: !_isHaveTool
                                          ? Color(0xFF4C6DE3)
                                          : Colors.grey.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (!_isHaveTool)
                                    Icon(
                                      Icons.check,
                                      color: Color(0xFF4C6DE3),
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
                                return 'Masukkan alat bekerja anda';
                              }
                            },
                            onSaved: (value) {
                              _signUpData['work_tools'] = value;
                            },
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Apakah Anda memiliki sertifikasi untuk keahlian Anda?',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Sertifikat keahlian, workshop, surat kesehatan, dan sejenisnya.',
                        style: TextStyle(fontFamily: 'Kayak', fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _isHaveCertificate = true;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _isHaveCertificate
                                        ? Color(0xFF4C6DE3)
                                        : Colors.grey.withOpacity(0.5),
                                    width: 1,
                                  )),
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Ya',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.bold,
                                      color: _isHaveCertificate
                                          ? Color(0xFF4C6DE3)
                                          : Colors.grey.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (_isHaveCertificate)
                                    Icon(
                                      Icons.check,
                                      color: Color(0xFF4C6DE3),
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
                                _isHaveCertificate = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: !_isHaveCertificate
                                      ? Color(0xFF4C6DE3)
                                      : Colors.grey.withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              height: 45,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Tidak',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.bold,
                                      color: !_isHaveCertificate
                                          ? Color(0xFF4C6DE3)
                                          : Colors.grey.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (!_isHaveCertificate)
                                    Icon(
                                      Icons.check,
                                      color: Color(0xFF4C6DE3),
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
                      height: 8,
                    ),
                    if (_isHaveCertificate)
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
                              if (value.isEmpty && _isHaveCertificate) {
                                return 'Masukkan nama sertifikasi';
                              }
                            },
                            onSaved: (value) {
                              _signUpData['certificate_name'] = ['\"$value\"'];
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
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
                              if (value.isEmpty && _isHaveCertificate) {
                                return 'Masukkan nama instansi';
                              }
                            },
                            onSaved: (value) {
                              _signUpData['certificate_instansi'] = [
                                '\"$value\"'
                              ];
                            },
                          ),
                          const SizedBox(
                            height: 8,
                          ),
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
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "Kayak"),
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
                                  if (value.isEmpty && _isHaveCertificate) {
                                    return 'Masukkan tanggal sertifikasi';
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    const SizedBox(
                      height: 24,
                    ),
                    Container(
                      width: 148,
                      height: 40,
                      margin: const EdgeInsets.only(bottom: 16),
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(),
                            )
                          : FlatButton(
                              color: primaryColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16)),
                              onPressed: _submit,
                              child: Text(
                                'Selesai',
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
      ),
    );
  }
}
