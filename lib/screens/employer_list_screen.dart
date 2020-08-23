import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/applied_job.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/provider/vacancies.dart';
import 'package:kerjakanapp/screens/open_job_screen.dart';
import 'package:kerjakanapp/screens/vecancy_detail_screen.dart';
import 'package:kerjakanapp/widgets/item_job.dart';
import 'package:kerjakanapp/widgets/item_jobseeker.dart';
import 'package:provider/provider.dart';

import '../const.dart';

class EmployerList extends StatefulWidget {
  final Function changeCollapseStatus;

  EmployerList({this.changeCollapseStatus});

  @override
  _EmployerListState createState() => _EmployerListState();
}

class _EmployerListState extends State<EmployerList> {
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
    final _listNearbyJobSeeker =
        Provider.of<NearbyJobSeeker>(context, listen: false).items;
    return Scaffold(
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
                    ),
                    onPressed: widget.changeCollapseStatus,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 16.0),
                    child: Image.asset(
                      'assets/images/ic_paper_done.png',
                      width: 10.29,
                      height: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Daftar Lowongan',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Kayak',
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Lowongan Pekerjaan',
                  style: titleStyle,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Text(
                  'Daftar lowongan pekerjaan yang Anda buat',
                  style: descStyle,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              InkWell(
                onTap: () =>
                    Navigator.of(context).pushNamed(OpenJobScreen.routeName),
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
                                  child: _listVacancy[index].jobCategory ==
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
                                          : _listVacancy[index].jobCategory ==
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
                                            : _listVacancy[index].jobCategory ==
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
                                                                height: 12,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.all(2),
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: primaryLighterColor,
                                            ),
                                            child: Image.asset(
                                                'assets/images/avatar_a.png'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.all(2),
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: primaryLighterColor,
                                            ),
                                            child: Image.asset(
                                                'assets/images/avatar_c.png'),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.all(4),
                                            margin: const EdgeInsets.all(2),
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: primaryLighterColor,
                                            ),
                                            child: Image.asset(
                                                'assets/images/avatar_a.png'),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.all(2),
                                            height: 20,
                                            width: 20,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: primaryLighterColor
                                                  .withOpacity(0.1),
                                            ),
                                            child: Center(
                                              child: Text(
                                                '+2',
                                                style: TextStyle(
                                                  fontSize: 8,
                                                  fontFamily: 'Kayak',
                                                  color: primaryLighterColor,
                                                  fontWeight: FontWeight.bold,
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
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Riwayat Kontak Pekerja',
                      style: titleStyle,
                    ),
                    const Text(
                      'Lihat Semua',
                      style: TextStyle(
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: primaryColor),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Text(
                  'RDaftar profil yang Anda hubungi',
                  style: descStyle,
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context, index) =>
                      ItemJobSeeker(_listNearbyJobSeeker[index]),
                  itemCount: 2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
