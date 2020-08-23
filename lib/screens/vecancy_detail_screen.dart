import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/applied_user.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/screens/finish_apply_job_screen.dart';
import 'package:kerjakanapp/widgets/item_jobseeker.dart';
import 'package:kerjakanapp/widgets/rating_star.dart';
import 'package:provider/provider.dart';

class VacancyDetailScreen extends StatefulWidget {
  static const String routeName = '/vacancy-detail-screen';

  @override
  _VacancyDetailScreenState createState() => _VacancyDetailScreenState();
}

class _VacancyDetailScreenState extends State<VacancyDetailScreen> {
  var _isInit = true;

  Job _vacancyData;
  List<JobSeeker> _listAppliedUser = [];

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _vacancyData = ModalRoute.of(context).settings.arguments;
      Provider.of<AppliedUser>(context, listen: false)
          .fetchAppliedUser(_vacancyData.appliedUser)
          .then((value) {
        setState(() {
          _listAppliedUser =
              Provider.of<AppliedUser>(context, listen: false).items;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        child: Text(
                          'Detail Lowongan',
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
                SizedBox(
                  width: double.infinity,
                  height: 162,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: _vacancyData.jobCategory == 'Home'
                        ? Image.asset(
                            'assets/images/placeholder_home.png',
                            fit: BoxFit.cover,
                          )
                        : _vacancyData.jobCategory == 'Self Care'
                            ? Image.asset(
                                'assets/images/placeholder_self_care.png',
                                fit: BoxFit.cover,
                              )
                            : _vacancyData.jobCategory == 'Auto'
                                ? Image.asset(
                                    'assets/images/placeholder_auto.png',
                                    fit: BoxFit.cover,
                                  )
                                : _vacancyData.jobCategory == 'Other'
                                    ? Image.asset(
                                        'assets/images/placeholder_other.png',
                                        fit: BoxFit.cover,
                                      )
                                    : _vacancyData.jobCategory == 'Leisure'
                                        ? Image.asset(
                                            'assets/images/placeholder_leisure.png',
                                            fit: BoxFit.cover,
                                          )
                                        : null,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/ic_banner.png',
                      width: 30,
                      height: 24,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: _vacancyData.jobCategory == 'Home'
                            ? Image.asset(
                                'assets/images/ic_house.png',
                                width: 12,
                                height: 21,
                              )
                            : _vacancyData.jobCategory == 'Auto'
                                ? Image.asset(
                                    'assets/images/ic_auto.png',
                                    width: 12,
                                    height: 12,
                                  )
                                : _vacancyData.jobCategory == 'Leisure'
                                    ? Image.asset(
                                        'assets/images/ic_leisure.png',
                                        width: 12,
                                        height: 12,
                                      )
                                    : _vacancyData.jobCategory == 'Other'
                                        ? Image.asset(
                                            'assets/images/ic_other.png',
                                            width: 12,
                                            height: 12,
                                          )
                                        : _vacancyData.jobCategory ==
                                                'Self Care'
                                            ? Image.asset(
                                                'assets/images/ic_personal.png',
                                                width: 12,
                                                height: 14,
                                              )
                                            : null,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  _vacancyData.jobTitle,
                  style: TextStyle(
                    fontFamily: 'Kayak',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  _vacancyData.uploadDate,
                  style: TextStyle(
                      fontSize: 10, fontFamily: 'Kayak', color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  _vacancyData.jobDesc,
                  style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'Kayak',
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_address.png',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      _vacancyData.jobAddress,
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Kayak',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Image.asset(
                      'assets/images/ic_credit_card.png',
                      width: 12,
                      height: 12,
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Text(
                      'Rp. ${oCcy.format(_vacancyData.jobSalary)},-/ ${_vacancyData.timeSalary}',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'Kayak',
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Keahlian Dibutuhkan',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Kayak',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4.0),
                  itemCount: _vacancyData.jobSkills.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 6 / 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      height: 36,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: primaryLighterColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        _vacancyData.jobSkills[index],
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          color: primaryLighterColor,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                const Text(
                  'Alat Kerja',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Kayak',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4.0),
                  itemCount: _vacancyData.jobTools.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 9 / 2,
                    crossAxisSpacing: 4,
                    mainAxisSpacing: 4,
                  ),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      height: 36,
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                          color: primaryLighterColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        _vacancyData.jobTools[index] == 'null'
                            ? 'Alat kerja disediakan oleh pencari jasa'
                            : _vacancyData.jobTools[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontFamily: 'Kayak',
                          color: primaryLighterColor,
                          fontSize: 10,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                if (_listAppliedUser.length != 0)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(8),
                    color: Color(0xFFF5F8FD),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Applicant',
                          style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Kayak',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) =>
                              ItemJobSeeker(_listAppliedUser[index]),
                          itemCount: _listAppliedUser.length,
                        ),
                      ],
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
