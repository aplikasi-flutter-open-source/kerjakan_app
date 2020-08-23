import 'package:flutter/material.dart';
import 'package:kerjakanapp/const.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/screens/finish_apply_job_screen.dart';
import 'package:kerjakanapp/screens/give_rating_screen.dart';
import 'package:kerjakanapp/widgets/rating_star.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class JobSeekerDetailScreen extends StatefulWidget {
  static const String routeName = '/job-seeker-detail-screen';

  @override
  _JobSeekerDetailScreenState createState() => _JobSeekerDetailScreenState();
}

class _JobSeekerDetailScreenState extends State<JobSeekerDetailScreen> {
  JobSeeker jobSeeker;

  var _isInit = true;
  Map<String, dynamic> jobSeekerData = {
    'address': '',
    'email': '',
    'work_tools': '',
    'education_department': null,
    'education_place': null,
    'education_year': null,
    'certificate_name': null,
    'certificate_instansi': null,
    'certificate_date': null,
    'last_comment': null,
    'last_comment_by': null,
    'description': null,
    'phone_number': '',
    'las_comment_photo': null,
    'rating': 0,
  };

  @override
  void didChangeDependencies() {
    if (_isInit) {
      jobSeeker = ModalRoute.of(context).settings.arguments as JobSeeker;

      Provider.of<NearbyJobSeeker>(context, listen: false)
          .fetchJobSeekerById(jobSeeker.id.toString())
          .then((value) {
        setState(() {
          jobSeekerData = Provider.of<NearbyJobSeeker>(context, listen: false)
              .jobSeekerData;
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
                          "Detail Pekerja",
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
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                          child: jobSeeker.photoUrl == 'a'
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: primaryLighterColor,
                                  ),
                                  padding: const EdgeInsets.all(12),
                                  height: 73,
                                  width: 73,
                                  child: Image.asset(
                                    'assets/images/avatar_a.png',
                                  ),
                                )
                              : jobSeeker.photoUrl == 'b'
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: primaryLighterColor,
                                      ),
                                      padding: const EdgeInsets.all(12),
                                      height: 73,
                                      width: 73,
                                      child: Image.asset(
                                        'assets/images/avatar_b.png',
                                      ),
                                    )
                                  : jobSeeker.photoUrl == 'c'
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(16),
                                            color: primaryLighterColor,
                                          ),
                                          padding: const EdgeInsets.all(12),
                                          height: 73,
                                          width: 73,
                                          child: Image.asset(
                                            'assets/images/avatar_c.png',
                                          ),
                                        )
                                      : jobSeeker.photoUrl == 'd'
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                color: primaryLighterColor,
                                              ),
                                              padding: const EdgeInsets.all(12),
                                              height: 73,
                                              width: 73,
                                              child: Image.asset(
                                                'assets/images/avatar_c.png',
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                height: 73,
                                                width: 73,
                                                child: Image.network(
                                                  jobSeeker.photoUrl,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -15,
                          child: Stack(
                            children: [
                              Image.asset(
                                'assets/images/ic_banner.png',
                                width: 30,
                                height: 24,
                              ),
                              Positioned.fill(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: jobSeeker.jobCategory == 'Home'
                                      ? Image.asset(
                                          'assets/images/ic_house.png',
                                          width: 12,
                                          height: 12,
                                        )
                                      : jobSeeker.jobCategory == 'Auto'
                                          ? Image.asset(
                                              'assets/images/ic_auto.png',
                                              width: 12,
                                              height: 12,
                                            )
                                          : jobSeeker.jobCategory == 'Leisure'
                                              ? Image.asset(
                                                  'assets/images/ic_leisure.png',
                                                  width: 12,
                                                  height: 12,
                                                )
                                              : jobSeeker.jobCategory == 'Other'
                                                  ? Image.asset(
                                                      'assets/images/ic_other.png',
                                                      width: 12,
                                                      height: 12,
                                                    )
                                                  : jobSeeker.jobCategory ==
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
                        )
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          jobSeeker.name,
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        RatingStar(jobSeekerData['rating']),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          jobSeekerData['address'],
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 10,
                              color: Colors.grey),
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          jobSeekerData['email'],
                          style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 10,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                if (jobSeekerData['description'] != null)
                  Text(
                    jobSeekerData['description'],
                    style: TextStyle(fontFamily: 'Kayak'),
                  ),
                const SizedBox(
                  height: 16,
                ),
                if (jobSeekerData['last_comment'] != null)
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Color(0xFFF5F8FD)),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: jobSeekerData['las_comment_photo'] == 'a'
                              ? Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: primaryLighterColor,
                                  ),
                                  padding: const EdgeInsets.all(4),
                                  height: 32,
                                  width: 32,
                                  child: Image.asset(
                                    'assets/images/avatar_a.png',
                                  ),
                                )
                              : jobSeekerData['las_comment_photo'] == 'b'
                                  ? Container(
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
                                    )
                                  : jobSeekerData['las_comment_photo'] == 'c'
                                      ? Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            color: primaryLighterColor,
                                          ),
                                          padding: const EdgeInsets.all(4),
                                          height: 32,
                                          width: 32,
                                          child: Image.asset(
                                            'assets/images/avatar_c.png',
                                          ),
                                        )
                                      : jobSeekerData['las_comment_photo'] ==
                                              'd'
                                          ? Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                color: primaryLighterColor,
                                              ),
                                              padding: const EdgeInsets.all(4),
                                              height: 32,
                                              width: 32,
                                              child: Image.asset(
                                                'assets/images/avatar_c.png',
                                              ),
                                            )
                                          : ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4)),
                                                height: 32,
                                                width: 32,
                                                child: Image.network(
                                                  jobSeekerData[
                                                      'las_comment_photo'],
                                                  fit: BoxFit.cover,
                                                ),
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
                                    jobSeekerData['rating'].toString(),
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
                                jobSeekerData['last_comment_by'],
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
                                jobSeekerData['last_comment'],
                                style: TextStyle(
                                  fontFamily: 'Kayak',
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                if (jobSeekerData['last_comment'] != null)
                  const SizedBox(
                    height: 16,
                  ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed(
                      GiveRatingScreen.routeName,
                      arguments: jobSeeker),
                  child: Container(
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
                        child: Icon(
                          Icons.star,
                          size: 16,
                          color: Color(0xFFFBBF12),
                        ),
                      ),
                      title: Text(
                        'Pernah bekerja bersama Amira? Berikan Ulasan',
                        style: TextStyle(
                            fontFamily: 'Kayak',
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Colors.white),
                      ),
                      subtitle: Text(
                        'Ulasan yang Anda berikan sangat berarti bagi para pekerja',
                        style: TextStyle(
                            fontFamily: 'Kayak',
                            fontSize: 8,
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
                Text(
                  'Keahlian',
                  style: titleStyle,
                ),
                const SizedBox(
                  height: 8,
                ),
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.all(4.0),
                  itemCount: jobSeeker.skills.length,
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
                        jobSeeker.skills[index],
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
                if (jobSeekerData['work_tools'] != null)
                  const Text(
                    'Alat Pekerja',
                    style: titleStyle,
                  ),
                if (jobSeekerData['work_tools'] != null)
                  const SizedBox(
                    height: 8,
                  ),
                if (jobSeekerData['work_tools'] != null)
                  Text(
                    jobSeekerData['work_tools'],
                    style: TextStyle(
                      fontFamily: 'Kayak',
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
                if (jobSeekerData['work_tools'] != null)
                  const SizedBox(
                    height: 16,
                  ),
                if (jobSeekerData['education_place'] != null)
                  const Text(
                    'Riwayat Pendidikan',
                    style: titleStyle,
                  ),
                if (jobSeekerData['education_place'] != null)
                  const SizedBox(
                    height: 8,
                  ),
                if (jobSeekerData['education_place'] != null)
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        (jobSeekerData['education_place'] as List<dynamic>)
                            .length,
                    itemBuilder: (context, index) => Card(
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
                              color: primaryLighterColor.withOpacity(0.1)),
                          child: Image.asset(
                            'assets/images/ic_education.png',
                            width: 16,
                            height: 16.8,
                            color: primaryLighterColor,
                          ),
                        ),
                        title: Text(
                          (jobSeekerData['education_place']
                              as List<dynamic>)[index],
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          '${(jobSeekerData['education_department'] as List<dynamic>)[index]} . ${(jobSeekerData['education_year'] as List<dynamic>)[index]}',
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
                if (jobSeekerData['education_place'] != null)
                  const SizedBox(
                    height: 16,
                  ),
                if (jobSeekerData['certificate_name'] != null)
                  const Text(
                    'Sertifikasi',
                    style: titleStyle,
                  ),
                if (jobSeekerData['certificate_name'] != null)
                  const SizedBox(
                    height: 8,
                  ),
                if (jobSeekerData['certificate_name'] != null)
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount:
                        (jobSeekerData['certificate_name'] as List<dynamic>)
                            .length,
                    itemBuilder: (context, index) => Card(
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
                              color: primaryLighterColor.withOpacity(0.1)),
                          child: Image.asset(
                            'assets/images/ic_certificate.png',
                            width: 16,
                            height: 16,
                            color: primaryLighterColor,
                          ),
                        ),
                        title: Text(
                          (jobSeekerData['certificate_name']
                              as List<dynamic>)[index],
                          style: TextStyle(
                            fontFamily: 'Kayak',
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        subtitle: Text(
                          '${(jobSeekerData['certificate_instansi'] as List<dynamic>)[index]} . ${(jobSeekerData['certificate_date'] as List<dynamic>)[index]}',
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
                if (jobSeekerData['certificate_name'] != null)
                  const SizedBox(
                    height: 16,
                  ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFF5F8FD),
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            jobSeeker.name,
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          RatingStar(jobSeekerData['rating']),
                        ],
                      ),
                      Container(
                        width: 112,
                        height: 40,
                        margin: const EdgeInsets.only(bottom: 16),
                        child: FlatButton(
                          color: primaryColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16)),
                          onPressed: () {
                            launch(
                                'https://api.whatsapp.com/send?phone=${jobSeekerData['phone_number']}&text=Halo%20${jobSeeker.name}');
                          },
                          child: Text(
                            'Hubungi',
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
