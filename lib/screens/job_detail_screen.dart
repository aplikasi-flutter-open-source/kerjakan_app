import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/applied_job.dart';
import 'package:kerjakanapp/provider/auth.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/provider/user_data.dart';
import 'package:kerjakanapp/screens/finish_apply_job_screen.dart';
import 'package:kerjakanapp/widgets/rating_star.dart';
import 'package:provider/provider.dart';

class JobDetailScreen extends StatefulWidget {
  static const String routeName = '/job-detail-screen';

  @override
  _JobDetailScreenState createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  var _isInit = true;
  String employerName = '';
  String employerPhoto = 'a';
  int employerRating = 0;
  Job _job;
  var _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      _job = ModalRoute.of(context).settings.arguments;

      Provider.of<NearbyJobs>(context, listen: false)
          .fetchEmployerById(_job.jobEmployerId.toString())
          .then((value) {
        setState(() {
          employerName = value['name'];
          employerPhoto = value['photo_url'];
          employerRating = value['rating'];
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  Future<void> _apply() async {
    print(_job.jobId);

    final userData = Provider.of<UserData>(context, listen: false).userData;
    final prevApplyData = userData['applied_job'] as List<dynamic>;
    prevApplyData.add(_job.jobId);

    final id = Provider.of<Auth>(context, listen: false).id;

    try {
      setState(() {
        _isLoading = true;
      });
      Provider.of<AppliedJob>(context, listen: false).requestApplyJob(
          id, prevApplyData, _job.jobId.toString(), _job.appliedUser);
    } catch (error) {
      throw error;
    }

    setState(() {
      _isLoading = false;
    });

    Navigator.of(context).pushNamed(FinishApplyJobScreen.routeName);
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
                          "Detail Pekerjaan",
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
                    child: _job.jobCategory == 'Home'
                        ? Image.asset(
                            'assets/images/placeholder_home.png',
                            fit: BoxFit.cover,
                          )
                        : _job.jobCategory == 'Self Care'
                            ? Image.asset(
                                'assets/images/placeholder_self_care.png',
                                fit: BoxFit.cover,
                              )
                            : _job.jobCategory == 'Auto'
                                ? Image.asset(
                                    'assets/images/placeholder_auto.png',
                                    fit: BoxFit.cover,
                                  )
                                : _job.jobCategory == 'Other'
                                    ? Image.asset(
                                        'assets/images/placeholder_other.png',
                                        fit: BoxFit.cover,
                                      )
                                    : _job.jobCategory == 'Leisure'
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
                      color: primaryColor,
                    ),
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: _job.jobCategory == 'Home'
                            ? Image.asset(
                                'assets/images/ic_house.png',
                                width: 12,
                                height: 12,
                              )
                            : _job.jobCategory == 'Auto'
                                ? Image.asset(
                                    'assets/images/ic_auto.png',
                                    width: 12,
                                    height: 12,
                                  )
                                : _job.jobCategory == 'Leisure'
                                    ? Image.asset(
                                        'assets/images/ic_leisure.png',
                                        width: 12,
                                        height: 12,
                                      )
                                    : _job.jobCategory == 'Other'
                                        ? Image.asset(
                                            'assets/images/ic_other.png',
                                            width: 12,
                                            height: 12,
                                          )
                                        : _job.jobCategory == 'Self Care'
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
                  _job.jobTitle,
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
                  _job.uploadDate,
                  style: TextStyle(
                      fontSize: 10, fontFamily: 'Kayak', color: Colors.grey),
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  _job.jobDesc,
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
                      _job.jobAddress,
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
                  itemCount: _job.jobSkills.length,
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
                        _job.jobSkills[index],
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
                  itemCount: _job.jobTools.length,
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
                        _job.jobTools[index] == 'null'
                            ? 'Alat kerja disediakan oleh pencari jasa'
                            : _job.jobTools[index],
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
                const Text(
                  'Employer',
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: 'Kayak',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Container(
                      child: employerPhoto == 'a'
                          ? Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: primaryLighterColor,
                              ),
                              padding: const EdgeInsets.all(4),
                              height: 40,
                              width: 40,
                              child: Image.asset(
                                'assets/images/avatar_a.png',
                              ),
                            )
                          : employerPhoto == 'b'
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: primaryLighterColor,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  height: 40,
                                  width: 40,
                                  child: Image.asset(
                                    'assets/images/avatar_b.png',
                                  ),
                                )
                              : employerPhoto == 'c'
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        color: primaryLighterColor,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      height: 40,
                                      width: 40,
                                      child: Image.asset(
                                        'assets/images/avatar_c.png',
                                      ),
                                    )
                                  : employerPhoto == 'd'
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: primaryLighterColor,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          height: 40,
                                          width: 40,
                                          child: Image.asset(
                                            'assets/images/avatar_c.png',
                                          ),
                                        )
                                      : ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Container(
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            height: 40,
                                            width: 40,
                                            child: Image.network(
                                              employerPhoto,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          employerName,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.black,
                            fontFamily: 'Kayak',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        RatingStar(employerRating),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Color(0xFFF5F8FD),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Rp. ${oCcy.format(_job.jobSalary)},-',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'Kayak',
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Per ${_job.timeSalary}',
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Kayak',
                                color: Colors.grey),
                          ),
                        ],
                      ),
                      Container(
                        width: 112,
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
                                onPressed: _apply,
                                child: Text(
                                  'Ajukan',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
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
