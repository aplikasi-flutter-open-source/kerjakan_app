import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/add_user_certificate_screen.dart';
import 'package:kerjakanapp/screens/add_user_education_screen.dart';
import 'package:kerjakanapp/screens/edit_profil_job_seeker_screen.dart';
import 'package:kerjakanapp/screens/edit_skills_screen.dart';
import 'package:provider/provider.dart';

class ProfileJobSeekerScreen extends StatelessWidget {
  final Function changeCollapseStatus;

  ProfileJobSeekerScreen({this.changeCollapseStatus});

  @override
  Widget build(BuildContext context) {
    final _userData = Provider.of<UserData>(context, listen: false).userData;
    final List<String> _userSkills = [
      ..._userData['delivery_skills'],
      ..._userData['home_service_skills'],
      ..._userData['leisure_skills'],
      ..._userData['misc_skills'],
      ..._userData['personal_health_skills']
    ];

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
                    onPressed: changeCollapseStatus,
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
                        'Resume',
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Informasi terkait pekerjaan dan keahlian Saya.',
                        style: descStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                                'assets/images/ic_resume_tips.png',
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
                                    'Lengkapi Resume Anda',
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
                                    'Informasi lengkap pada Resume Anda dapat meningkatkan kesempatan bekerja Anda.',
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: const Text(
                            'Tentang Saya',
                            style: titleStyle,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 16.0,
                            color: primaryColor,
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(EditProfileJobSeekerScreen.routeName),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        _userData['description'] == null
                            ? 'Belum ada profil'
                            : _userData['description'],
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          height: 1.5,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: const Text(
                            'Keahlian Saya',
                            style: titleStyle,
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.edit,
                            size: 16.0,
                            color: primaryColor,
                          ),
                          onPressed: () => Navigator.of(context)
                              .pushNamed(EditSkillScreen.routeName),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.all(4.0),
                        itemCount: _userSkills.length + 1,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          childAspectRatio: 6 / 2,
                          crossAxisSpacing: 4,
                          mainAxisSpacing: 4,
                        ),
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: index == _userSkills.length
                                ? () => Navigator.of(context)
                                    .pushNamed(EditSkillScreen.routeName)
                                : null,
                            child: Container(
                              alignment: Alignment.center,
                              height: 36,
                              padding: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                  color: index == _userSkills.length
                                      ? primaryColor
                                      : primaryLighterColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(8)),
                              child: index == _userSkills.length
                                  ? Row(
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
                                    )
                                  : Text(
                                      _userSkills[index],
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
                    if (_userData['work_tools'] != 'null' &&
                        _userData['work_tools'] != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16, top: 16),
                        child: const Text(
                          'Alat Bekerja',
                          style: titleStyle,
                        ),
                      ),
                    if (_userData['work_tools'] != 'null' &&
                        _userData['work_tools'] != null)
                      const SizedBox(
                        height: 8,
                      ),
                    if (_userData['work_tools'] != 'null' &&
                        _userData['work_tools'] != null)
                      Padding(
                        padding: const EdgeInsets.only(left: 16),
                        child: Text(
                          _userData['work_tools'],
                          style: descStyle,
                        ),
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Riwayat Pendidikan',
                        style: titleStyle,
                      ),
                    ),
                    if (_userData['education_place'] != null)
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            (_userData['education_place'] as List<dynamic>)
                                .length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 16),
                          child: Card(
                            elevation: 5,
                            shadowColor: greyColor.withOpacity(0.15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              leading: Container(
                                alignment: Alignment.center,
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        primaryLighterColor.withOpacity(0.1)),
                                child: Image.asset(
                                  'assets/images/ic_education.png',
                                  width: 16,
                                  height: 16.8,
                                  color: primaryLighterColor,
                                ),
                              ),
                              title: Text(
                                (_userData['education_place']
                                    as List<dynamic>)[index],
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              subtitle: Text(
                                '${(_userData['education_department'] as List<dynamic>)[index]} . ${(_userData['education_year'] as List<dynamic>)[index]}',
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontSize: 10,
                                ),
                              ),
                              trailing: Icon(
                                Icons.edit,
                                size: 12,
                                color: primaryColor,
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
                          .pushNamed(AddUserEducationScreen.routeName),
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
                              'assets/images/ic_education.png',
                              width: 16,
                              height: 16.8,
                            ),
                          ),
                          title: Text(
                            'Tambahkan Riwayat Lainnya',
                            style: TextStyle(
                                fontFamily: 'Kayak',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Riwayat ini membantu Anda memperoleh pekerjaan yang sesuai',
                            style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 10,
                                color: Colors.white),
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
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: const Text(
                        'Sertifikasi',
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    if (_userData['certificate_name'] != null)
                      ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount:
                            (_userData['certificate_name'] as List<dynamic>)
                                .length,
                        itemBuilder: (context, index) => Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, bottom: 16),
                          child: Card(
                            elevation: 5,
                            shadowColor: greyColor.withOpacity(0.15),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8)),
                            child: ListTile(
                              leading: Container(
                                alignment: Alignment.center,
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color:
                                        primaryLighterColor.withOpacity(0.1)),
                                child: Image.asset(
                                  'assets/images/ic_certificate.png',
                                  width: 16,
                                  height: 16,
                                  color: primaryLighterColor,
                                ),
                              ),
                              title: Text(
                                (_userData['certificate_name']
                                    as List<dynamic>)[index],
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                              subtitle: Text(
                                '${(_userData['certificate_instansi'] as List<dynamic>)[index]} . ${(_userData['certificate_date'] as List<dynamic>)[index]}',
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontSize: 10,
                                ),
                              ),
                              trailing: Icon(
                                Icons.edit,
                                size: 12,
                                color: primaryColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    InkWell(
                      onTap: () => Navigator.of(context)
                          .pushNamed(AddUserCertificateScreen.routeName),
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: primaryLighterColor,
                        ),
                        child: ListTile(
                          leading: Container(
                            alignment: Alignment.center,
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.white),
                            child: Image.asset(
                              'assets/images/ic_certificate.png',
                              width: 16,
                              height: 16,
                            ),
                          ),
                          title: Text(
                            'Tambahkan Sertifikasi Lainnya',
                            style: TextStyle(
                                fontFamily: 'Kayak',
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Colors.white),
                          ),
                          subtitle: Text(
                            'Sertifikasi membantu Anda memperoleh pekerjaan lebih cepat!',
                            style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 10,
                                color: Colors.white),
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
                    const SizedBox(
                      height: 16,
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
