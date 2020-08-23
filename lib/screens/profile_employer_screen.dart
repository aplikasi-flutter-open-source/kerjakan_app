import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/provider/vacancies.dart';
import 'package:kerjakanapp/screens/add_user_certificate_screen.dart';
import 'package:kerjakanapp/screens/add_user_education_screen.dart';
import 'package:kerjakanapp/screens/edit_profil_job_seeker_screen.dart';
import 'package:kerjakanapp/screens/edit_skills_screen.dart';
import 'package:kerjakanapp/screens/open_job_screen.dart';
import 'package:kerjakanapp/screens/vecancy_detail_screen.dart';
import 'package:provider/provider.dart';

class ProfileEmployerScreen extends StatefulWidget {
  final Function changeCollapseStatus;

  ProfileEmployerScreen({this.changeCollapseStatus});

  @override
  _ProfileEmployerScreenState createState() => _ProfileEmployerScreenState();
}

class _ProfileEmployerScreenState extends State<ProfileEmployerScreen> {
  var _isInit = true;

  List<Job> _listVacancy = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      final id = Provider.of<Auth>(context, listen: false).id;
      Provider.of<Vacancies>(context, listen: false)
          .getMyVacancy(id)
          .then((value) {
        setState(() {
          _listVacancy = Provider.of<Vacancies>(context, listen: false).items;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _userData = Provider.of<UserData>(context, listen: false).userData;
    return Scaffold(
      backgroundColor: primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.menu,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    onPressed: widget.changeCollapseStatus,
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.settings,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    onPressed: () => Navigator.of(context)
                        .pushNamed(EditProfileJobSeekerScreen.routeName),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Profil',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Kayak',
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      height: 72,
                      width: 72,
                      decoration: BoxDecoration(
                        color: primaryLighterColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: _userData['photo_url'] == 'a'
                          ? Image.asset('assets/images/avatar_a.png')
                          : _userData['photo_url'] == 'b'
                              ? Image.asset('assets/images/avatar_b.png')
                              : _userData['photo_url'] == 'c'
                                  ? Image.asset('assets/images/avatar_c.png')
                                  : _userData['photo_url'] == 'd'
                                      ? Image.asset(
                                          'assets/images/avatar_c.png')
                                      : Image.network(_userData['photo_url']),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userData['name'],
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Kayak',
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          _userData['address'],
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 12,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          _userData['email'],
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 12,
                              color: Colors.white),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          _userData['phone_number'],
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 12,
                              color: Colors.white),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(16),
                    topLeft: Radius.circular(16),
                  ),
                  color: primaryDarkColor,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 40,
                            width: 40,
                            child: Image.asset('assets/images/il_badges_a.png'),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Image.asset(
                                'assets/images/ic_badges.png',
                                width: 13.14,
                                height: 24,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Image.asset(
                                'assets/images/ic_badges.png',
                                width: 13.14,
                                height: 24,
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            height: 40,
                            width: 40,
                            child: Center(
                              child: Image.asset(
                                'assets/images/ic_badges.png',
                                width: 13.14,
                                height: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(16),
                          topLeft: Radius.circular(16),
                        ),
                        color: Colors.white,
                      ),
                      height: 16,
                    ),
                  ],
                ),
              ),
              Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 16, top: 16),
                      child: const Text(
                        'Lowongan Berlangsung',
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Lowongan Anda yang sedang Berlangsung',
                        style: descStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(OpenJobScreen.routeName),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryLighterColor),
                        child: ListTile(
                          leading: Container(
                            alignment: Alignment.center,
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: Image.asset(
                              'assets/images/ic_open_job.png',
                              width: 14.55,
                              height: 16,
                            ),
                          ),
                          title: Text(
                            'Buat Lowongan',
                            style: TextStyle(
                                fontFamily: 'Kayak',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Buat lowongan dan lihat pekerja terbaik menawarkan jasanya!',
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 10,
                              color: Colors.white,
                            ),
                          ),
                          trailing: RotatedBox(
                            quarterTurns: 90,
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: _listVacancy.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 5,
                          shadowColor: greyColor.withOpacity(0.15),
                          child: InkWell(
                            onTap: () => Navigator.of(context).pushNamed(
                                VacancyDetailScreen.routeName,
                                arguments: _listVacancy[index]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 8),
                                        child: _listVacancy[index]
                                                    .jobCategory ==
                                                'Home'
                                            ? Image.asset(
                                                'assets/images/placeholder_home.png',
                                                height: 32,
                                                width: 32,
                                              )
                                            : _listVacancy[index].jobCategory ==
                                                    'Self Care'
                                                ? Image.asset(
                                                    'assets/images/placeholder_self_care.png',
                                                    height: 32,
                                                    width: 32,
                                                  )
                                                : _listVacancy[index]
                                                            .jobCategory ==
                                                        'Auto'
                                                    ? Image.asset(
                                                        'assets/images/placeholder_auto.png',
                                                        height: 32,
                                                        width: 32,
                                                      )
                                                    : _listVacancy[index]
                                                                .jobCategory ==
                                                            'Other'
                                                        ? Image.asset(
                                                            'assets/images/placeholder_other.png',
                                                            height: 32,
                                                            width: 32,
                                                          )
                                                        : _listVacancy[index]
                                                                    .jobCategory ==
                                                                'Leisure'
                                                            ? Image.asset(
                                                                'assets/images/placeholder_leisure.png',
                                                                height: 32,
                                                                width: 32,
                                                              )
                                                            : null,
                                      ),
                                      Stack(
                                        children: [
                                          Image.asset(
                                            'assets/images/ic_banner.png',
                                            width: 20,
                                            height: 16,
                                          ),
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: _listVacancy[index]
                                                          .jobCategory ==
                                                      'Home'
                                                  ? Image.asset(
                                                      'assets/images/ic_house.png',
                                                      width: 8,
                                                      height: 8,
                                                    )
                                                  : _listVacancy[index]
                                                              .jobCategory ==
                                                          'Auto'
                                                      ? Image.asset(
                                                          'assets/images/ic_auto.png',
                                                          width: 8,
                                                          height: 8,
                                                        )
                                                      : _listVacancy[index]
                                                                  .jobCategory ==
                                                              'Leisure'
                                                          ? Image.asset(
                                                              'assets/images/ic_leisure.png',
                                                              width: 8,
                                                              height: 8,
                                                            )
                                                          : _listVacancy[index]
                                                                      .jobCategory ==
                                                                  'Other'
                                                              ? Image.asset(
                                                                  'assets/images/ic_other.png',
                                                                  width: 8,
                                                                  height: 8,
                                                                )
                                                              : _listVacancy[index]
                                                                          .jobCategory ==
                                                                      'Self Care'
                                                                  ? Image.asset(
                                                                      'assets/images/ic_personal.png',
                                                                      width: 8,
                                                                      height:
                                                                          12,
                                                                    )
                                                                  : null,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          _listVacancy[index].jobTitle,
                                          style: TextStyle(
                                            fontFamily: 'Kayak',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          'Rp. ${oCcy.format(_listVacancy[index].jobSalary)},-/ ${_listVacancy[index].timeSalary}',
                                          style: TextStyle(
                                            fontFamily: 'Kayak',
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Text(
                                          _listVacancy[index].uploadDate,
                                          maxLines: 2,
                                          style: TextStyle(
                                              fontSize: 10, color: Colors.grey),
                                        ),
                                        const SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          _listVacancy[index].jobDesc,
                                          style: TextStyle(
                                            fontFamily: 'Kayak',
                                            fontSize: 12,
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 4,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: primaryLighterColor,
                                                  ),
                                                  child: Image.asset(
                                                      'assets/images/avatar_a.png'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: primaryLighterColor,
                                                  ),
                                                  child: Image.asset(
                                                      'assets/images/avatar_c.png'),
                                                ),
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: primaryLighterColor,
                                                  ),
                                                  child: Image.asset(
                                                      'assets/images/avatar_a.png'),
                                                ),
                                                Container(
                                                  margin:
                                                      const EdgeInsets.all(2),
                                                  height: 20,
                                                  width: 20,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: primaryLighterColor
                                                        .withOpacity(0.1),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      '+2',
                                                      style: TextStyle(
                                                        fontSize: 8,
                                                        fontFamily: 'Kayak',
                                                        color:
                                                            primaryLighterColor,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Container(
                                              width: 84,
                                              height: 20,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: primaryColor),
                                              child: Center(
                                                child: Text(
                                                  'Lihat Semua Pekerja',
                                                  style: TextStyle(
                                                    fontFamily: 'Kayak',
                                                    fontSize: 8,
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Review Saya',
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Review dari pekerja dan jasa yang saya sukai!',
                        style: descStyle,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 16),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: primaryLighterColor.withOpacity(0.1)),
                        child: Row(
                          children: [
                            Container(
                              alignment: Alignment.center,
                              width: 44,
                              height: 44,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryLighterColor,
                              ),
                              child: Image.asset(
                                'assets/images/ic_review_tips.png',
                                width: 20,
                                height: 22,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Bintang untuk tiap hal yang dikerjakan',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: primaryLighterColor,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  const Text(
                                    'Berikan bintang kepada para pekerja atau jasa yang anda gunakan melalui menu pada profil mereka. dan dapatkan bonus.',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontSize: 10,
                                      color: primaryLighterColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Card(
                        elevation: 5,
                        shadowColor: greyColor.withOpacity(0.15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8)),
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: primaryLighterColor,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  height: 32,
                                  width: 32,
                                  child: Image.asset(
                                    'assets/images/avatar_b.png',
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          '4',
                                          style: TextStyle(
                                            fontFamily: 'Kayak',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 4,
                                        ),
                                        Icon(Icons.star,
                                            size: 14, color: Color(0xFFFBBF12)),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Amera Braga',
                                      style: TextStyle(
                                        fontFamily: 'Kayak',
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 4,
                                    ),
                                    Text(
                                      'Amira bekerja dengan sangat baik dan profesional. Saya sangat-sangat merekomendasikan. GG. Lorem ipsum dolor sit amet',
                                      style: TextStyle(
                                          fontFamily: 'Kayak',
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.grey),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_listVacancy.length == 0)
                      const SizedBox(
                        height: 300,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
