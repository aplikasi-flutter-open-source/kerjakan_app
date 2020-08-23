import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:kerjakanapp/screens/sign_up_screen_3.dart';
import 'package:provider/provider.dart';

class SignUpScreen2 extends StatefulWidget {
  static const String routeName = '/sign-up-screen-2';

  @override
  _SignUpScreen2State createState() => _SignUpScreen2State();
}

class _SignUpScreen2State extends State<SignUpScreen2> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _bornDateController = TextEditingController();
  String _gender;
  String _photoProfile;
  File _storeImage;

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

  Map<String, dynamic> _signUpData = {
    'photo_url': null,
    'name': null,
    'gender': null,
    'born_date': null,
    'phone_number': null,
    'address': null,
    'latitude': null,
    'longitude': null,
  };

  Future<void> _submit() async {
    if (_photoProfile == null) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Pilih foto profile Anda')));
      return;
    }
    _signUpData['photo_url'] = _photoProfile;

    if (_gender == null) {
      _scaffoldKey.currentState
          .showSnackBar(SnackBar(content: Text('Pilih jenis kelamin Anda')));
      return;
    }
    _signUpData['gender'] = _gender;

    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    print(_signUpData);

    Navigator.of(context)
        .pushNamed(SignUpScreen3.routeName, arguments: _signUpData);
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
        _signUpData['born_date'] = DateFormat('yyyy-MM-dd').format(pickedDate);
        _bornDateController = TextEditingController(
            text: DateFormat('dd/MM/yyyy').format(pickedDate));
      });
    });
  }

  var _addressController = TextEditingController();

  Future<void> getAddressPosition() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    _signUpData['latitude'] = position.latitude;
    _signUpData['longitude'] = position.longitude;

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    final _addressPosition = placemark[0].thoroughfare +
        ' No. ' +
        placemark[0].subThoroughfare +
        ', ' +
        placemark[0].subLocality +
        ', ' +
        placemark[0].subAdministrativeArea;

    _signUpData['city'] = placemark[0].subAdministrativeArea;

    print(placemark[0].subAdministrativeArea);

    setState(() {
      _addressController = TextEditingController(text: _addressPosition);
    });
  }

  var _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      getAddressPosition();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    _signUpData['email'] = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      key: _scaffoldKey,
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
                                padding: const EdgeInsets.only(right: 42.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.brightness_1,
                                      size: 8,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      size: 8,
                                      color: primaryColor,
                                    ),
                                    const SizedBox(
                                      width: 4,
                                    ),
                                    Icon(
                                      Icons.brightness_1,
                                      size: 8,
                                      color: primaryColor.withOpacity(0.25),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Step 2 of 3',
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                              color: primaryColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          'Pengaturan Akun',
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
                                          borderRadius:
                                              BorderRadius.circular(16),
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
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Pro Tip : Profile picture makes you 14 times more likely to be approached by others so choose wisely!',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          color: primaryColor,
                        ),
                      ),
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
                            _signUpData['name'] = value;
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
                                side:
                                    BorderSide(width: 1.0, color: Colors.grey),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                              ),
                            ),
                            child: DropdownButton<String>(
                              iconEnabledColor: Colors.grey,
                              isExpanded: true,
                              hint: const Text('Pilih Jenis Kelamin'),
                              value: _gender,
                              style:
                                  TextStyle(fontSize: 14, fontFamily: "Kayak"),
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
                              style:
                                  TextStyle(fontSize: 14, fontFamily: "Kayak"),
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
                                _signUpData['born_date'] = value;
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
                            _signUpData['phone_number'] = value;
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
                          controller: _addressController,
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
                            _signUpData['address'] = value;
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
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
                          'Lanjutkan',
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
