import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:kerjakanapp/helper/define_job_category.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/user_skills.dart';
import 'package:kerjakanapp/provider/vacancies.dart';
import 'package:kerjakanapp/screens/finish_add_job_screen.dart';
import 'package:kerjakanapp/screens/sign_up_screen_2.dart';
import 'package:kerjakanapp/screens/sign_up_screen_finish.dart';
import 'package:kerjakanapp/screens/skill_delivery_automotive_screen.dart';
import 'package:kerjakanapp/screens/skill_home_service_screen.dart';
import 'package:kerjakanapp/screens/skill_leisure_services_screen.dart';
import 'package:kerjakanapp/screens/skill_miscellaneous_screen.dart';
import 'package:kerjakanapp/screens/skill_personal_care_screen.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class OpenJobScreen extends StatefulWidget {
  static const String routeName = '/open-job-screen';

  @override
  _OpenJobScreenState createState() => _OpenJobScreenState();
}

class _OpenJobScreenState extends State<OpenJobScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  var _isHaveTool = true;
  var _isPerHour = true;
  Map<String, dynamic> _vacancyData = {};
  var _addressController = TextEditingController();

  Future<void> getAddressPosition() async {
    Position position = await Geolocator()
        .getLastKnownPosition(desiredAccuracy: LocationAccuracy.high);

    _vacancyData['latitude'] = position.latitude;
    _vacancyData['longitude'] = position.longitude;

    List<Placemark> placemark = await Geolocator()
        .placemarkFromCoordinates(position.latitude, position.longitude);
    final _addressPosition = placemark[0].thoroughfare +
        ' No. ' +
        placemark[0].subThoroughfare +
        ', ' +
        placemark[0].subLocality +
        ', ' +
        placemark[0].subAdministrativeArea;

    _vacancyData['city'] = placemark[0].subAdministrativeArea;

    print(placemark[0].subAdministrativeArea);

    setState(() {
      _addressController = TextEditingController(text: _addressPosition);
    });
  }

  var _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      // Invalid!
      return;
    }
    _formKey.currentState.save();

    _vacancyData['upload_date'] =
        DateFormat('dd/MM/yyyy').format(DateTime.now());

    _isPerHour
        ? _vacancyData['salary_time'] = 'Jam'
        : _vacancyData['salary_time'] = 'Hari';

    _vacancyData['employer_id'] = Provider.of<Auth>(context, listen: false).id;

    setState(() {
      _isLoading = true;
    });

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

    _vacancyData['category'] = DefineJobCategory(
      homeServiceSkills: _homeServiceSkills,
      deliverySkills: _deliveryAndAutomotiveSkills,
      leisureSkills: _leisureServiceSkills,
      miscSkills: _miscellaneousSkills,
      personalHealthSkills: _personalHealthCareSkills,
    ).getCategory();

    _vacancyData['skills'] = [];

    _allSkills.forEach((element) {
      (_vacancyData['skills']).add('\"$element\"');
    });

    try {
      print(_vacancyData);

      await Provider.of<Vacancies>(context, listen: false)
          .uploadVacancy(_vacancyData);

      Navigator.of(context)
          .pushNamed(FinishAddJobScreen.routeName, arguments: _vacancyData);
    } catch (error) {
      throw error;
    }

    setState(() {
      _isLoading = false;
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
    final List<dynamic> _allSkills = [];
    final List<dynamic> _deliveryAndAutomotiveSkills =
        Provider.of<UserSkills>(context).deliveryAndAutomotiveSkills;
    final List<dynamic> _homeServiceSkills =
        Provider.of<UserSkills>(context).homeServiceSkills;
    final List<dynamic> _personalHealthCareSkills =
        Provider.of<UserSkills>(context).personalHealthCareSkills;
    final List<dynamic> _leisureServiceSkills =
        Provider.of<UserSkills>(context).leisureServiceSkills;
    final List<dynamic> _miscellaneousSkills =
        Provider.of<UserSkills>(context).miscellaneousSkills;

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
                              'Buat Lowongan',
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
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kebutuhan Anda',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Berhubungan langsung dengan para pekerja dan penyedia jasa yang kompeten dan berminat membantu kebutuhan Anda!',
                        style: descStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Kebutuhan Anda',
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
                            hintText: 'Masukkan kebutuhan Anda',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 16.0,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Masukkan kebutuhan Anda';
                            }
                          },
                          onSaved: (value) {
                            _vacancyData['title'] = value;
                          },
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
                          'Deskripsikan kebutuhan Anda',
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
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(8)),
                            hintText:
                                'Ceritakan lebih lanjut terkait kebutuhan anda disini...',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16.0,
                              horizontal: 16.0,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Masukkan deskripsi kebutuhan Anda';
                            }
                          },
                          onSaved: (value) {
                            _vacancyData['description'] = value;
                          },
//                      onFieldSubmitted: (value) => _submit(),
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
                          'Alamat Anda',
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
                            hintText: 'Alamat Anda',
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
                            _vacancyData['address'] = value;
                          },
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
                          'Upload Foto (Opsional)',
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey),
                              borderRadius: BorderRadius.circular(8)),
                          width: double.infinity,
                          height: 80,
                          child: Image.asset(
                            'assets/images/ic_camera.png',
                            width: 24,
                            height: 21,
                            color: primaryColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Kebutuhan Anda',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Berhubungan langsung dengan para pekerja dan penyedia jasa yang kompeten dan berminat membantu kebutuhan Anda!',
                        style: descStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(8)),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: GridView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(4.0),
                          itemCount: _allSkills.length + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            childAspectRatio: 6 / 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4,
                          ),
                          itemBuilder: (context, index) {
                            return InkWell(
                              child: Container(
                                alignment: Alignment.center,
                                height: 36,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: index == _allSkills.length
                                        ? primaryColor
                                        : primaryLighterColor.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(8)),
                                child: index == _allSkills.length
                                    ? InkWell(
                                        onTap: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                              title: Text(
                                                'Tambahkan Keahlian',
                                                style: titleStyle,
                                              ),
                                              content: Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const SizedBox(
                                                    height: 16,
                                                  ),
                                                  InkWell(
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .pushNamed(
                                                            SkillDeliveryAutomotiveScreen
                                                                .routeName),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryLighterColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          'Delivery and Automotive',
                                                          style: TextStyle(
                                                            fontFamily: 'Kayak',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        trailing: RotatedBox(
                                                          quarterTurns: 90,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_back_ios,
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
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .pushNamed(
                                                            SkillHomeServiceScreen
                                                                .routeName),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryLighterColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          'Home and Food Services',
                                                          style: TextStyle(
                                                            fontFamily: 'Kayak',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        trailing: RotatedBox(
                                                          quarterTurns: 90,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_back_ios,
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
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .pushNamed(
                                                            SkillPersonalCareScreen
                                                                .routeName),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryLighterColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          'Personal & Health Care',
                                                          style: TextStyle(
                                                            fontFamily: 'Kayak',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        trailing: RotatedBox(
                                                          quarterTurns: 90,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_back_ios,
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
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .pushNamed(
                                                            SkillLeisureServicesScreen
                                                                .routeName),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryLighterColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          'Leisure Services',
                                                          style: TextStyle(
                                                            fontFamily: 'Kayak',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        trailing: RotatedBox(
                                                          quarterTurns: 90,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_back_ios,
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
                                                    onTap: () => Navigator.of(
                                                            context)
                                                        .pushNamed(
                                                            SkillMiscellaneousScreen
                                                                .routeName),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                        color:
                                                            primaryLighterColor,
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: ListTile(
                                                        title: Text(
                                                          'Miscellaneous',
                                                          style: TextStyle(
                                                            fontFamily: 'Kayak',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            color: Colors.white,
                                                          ),
                                                        ),
                                                        trailing: RotatedBox(
                                                          quarterTurns: 90,
                                                          child: Icon(
                                                            Icons
                                                                .arrow_back_ios,
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
                                                ],
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add,
                                              size: 12,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 4,
                                            ),
                                            Text(
                                              'Tambahkan',
                                              style: TextStyle(
                                                fontFamily: 'Kayak',
                                                color: Colors.white,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    : Text(
                                        _allSkills[index],
                                        style: TextStyle(
                                          fontFamily: 'Kayak',
                                          color: primaryLighterColor,
                                          fontSize: 10,
                                        ),
                                      ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Apakah Anda menyediakan alat yang dibutuhkan?',
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
                              'Alat yang Anda sediakan',
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 4,
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
                              _vacancyData['tools'] = value;
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
                        'Pembayaran',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Berikan keterangan terkait pembayaran yang Anda inginkan.',
                        style: TextStyle(fontFamily: 'Kayak', fontSize: 12),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Hitungan Pembayaran',
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
                                _isPerHour = true;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(right: 4),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(
                                    color: _isPerHour
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
                                    'Per Jam',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.bold,
                                      color: _isPerHour
                                          ? Color(0xFF4C6DE3)
                                          : Colors.grey.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (_isPerHour)
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
                                _isPerHour = false;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(left: 4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: !_isPerHour
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
                                    'Per Hari',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.bold,
                                      color: !_isPerHour
                                          ? Color(0xFF4C6DE3)
                                          : Colors.grey.withOpacity(0.5),
                                      fontSize: 12,
                                    ),
                                  ),
                                  if (!_isPerHour)
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Nominal Pembayaran',
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
                          style: TextStyle(fontSize: 14, fontFamily: "Kayak"),
//                      focusNode: _passFocusNode,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderSide: BorderSide(),
                                borderRadius: BorderRadius.circular(8)),
                            hintText: 'Masukkan nominal pembayaran Anda',
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 0.0,
                              horizontal: 16.0,
                            ),
                          ),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Masukkan nominal pembayaran';
                            }
                          },
                          onSaved: (value) {
                            _vacancyData['salary'] = value;
                          },
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
                                'Buat Lowongan',
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
