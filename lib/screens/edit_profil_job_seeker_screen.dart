import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kerjakanapp/main.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:kerjakanapp/screens/change_user_mode.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';

import '../const.dart';

class EditProfileJobSeekerScreen extends StatefulWidget {
  static const String routeName = '/edit-profile-job-sekeer-screen';

  @override
  _EditProfileJobSeekerScreenState createState() =>
      _EditProfileJobSeekerScreenState();
}

class _EditProfileJobSeekerScreenState
    extends State<EditProfileJobSeekerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _bornDateController = TextEditingController();
  String _gender;
  String _photoProfile;
  File _storeImage;

  var _isInit = true;

  Map<String, dynamic> _userData;

  Map<String, dynamic> _editData = {};

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _userData = Provider.of<UserData>(context, listen: false).userData;

      _gender = _userData['gender'];
      _photoProfile = _userData['photo_url'];

      _bornDateController = TextEditingController(text: _userData['born_date']);
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _takePicture() async {
    if (_photoProfile == null) {
      return;
    }

    setState(() {
      _photoProfile = 'd';
    });
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.camera,
      maxWidth: 600,
    );

    if (pickedFile == null) {
      return;
    }

    setState(() {
      _storeImage = File(pickedFile.path);
    });

    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(pickedFile.path);
    final saveImage =
        await File(pickedFile.path).copy('${appDir.path}/$fileName');

    Provider.of<UserData>(context, listen: false).savedImage(saveImage.path);
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
        _editData['born_date'] = DateFormat('yyyy-MM-dd').format(pickedDate);
        _bornDateController = TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(pickedDate));
      });
    });
  }

  Future<void> _submit() async {
    _editData['photo_url'] = _photoProfile;
    _editData['gender'] = _gender;

    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    try {
      final _id = Provider.of<Auth>(context, listen: false).id;
      await Provider.of<UserData>(context, listen: false)
          .requestEditUserData(_id, _editData);

      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Data berhasil disimpan')));
    } catch (error) {
      throw error;
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Form(
        key: _formKey,
        child: SafeArea(
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
                                "Profil",
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
                      'Foto Profil',
                      style: descStyle,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: greyColor.withOpacity(0.5),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _photoProfile = 'a';
                                });
                              },
                              child: Container(
                                height: 66,
                                width: 66,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: _photoProfile == 'a'
                                        ? Color(0xFF4C6DE3)
                                        : Colors.white),
                                child: Center(
                                  child: _photoProfile == 'a'
                                      ? Image.asset(
                                          'assets/images/avatar_a.png',
                                          width: 35.48,
                                          height: 38.11,
                                        )
                                      : Container(
                                          foregroundDecoration: BoxDecoration(
                                            color: Colors.grey,
                                            backgroundBlendMode:
                                                BlendMode.saturation,
                                          ),
                                          child: Image.asset(
                                            'assets/images/avatar_a.png',
                                            width: 35.48,
                                            height: 38.11,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: greyColor.withOpacity(0.5),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _photoProfile = 'b';
                                });
                              },
                              child: Container(
                                height: 66,
                                width: 66,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: _photoProfile == 'b'
                                        ? Color(0xFF4C6DE3)
                                        : Colors.white),
                                child: Center(
                                  child: _photoProfile == 'b'
                                      ? Image.asset(
                                          'assets/images/avatar_b.png',
                                          width: 40.74,
                                          height: 39.75,
                                        )
                                      : Container(
                                          foregroundDecoration: BoxDecoration(
                                            color: Colors.grey,
                                            backgroundBlendMode:
                                                BlendMode.saturation,
                                          ),
                                          child: Image.asset(
                                            'assets/images/avatar_b.png',
                                            width: 40.74,
                                            height: 39.75,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: greyColor.withOpacity(0.5),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  _photoProfile = 'c';
                                });
                              },
                              child: Container(
                                height: 66,
                                width: 66,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: _photoProfile == 'c'
                                        ? Color(0xFF4C6DE3)
                                        : Colors.white),
                                child: Center(
                                  child: _photoProfile == 'c'
                                      ? Image.asset(
                                          'assets/images/avatar_c.png',
                                          width: 37.78,
                                          height: 37.03,
                                        )
                                      : Container(
                                          foregroundDecoration: BoxDecoration(
                                            color: Colors.grey,
                                            backgroundBlendMode:
                                                BlendMode.saturation,
                                          ),
                                          child: Image.asset(
                                            'assets/images/avatar_c.png',
                                            width: 37.78,
                                            height: 37.03,
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            elevation: 5,
                            shadowColor: greyColor.withOpacity(0.5),
                            child: InkWell(
                              onTap: _takePicture,
                              child: _storeImage == null
                                  ? Container(
                                      height: 66,
                                      width: 66,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          'assets/images/ic_camera.png',
                                          width: 24,
                                          height: 21,
                                          color: Color(0xFFEBEBEB),
                                        ),
                                      ),
                                    )
                                  : ClipRRect(
                                      borderRadius: BorderRadius.circular(16),
                                      child: Image.file(
                                        _storeImage,
                                        height: 66,
                                        width: 66,
                                      ),
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Nama Lengkap',
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
                        initialValue: _userData['name'],
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Nama Langkap',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                        },
                        onSaved: (value) {
                          _editData['name'] = value;
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
                            hint: const Text('Pilih Jenis Kelamin'),
                            value: _gender,
                            style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
                            iconSize: 24,
                            elevation: 16,
                            onChanged: (String newValue) {
//                            _examinationData[
//                            'hasil_swab'] =
//                                newValue;
                              setState(() {
                                _gender = newValue;
                              });
                            },
                            items: <String>[
                              'Laki-laki',
                              'Perempuan',
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
                    ],
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Tanggal Lahir',
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
                            controller: _bornDateController,
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
                                return 'Tanggal lahir tidak boleh kosong';
                              }
                            },
                            onSaved: (value) {
                              _editData['born_date'] = value;
                            },
                          ),
                        ),
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
                        'Nomor Telepon',
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
                        initialValue: 'phone_number',
                        style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
                        keyboardType: TextInputType.number,
//                      focusNode: _passFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Nomor Telepon',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Nomor telepon tidak boleh kosong';
                          }
                        },
                        onSaved: (value) {
                          _editData['phone_number'] = value;
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
                        'Alamat Tinggal',
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
                        initialValue: _userData['address'],
                        style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(8)),
                          hintText: 'Alamat Tinggal',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 0.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Alamat tinggal tidak boleh kosong';
                          }
                        },
                        onSaved: (value) {
                          _editData['address'] = value;
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
                        'Deskripsikan Profil Anda',
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
                        initialValue: _userData['description'],
                        keyboardType: TextInputType.multiline,
                        maxLines: 5,
                        style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(),
                              borderRadius: BorderRadius.circular(8)),
                          hintText:
                              'Anda dapat menceritakan keahlian, atau latar belakang diri Anda...',
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: 16.0,
                            horizontal: 16.0,
                          ),
                        ),
                        validator: (value) {},
                        onSaved: (value) {
                          _editData['description'] = value;
                        },
//                      onFieldSubmitted: (value) => _submit(),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
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
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed(ChangeUserModeScreen.routeName),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Color(0xFF26BFF0)),
                              child: Image.asset(
                                'assets/images/ic_change_mode.png',
                                width: 14,
                                height: 16,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Mode Akun',
                              style: titleStyle,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              _userData['mode'] == 'Mencari Pekerjaan'
                                  ? 'Cari Kerja'
                                  : 'Cari Jasa',
                              style: descStyle,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            RotatedBox(
                              quarterTurns: 90,
                              child: Icon(
                                Icons.arrow_back_ios,
                                size: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).logOut();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          MainScreen.routeName,
                          (Route<dynamic> route) => false);
                    },
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(0xFFE34C4C)),
                          child: Image.asset(
                            'assets/images/ic_log_out.png',
                            width: 17.49,
                            height: 16,
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          'Log Out',
                          style: titleStyle,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 16,
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
