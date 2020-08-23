import 'package:flutter/material.dart';
import 'package:kerjakanapp/main.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/drawer_screen.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class ChangeUserModeScreen extends StatefulWidget {
  static const String routeName = '/change-user-mode-screen';

  @override
  _ChangeUserModeScreenState createState() => _ChangeUserModeScreenState();
}

class _ChangeUserModeScreenState extends State<ChangeUserModeScreen> {
  String _accountMode;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  var _isLoading = false;

  Future<void> _submit() async {
    if (_accountMode == null) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Pilih mode akun')));
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final id = Provider.of<Auth>(context, listen: false).id;
      await Provider.of<UserData>(context, listen: false)
          .setUserMode(_accountMode, id);

      setState(() {
        _isLoading = true;
      });
      Navigator.of(context).pushNamedAndRemoveUntil(
          DrawerScreen.routeName, (Route<dynamic> route) => false);
    } catch (error) {
      throw error;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
                              "Mode Akun",
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
                    'Mode Akun',
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
                      'Jenis Kelamin',
                      style: TextStyle(
                        fontFamily: 'Kayak',
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    DropdownButtonHideUnderline(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 0),
                        width: double.infinity,
                        decoration: ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(width: 1.0, color: Colors.grey),
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                          ),
                        ),
                        child: DropdownButton<String>(
                          iconEnabledColor: Colors.grey,
                          isExpanded: true,
                          hint: const Text('Pilih Mode Akun'),
                          value: _accountMode,
                          style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
                          iconSize: 24,
                          elevation: 16,
                          onChanged: (String newValue) {
//                            _examinationData[
//                            'hasil_swab'] =
//                                newValue;
                            setState(() {
                              _accountMode = newValue;
                            });
                          },
                          items: <String>[
                            'Mencari Pekerjaan',
                            'Mencari Pekerja',
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Kayak",
                                  color: Colors.black,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                      'Mengganti Mode Akun akan memulai kembali aplikasi Anda. Lanjutkan ganti mode?',
                      style: TextStyle(
                        fontFamily: 'Kayak',
                        color: Colors.grey,
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
                            'Ganti',
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
