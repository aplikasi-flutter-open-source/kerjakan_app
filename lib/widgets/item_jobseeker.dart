import 'package:flutter/material.dart';
import 'package:kerjakanapp/provider/nearby_job.dart';
import 'package:kerjakanapp/provider/nearby_jobseeker.dart';
import 'package:kerjakanapp/screens/job_detail_screen.dart';
import 'package:kerjakanapp/screens/job_seeker_detail_screen.dart';
import 'package:kerjakanapp/widgets/rating_star.dart';

import '../const.dart';

class ItemJobSeeker extends StatelessWidget {
  final JobSeeker jobSeeker;

  ItemJobSeeker(this.jobSeeker);
  @override
  Widget build(BuildContext context) {
    print('jobSeeker.photoUrl ${jobSeeker.photoUrl}');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Card(
        elevation: 5,
        shadowColor: greyColor.withOpacity(0.15),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () => Navigator.of(context)
              .pushNamed(JobSeekerDetailScreen.routeName, arguments: jobSeeker),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  overflow: Overflow.visible,
                  children: [
                    Container(
                      child: jobSeeker.photoUrl == 'a'
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
                          : jobSeeker.photoUrl == 'b'
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
                              : jobSeeker.photoUrl == 'c'
                                  ? Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: primaryLighterColor,
                                      ),
                                      padding: const EdgeInsets.all(4),
                                      height: 32,
                                      width: 32,
                                      child: Image.asset(
                                        'assets/images/avatar_c.png',
                                      ),
                                    )
                                  : jobSeeker.photoUrl == 'd'
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
                                                    BorderRadius.circular(4)),
                                            height: 32,
                                            width: 32,
                                            child: Image.network(
                                              jobSeeker.photoUrl,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: -10,
                      child: Stack(
                        children: [
                          Image.asset(
                            'assets/images/ic_banner.png',
                            width: 20,
                            height: 16,
                          ),
                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.center,
                              child: jobSeeker.jobCategory == 'Home'
                                  ? Image.asset(
                                      'assets/images/ic_house.png',
                                      width: 8,
                                      height: 8,
                                    )
                                  : jobSeeker.jobCategory == 'Auto'
                                      ? Image.asset(
                                          'assets/images/ic_auto.png',
                                          width: 8,
                                          height: 8,
                                        )
                                      : jobSeeker.jobCategory == 'Leisure'
                                          ? Image.asset(
                                              'assets/images/ic_leisure.png',
                                              width: 8,
                                              height: 8,
                                            )
                                          : jobSeeker.jobCategory == 'Other'
                                              ? Image.asset(
                                                  'assets/images/ic_other.png',
                                                  width: 8,
                                                  height: 8,
                                                )
                                              : jobSeeker.jobCategory ==
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
                    )
                  ],
                ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            jobSeeker.name,
                            style: TextStyle(
                              fontFamily: 'Kayak',
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          RatingStar(jobSeeker.rating),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Keahlian',
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 10,
                          fontFamily: 'Kayak',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 36,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: jobSeeker.skills.length > 3
                              ? 4
                              : jobSeeker.skills.length,
                          itemBuilder: (context, index) => Container(
                            margin: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: primaryLighterColor.withOpacity(0.1)),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8),
                            height: 36,
                            child: index < 3
                                ? Text(
                                    jobSeeker.skills[index],
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontSize: 10,
                                      color: primaryLighterColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  )
                                : Text(
                                    '+ ${jobSeeker.skills.length - 3} More',
                                    style: TextStyle(
                                      fontFamily: 'Kayak',
                                      fontSize: 10,
                                      color: primaryLighterColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
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
