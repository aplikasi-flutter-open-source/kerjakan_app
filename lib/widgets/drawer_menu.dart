import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/edit_profil_job_seeker_screen.dart';
import 'package:provider/provider.dart';

class DrawerMenu extends StatelessWidget {
  final Function changeUserStatus;
  final String userStatus;
  final Function changeMenu;
  final String activeMenu;
  final Function changeCollapse;
  final bool isWorking;
  final Function changeWorkingStatus;

  DrawerMenu({
    @required this.changeUserStatus,
    @required this.userStatus,
    @required this.changeMenu,
    @required this.activeMenu,
    @required this.changeCollapse,
    @required this.isWorking,
    @required this.changeWorkingStatus,
  });
  @override
  Widget build(BuildContext context) {
    final _userData = Provider.of<UserData>(context, listen: false).userData;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 64),
      child: Align(
        alignment: Alignment.centerLeft,
        child: SizedBox(
          width: 150,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 64,
                    ),
                    Container(
                      height: 56,
                      width: 56,
                      padding: const EdgeInsets.all(8),
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
                      height: 16,
                    ),
                    Text(
                      _userData['name'],
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontFamily: 'Kayak'),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    if (_userData['mode'] == 'Mencari Pekerjaan')
                      InkWell(
                        onTap: changeWorkingStatus,
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: isWorking ? accentColor : Color(0xFFFBBF12),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                isWorking ? 'Menerima Kerja' : 'Tidak Bekerja',
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Ganti',
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    if (_userData['mode'] == 'Mencari Pekerjaan')
                      const SizedBox(
                        height: 16,
                      ),
                    if (_userData['mode'] == 'Mencari Pekerjaan')
                      const Divider(
                        color: Colors.white,
                      ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        changeMenu('home');
                        changeCollapse();
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: activeMenu == 'home'
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/ic_house.png',
                              width: 8,
                              height: 8,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Beranda',
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        changeMenu('job');
                        changeCollapse();
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: activeMenu == 'job'
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/ic_nav_list.png',
                              width: 8,
                              height: 6,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Daftar Pekerjaan',
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    InkWell(
                      onTap: () {
                        changeMenu('profile');
                        changeCollapse();
                      },
                      child: Container(
                        width: 150,
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: activeMenu == 'profile'
                              ? primaryColor
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Image.asset(
                              'assets/images/ic_personal.png',
                              width: 8,
                              height: 12,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            const Text(
                              'Profil',
                              style: TextStyle(
                                fontFamily: 'Kayak',
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () => Navigator.of(context)
                        .pushNamed(EditProfileJobSeekerScreen.routeName),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Pengaturan Akun',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  InkWell(
                    onTap: () =>
                        Provider.of<Auth>(context, listen: false).logOut(),
                    child: Container(
                      width: 150,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        'Keluar',
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
